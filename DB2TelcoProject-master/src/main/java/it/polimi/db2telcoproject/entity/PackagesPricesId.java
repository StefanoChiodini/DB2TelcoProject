package it.polimi.db2telcoproject.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class PackagesPricesId implements Serializable {
    @Column
    private int packageId;
    @Column
    private int period;

    public PackagesPricesId() {
    }

    public PackagesPricesId(int packageId, int period) {
        this.packageId = packageId;
        this.period = period;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PackagesPricesId that = (PackagesPricesId) o;

        if (packageId != that.packageId) return false;
        return period == that.period;
    }

    @Override
    public int hashCode() {
        int result = packageId;
        result = 31 * result + period;
        return result;
    }
}
