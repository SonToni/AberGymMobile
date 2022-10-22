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
public class Template {
    //Attributes

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

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