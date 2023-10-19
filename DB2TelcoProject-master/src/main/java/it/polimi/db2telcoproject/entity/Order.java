package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Time;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Entity
@Table(name = "orders", schema = "dbtest")
@NamedQuery(name = "Order.packagesSold", query = "SELECT o FROM Order o WHERE o.paid=true and o.pkgId=?1")
@NamedQuery(name = "Order.packagesSoldPerVP", query = "SELECT o FROM Order o WHERE o.paid = true and o.pkgId=?1 and o.validityPeriod=?2")
@NamedQuery(name = "Order.allOrders", query = "SELECT o FROM Order o WHERE o.paid=true")
public class Order implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;
    @Column()
    private int validityPeriod;
    private float totalValue;
    private Date startDate;
    private Date date;
    private Date hour;

    private boolean paid;

    private boolean hasOpt;

    private int optNumber;

    @ManyToOne (fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "username", referencedColumnName = "username", nullable = false) //first username refers to local field, second refers to foreign field
    private User username;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "pkgId", referencedColumnName = "pkgId", nullable = false)
    private Package pkgId;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinTable(name = "selectedoptproducts", joinColumns = {@JoinColumn(name = "orderId")}, inverseJoinColumns = {@JoinColumn(name = "optProductId")})
    private List<OptionalProduct> selectedProducts;

    public Order() {
    }

    public Order(int validityPeriod, float totalValue, Date startDate, Date date, Date hour, User username, Package pkgId, List<OptionalProduct> selectedProducts, boolean paid) {
        this.validityPeriod = validityPeriod;
        this.totalValue = totalValue;
        this.startDate = startDate;
        this.date = date;
        this.hour = hour;
        this.username = username;
        this.pkgId = pkgId;
        this.selectedProducts = selectedProducts;
        this.paid = paid;
        this.hasOpt = selectedProducts != null && !selectedProducts.isEmpty();
        if(selectedProducts != null && !selectedProducts.isEmpty())
            this.optNumber = selectedProducts.size();
        else
            this.optNumber = 0;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getValidityPeriod() {
        return validityPeriod;
    }

    public float getTotalValue() {
        return totalValue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getHour() {
        return hour;
    }

    public boolean isPaid() {
        return paid;
    }

    public void setPaid(boolean payed) {
        this.paid = payed;
    }

    public User getUsername() {
        return username;
    }

    public void setUsername(User username) {
        this.username = username;
    }

    public Package getPkgId() {
        return pkgId;
    }

    public List<OptionalProduct> getSelectedProducts() {
        return selectedProducts;
    }

}

