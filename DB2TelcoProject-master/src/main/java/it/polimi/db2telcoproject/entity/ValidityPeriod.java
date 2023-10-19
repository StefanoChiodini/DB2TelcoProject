package it.polimi.db2telcoproject.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "validityperiod", schema = "dbtest")
public class ValidityPeriod implements Serializable {
    @Id
    private int period;
    public ValidityPeriod() {
    }

    public ValidityPeriod(int period) {
        this.period = period;
    }

    public int getPeriod() {
        return period;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ValidityPeriod that = (ValidityPeriod) o;
        return period == that.period;
    }

    @Override
    public int hashCode() {
        return Objects.hash(period);
    }
}
