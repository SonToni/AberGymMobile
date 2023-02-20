package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.Set;

@Entity
public class Workoutplan extends PanacheEntityBase{
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column
    public String name;

    //Navigation
    @JsonbTransient
    @ManyToOne
    @JoinColumn(name="trainee_id", nullable=false)
    public Trainee trainee;


    @OneToMany(mappedBy = "workoutplan", fetch = FetchType.EAGER)
    public Set<WorkoutExercise> workoutExcersices = new HashSet<>();
}
