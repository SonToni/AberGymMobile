package htl.abergymmobile.db.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class WorkoutExercise {
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    public Integer sets;

    @Column
    public Double weight;

    @Column
    public Integer reps;

    @Column
    public Double time;

    //Navigation

    @ManyToOne
    @JoinColumn(name="workoutplan_id", nullable=false)
    public Workoutplan workoutplan;

    @ManyToOne
    @JoinColumn(name="exercise_id", nullable=false)
    public Exercise exercise;
}
