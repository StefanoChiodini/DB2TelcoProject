package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.Package;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "packagessoldwithopt", schema = "dbtest")
@NamedQuery(name = "PackagesSoldWO.withOpt", query = "SELECT p FROM PackagesSoldWithOpt p WHERE p.pkgId = ?1 AND p.optProduct = true")
@NamedQuery(name = "PackagesSoldWO.withoutOpt", query = "SELECT p FROM PackagesSoldWithOpt p WHERE p.pkgId = ?1 AND p.optProduct = false")

public class PackagesSoldWithOpt implements Serializable {
    @Id
    private int pkgId;

    @OneToOne
    @JoinColumn(name = "pkgId")
    private Package aPackage;

    private boolean optProduct;

    private float sales;

    public PackagesSoldWithOpt() {
    }

    public float getSales() {
        return sales;
    }
}
