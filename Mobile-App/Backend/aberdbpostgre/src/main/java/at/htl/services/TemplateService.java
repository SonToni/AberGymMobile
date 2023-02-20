package at.htl.services;

import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.json.Json;
import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.jboss.resteasy.annotations.jaxrs.PathParam;
import io.quarkus.panache.common.Sort;
import at.htl.entities.Template;
@Path("templates")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class TemplateService {

    @GET
    public List<Template> get() {
        return Template.listAll(Sort.by("id"));
    }

    @GET
    @Path("{id}")
    public Template getSingle(@PathParam Long id) {
        Template entity = Template.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Template with id of " + id + " does not exist.", 404);
        }
        return entity;
    }

    @POST
    @Transactional
    public Response create(Template template) {
        if (template.id != null) {
            throw new WebApplicationException("Id was invalidly set on request.", 422);
        }
        template.persist();
        return Response.ok(template).status(201).build();
    }

    @PUT
    @Path("{id}")
    @Transactional
    public Template update(@PathParam Long id, Template template) {
        if (template.name == null) {
            throw new WebApplicationException("Template Name was not set on request.", 422);
        }
        Template entity = Template.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Template with id of " + id + " does not exist.", 404);
        }
        entity.name = template.name;
        return entity;
    }

    @DELETE
    @Path("{id}")
    @Transactional
    public Response delete(@PathParam Long id) {
        Template entity = Template.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Template with id of " + id + " does not exist.", 404);
        }
        entity.delete();
        return Response.status(204).build();
    }

    @Provider
    public static class ErrorMapper implements ExceptionMapper<Exception> {
        @Override
        public Response toResponse(Exception exception) {
            int code = 500;
            if (exception instanceof WebApplicationException) {
                code = ((WebApplicationException) exception).getResponse().getStatus();
            }
            return Response.status(code)
                    .entity(Json.createObjectBuilder().add("error", exception.getMessage()).add("code", code).build())
                    .build();
        }
    }
}
