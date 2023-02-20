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
import at.htl.entities.Exercise;
@Path("exercises")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class ExerciseService {

    @GET
    public List<Exercise> get() {
        return Exercise.listAll(Sort.by("id"));
    }

    @GET
    @Path("{id}")
    public Exercise getSingle(@PathParam Long id) {
        Exercise entity = Exercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Exercise with id of " + id + " does not exist.", 404);
        }
        return entity;
    }

    @POST
    @Transactional
    public Response create(Exercise exercise) {
        if (exercise.id != null) {
            throw new WebApplicationException("Id was invalidly set on request.", 422);
        }
        exercise.persist();
        return Response.ok(exercise).status(201).build();
    }

    @PUT
    @Path("{id}")
    @Transactional
    public Exercise update(@PathParam Long id, Exercise exercise) {
        if (exercise.name == null) {
            throw new WebApplicationException("Exercise Name was not set on request.", 422);
        }
        if (exercise.muscleGroup == null) {
            throw new WebApplicationException("Exercise muscle was not set on request.", 422);
        }
        Exercise entity = Exercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Exercise with id of " + id + " does not exist.", 404);
        }
        entity.name = exercise.name;
        entity.muscleGroup = exercise.muscleGroup;
        entity.description = exercise.description;
        return entity;
    }

    @DELETE
    @Path("{id}")
    @Transactional
    public Response delete(@PathParam Long id) {
        Exercise entity = Exercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Exercise with id of " + id + " does not exist.", 404);
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
