package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
@Entity
public class WorkoutExercise extends PanacheEntityBase{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column
    public Integer sets;

    @Column
    public Double weight;

    @Column
    public Integer reps;

    @Column
    public Double time;

    public WorkoutExercise(){
    }


    @ManyToOne()
    @JoinColumn(name="exercise_id", nullable=false)
    public Exercise exercise;
    @JsonbTransient
    @ManyToOne
    @JoinColumn(name="workoutplan_id", nullable=false)
    public Workoutplan workoutplan;

}
