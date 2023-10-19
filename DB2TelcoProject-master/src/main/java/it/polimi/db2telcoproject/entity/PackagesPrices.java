package it.polimi.db2telcoproject.entity;

import it.polimi.db2telcoproject.entity.PackagesPricesId;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "packagesprices", schema = "dbtest")
@NamedQuery(name = "PackagesPrices.findValueByPeriod", query = "SELECT p FROM PackagesPrices p WHERE p.id.packageId = ?1 and p.id.period = ?2")
public class PackagesPrices implements Serializable {
    @EmbeddedId
    private PackagesPricesId id;
    @Column(name = "value")
    private float value;
    @ManyToOne
    @MapsId("packageId")
    //@PrimaryKeyJoinColumn(name = "packageId", referencedColumnName = "pkgId")
    //@JoinColumn(name = "packageId", nullable = false, insertable = false, referencedColumnName = "pkgId")
    private Package aPackage;
    @ManyToOne
    @MapsId("period")
    //@PrimaryKeyJoinColumn(name = "period", referencedColumnName = "period")
    //@JoinColumn(name = "period", nullable = false, insertable = false, referencedColumnName = "period")
    private ValidityPeriod valPeriod;

    public PackagesPrices() {
    }

    public PackagesPrices(float value, Package aPackage, ValidityPeriod valPeriod) {
        this.id = new PackagesPricesId(aPackage.getPkgId(), valPeriod.getPeriod());
        this.value = value;
        this.aPackage = aPackage;
        this.valPeriod = valPeriod;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PackagesPrices that = (PackagesPrices) o;

        if (!aPackage.equals(that.aPackage)) return false;
        return valPeriod.equals(that.valPeriod);
    }

    public float getValue() {
        return value;
    }

    @Override
    public int hashCode() {
        return Objects.hash(aPackage, valPeriod);
    }
}

