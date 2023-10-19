package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "optionalproducts", schema = "dbtest")
@NamedQuery(name = "OptionalProduct.existingProducts", query = "SELECT o FROM OptionalProduct o")
public class OptionalProduct implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int prodId;
    @Column()
    private String name;
    private float monthlyFee;
    /* Could be added, not relevant for the project
    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "products", fetch= FetchType.Lazy)
    List<Package> connectedPackages; */

    public OptionalProduct() {
    }

    public OptionalProduct(String name, float monthlyFee) {
        this.name = name;
        this.monthlyFee = monthlyFee;
    }

    public int getProdId() {
        return prodId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getMonthlyFee() {
        return monthlyFee;
    }

}
