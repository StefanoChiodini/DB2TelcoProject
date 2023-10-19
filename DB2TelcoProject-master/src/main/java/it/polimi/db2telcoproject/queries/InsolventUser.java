package it.polimi.db2telcoproject.queries;

import it.polimi.db2telcoproject.entity.User;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "InsolventUsers", schema = "dbtest")
@NamedQuery(name = "InsolventUser.allInsolvent", query = "SELECT i FROM InsolventUser i")
public class InsolventUser implements Serializable {

    @Id
    private int userid;

    @OneToOne
    @JoinColumn(name = "userId")
    private User user;

    public InsolventUser() {
    }

    public User getUserid() {
        return user;
    }
}
