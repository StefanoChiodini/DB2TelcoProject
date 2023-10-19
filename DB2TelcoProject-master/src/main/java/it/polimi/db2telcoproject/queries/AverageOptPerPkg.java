package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.Package;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "averageoptperpkg", schema = "dbtest")
@NamedQuery(name = "AverageOptPerPkg.average", query = "SELECT a FROM AverageOptPerPkg a WHERE a.pkgId = ?1")
public class AverageOptPerPkg implements Serializable {
    @Id
    private int pkgId;

    @OneToOne
    @JoinColumn(name = "pkgId")
    private Package aPackage;

    private float average;

    public AverageOptPerPkg() {
    }

    public float getAverage() {
        return average;
    }
}
