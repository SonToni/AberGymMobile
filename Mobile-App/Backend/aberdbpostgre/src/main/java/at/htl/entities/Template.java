package at.htl.entities;

import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.Set;

@Entity
public class Template extends PanacheEntityBase{
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column
    public String name;

    //Navigation

    @ManyToOne
    @JoinColumn(name="trainer_id", nullable=false)
    public Trainer trainer;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "Template_Exercise", // name of the association table
            joinColumns = @JoinColumn(name = "template_id"), // foreign key columns
            inverseJoinColumns = @JoinColumn(name = "exercise_id"))
    private Set<Exercise> exercise = new HashSet<>();
}
