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

import at.htl.entities.WorkoutExercise;
import org.jboss.resteasy.annotations.jaxrs.PathParam;
import io.quarkus.panache.common.Sort;
@Path("workoutexercises")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class WorkoutExerciseService {

    @GET
    public List<WorkoutExercise> get() {
        return WorkoutExercise.listAll(Sort.by("id"));
    }

    @GET
    @Path("{id}")
    public WorkoutExercise getSingle(@PathParam Long id) {
        WorkoutExercise entity = WorkoutExercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("WorkoutExercise with id of " + id + " does not exist.", 404);
        }
        return entity;
    }

    @POST
    @Transactional
    public Response create(WorkoutExercise workoutexercise) {
        if (workoutexercise.id != null) {
            throw new WebApplicationException("id was invalidly set on request.", 422);
        }
        workoutexercise.persist();
        return Response.ok(workoutexercise).status(201).build();
    }

    @PUT
    @Path("{id}")
    @Transactional
    public WorkoutExercise update(@PathParam Long id, WorkoutExercise workoutexercise) {
        WorkoutExercise entity = WorkoutExercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Exercise with id of " + id + " does not exist.", 404);
        }
        entity.sets = workoutexercise.sets;
        entity.weight = workoutexercise.weight;
        entity.reps = workoutexercise.reps;
        entity.time = workoutexercise.time;

        return entity;
    }

    @DELETE
    @Path("{id}")
    @Transactional
    public Response delete(@PathParam Long id) {
        WorkoutExercise entity = WorkoutExercise.findById(id);
        if (entity == null) {
            throw new WebApplicationException("Workoutexercise with id of " + id + " does not exist.", 404);
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
