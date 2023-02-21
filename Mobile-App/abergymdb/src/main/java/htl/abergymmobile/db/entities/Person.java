package htl.abergymmobile.db.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Person {
    //Attributes
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name="first_name", nullable = false)
    public String firstName;

    @Column(name="last_name", nullable = false)
    public String lastName;

    @Column(name="card_id", nullable = false)
    public String cardId;

    @Transient
    public String name = firstName + lastName;

    @Column(nullable = false)
    public String email;

    //Navigation
}
