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
public class Trainee extends Person{
    //Attributes

    //Navigation

    @OneToMany(mappedBy = "trainee", fetch = FetchType.EAGER)
    public Set<Workoutplan> workoutPlanList = new HashSet<>();
}
