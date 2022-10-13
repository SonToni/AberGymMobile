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

    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "exercise")
    public Set<Template> templateSet = new HashSet<>();
}
