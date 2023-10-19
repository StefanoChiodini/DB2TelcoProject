package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.Package;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table
@NamedQuery(name = "PackagesSold.totalPackagesSold", query = "SELECT p FROM PackagesSold p WHERE ?1=p.PkgId")
@NamedQuery(name = "PackagesSold.totalPackagesSoldPerVP", query = "SELECT p FROM PackagesSold p WHERE ?1=p.aPackage AND ?2=p.period")
public class PackagesSold implements Serializable {
    @Id
    private int PkgId;

    @OneToOne
    @JoinColumn(name = "PkgId")
    private Package aPackage;

    private int period;

    private int sales;

    public int getSales() {
        return sales;
    }

    public PackagesSold() {
    }
}
