package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users", schema = "dbtest")
@NamedQuery(name = "User.checkCredentials", query = "SELECT u FROM User u WHERE u.username = ?1 and u.password = ?2")
@NamedQuery(name = "User.existingUsername", query = "SELECT u FROM User u WHERE u.username = ?1")
@NamedQuery(name = "User.insolventUser", query = "SELECT u FROM User u WHERE u.insolvent=true")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;
    @Column()
    private String email;
    private String password;
    private boolean insolvent;
    private boolean employee;

    private int failedPayments;
    @Column(unique = true)
    private String username;
    @OneToMany(fetch= FetchType.EAGER, mappedBy = "username", orphanRemoval = true)
    private List<Order> orders;


    public User(){

    }
    //this is the constructor for user
    public User(String username, String password, String email) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.insolvent = false;
        this.employee = false;
        this.failedPayments = 0;
        this.orders = new ArrayList<>();
    }
    //this is the constructor for employee
    public User(String username, String password, String email, boolean employee) {
        this.email = email;
        this.password = password;
        this.employee = true;
        this.username = username;
        this.failedPayments = 0;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isInsolvent() {
        return insolvent;
    }

    public void setInsolvent(boolean insolvent) {
        this.insolvent = insolvent;
    }

    public boolean isEmployee() {
        return employee;
    }

    public void setEmployee(boolean employee) {
        this.employee = employee;
    }

    public void failedPayment() {
        failedPayments++;
    }

    public int getFailedPayments() {
        return failedPayments;
    }

    public void addOrder(Order order) {
        this.orders.add(order);
    }

    public List<Order> getOrders() {
        return orders;
    }
}