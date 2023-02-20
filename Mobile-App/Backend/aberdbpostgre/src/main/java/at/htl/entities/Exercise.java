package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.Set;

@Entity
public class Exercise extends PanacheEntityBase{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;
    @Column(length = 64, unique = true, nullable = false)
    public String name;

    @Column(name = "muscle_group", nullable = false)
    public String muscleGroup;

    @Column(name = "description")
    public String description;

    @JsonbTransient
    @OneToMany(mappedBy = "exercise")
    public Set<WorkoutExercise> workoutExcersices = new HashSet<>();

    public Exercise(){
    }

    public Exercise(String name, String muscleGroup){
        this.name = name;
        this.muscleGroup = muscleGroup;
    }

    public Exercise(String name, String muscleGroup, String description){
        this.name = name;
        this.muscleGroup = muscleGroup;
        this.description = description;
    }

}
