package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.Order;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "suspendedorders", schema = "dbtest")
@NamedQuery(name = "SuspendedOrder.allSusOrders", query = "SELECT s FROM SuspendedOrder s")
public class SuspendedOrder implements Serializable {
    @Id
    private int OrderId;

    @OneToOne
    @JoinColumn(name = "orderId")
    private Order order;

    public SuspendedOrder() {
    }

    public Order getOrder() {
        return order;
    }
}
