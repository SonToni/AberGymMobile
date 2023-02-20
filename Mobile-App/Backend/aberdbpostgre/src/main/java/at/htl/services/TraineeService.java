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
import at.htl.entities.Trainee;
@Path("trainees")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class TraineeService {

    @GET
    public List<Trainee> get() {
        return Trainee.listAll(Sort.by("id"));
    }

    @GET
    @Path("{id}")
    public Trainee getSingle(@PathParam Long id) {
        Trainee entity = Trainee.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainee with id of " + id + " does not exist.", 404);
        }
        return entity;
    }

    @POST
    @Transactional
    public Response create(Trainee trainee) {
        if (trainee.id != null) {
            throw new WebApplicationException("Id was invalidly set on request.", 422);
        }
        trainee.persist();
        return Response.ok(trainee).status(201).build();
    }

    @PUT
    @Path("{id}")
    @Transactional
    public Trainee update(@PathParam Long id, Trainee trainee) {
        if (trainee.firstName == null) {
            throw new WebApplicationException("Trainee first name was not set on request.", 422);
        }
        if (trainee.lastName == null) {
            throw new WebApplicationException("Trainee last name was not set on request.", 422);
        }
        if (trainee.email == null) {
            throw new WebApplicationException("Trainee email was not set on request.", 422);
        }
        Trainee entity = Trainee.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainee with id of " + id + " does not exist.", 404);
        }
        entity.firstName = trainee.firstName;
        entity.lastName = trainee.lastName;
        entity.email = trainee.email;
        return entity;
    }

    @DELETE
    @Path("{id}")
    @Transactional
    public Response delete(@PathParam Long id) {
        Trainee entity = Trainee.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Trainee with id of " + id + " does not exist.", 404);
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
