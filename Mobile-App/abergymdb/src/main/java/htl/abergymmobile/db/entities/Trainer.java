package htl.abergymmobile.db.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class Trainer extends Person{
    //Attributes

    //Navigation

    @OneToMany(mappedBy = "trainer", fetch = FetchType.EAGER)
    public List<Template> templateList;
}