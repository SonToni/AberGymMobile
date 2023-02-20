package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Trainee extends Person{
    //Attributes

    //Navigation

    @OneToMany(mappedBy = "trainee", fetch = FetchType.EAGER)
    public Set<Workoutplan> workoutPlanList = new HashSet<>();

}