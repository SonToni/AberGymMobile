package htl.abergymmobile.db.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class Workoutplan {
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    public String name;

    //Navigation

    @ManyToOne
    @JoinColumn(name="trainee_id", nullable=false)
    public Trainee trainee;

    @OneToMany(mappedBy = "workoutplan", fetch = FetchType.EAGER)
    public Set<WorkoutExercise> workoutExcersices = new HashSet<>();

    /*@ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "WorkoutExcersice", // name of the association table
            joinColumns = @JoinColumn(name = "workoutplan_id"), // foreign key columns
            inverseJoinColumns = @JoinColumn(name = "exercise_id"))
    private Set<Exercise> exercise;*/
}
