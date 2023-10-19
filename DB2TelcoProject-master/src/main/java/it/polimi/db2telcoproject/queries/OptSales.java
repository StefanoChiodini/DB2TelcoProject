package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.OptionalProduct;

import javax.persistence.*;

@Entity
@Table(name = "optsales", schema = "dbtest")
@NamedQuery(name = "OptSales.bestseller", query = "SELECT o FROM OptSales o WHERE o.totalValue = (SELECT MAX(p.totalValue) FROM OptSales p)")
public class OptSales {
    @Id
    private int optProdId;

    @OneToOne
    @JoinColumn(name = "optProdId")
    private OptionalProduct product;

    private float totalValue;

    public OptSales() {
    }

    public float getTotalValue() {
        return totalValue;
    }

    public OptionalProduct getProduct() {
        return product;
    }
}
