package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Trainer extends Person{
    //Attributes

    //Navigation
    @JsonbTransient
    @OneToMany(mappedBy = "trainer", fetch = FetchType.EAGER)
    public List<Template> templateList;

}
