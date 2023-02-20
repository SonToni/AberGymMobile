package at.htl.entities;

import javax.json.bind.annotation.JsonbTransient;
import javax.persistence.*;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import java.util.HashSet;
import java.util.Set;


@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Person extends PanacheEntityBase{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column(name="first_name", nullable = false)
    public String firstName;

    @Column(name="last_name", nullable = false)
    public String lastName;

    @Transient
    public String name = firstName + lastName;

    @Column(nullable = false)
    public String email;

    //Navigation

}
