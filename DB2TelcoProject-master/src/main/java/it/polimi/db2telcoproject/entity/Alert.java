package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "alerts", schema = "dbtest")
@NamedQuery(name = "Alert.existingAlerts", query = "SELECT a FROM Alert a")
public class Alert implements Serializable {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private int alertId;
    @Column()
    private Date date;
    private Date hour;
    private float amount;
    private String email;
    private int failedOrderId;

    private String username;

    public Alert() {
    }

    public Alert(Date date, Date hour, float amount, String email, int failedOrderId, String username) {
        this.date = date;
        this.hour = hour;
        this.amount = amount;
        this.email = email;
        this.failedOrderId = failedOrderId;
        this.username = username;
    }

    public int getAlertId() {
        return alertId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public float getAmount() {
        return amount;
    }

    public int getFailedOrderId() {
        return failedOrderId;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }
}
