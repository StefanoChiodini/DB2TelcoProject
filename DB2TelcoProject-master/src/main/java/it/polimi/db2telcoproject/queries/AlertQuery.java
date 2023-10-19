package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.Alert;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "alerttrigger", schema = "dbtest")
@NamedQuery(name = "AlertQuery.allAlerts", query = "SELECT a FROM AlertQuery a")
public class AlertQuery implements Serializable {
    @Id
    private int alertId;

    @OneToOne
    @JoinColumn(name = "alertId", referencedColumnName = "alertId")
    private Alert alert;

    public AlertQuery() {
    }

    public Alert getAlert() {
        return alert;
    }
}
