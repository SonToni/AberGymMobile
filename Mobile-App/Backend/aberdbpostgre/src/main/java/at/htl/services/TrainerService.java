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
import at.htl.entities.Trainer;
@Path("trainers")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class TrainerService {

    @GET
    public List<Trainer> get() {
        return Trainer.listAll(Sort.by("id"));
    }

    @GET
    @Path("{id}")
    public Trainer getSingle(@PathParam Long id) {
        Trainer entity = Trainer.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainer with id of " + id + " does not exist.", 404);
        }
        return entity;
    }

    @POST
    @Transactional
    public Response create(Trainer trainer) {
        if (trainer.id != null) {
            throw new WebApplicationException("Id was invalidly set on request.", 422);
        }
        trainer.persist();
        return Response.ok(trainer).status(201).build();
    }

    @PUT
    @Path("{id}")
    @Transactional
    public Trainer update(@PathParam Long id, Trainer trainer) {
        if (trainer.firstName == null) {
            throw new WebApplicationException("Trainer Name was not set on request.", 422);
        }
        if (trainer.lastName == null) {
            throw new WebApplicationException("Trainer last name was not set on request.", 422);
        }
        if (trainer.email == null) {
            throw new WebApplicationException("Trainer email was not set on request.", 422);
        }
        Trainer entity = Trainer.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainer with id of " + id + " does not exist.", 404);
        }
        entity.firstName = trainer.firstName;
        entity.lastName = trainer.lastName;
        entity.email = trainer.email;
        return entity;
    }

    @DELETE
    @Path("{id}")
    @Transactional
    public Response delete(@PathParam Long id) {
        Trainer entity = Trainer.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainer with id of " + id + " does not exist.", 404);
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
