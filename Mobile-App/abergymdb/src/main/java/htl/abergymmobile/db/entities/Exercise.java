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
public class Exercise {
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    public String name;

    @Column(name = "muscle_group")
    public String muscleGroup;

    //Navigation

    @OneToMany(mappedBy = "exercise", fetch = FetchType.EAGER)
    public Set<WorkoutExercise> workoutExcersices = new HashSet<>();

    /*@ManyToMany(fetch = FetchType.EAGER, mappedBy = "exercise")
    public Set<Workoutplan> workoutplans = new HashSet<>();*/
}
