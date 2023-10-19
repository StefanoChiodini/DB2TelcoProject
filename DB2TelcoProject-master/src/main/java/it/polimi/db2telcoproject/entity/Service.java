package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "services", schema="dbtest")
@NamedQuery(name = "Service.existingServices", query = "SELECT s FROM Service s")
public class Service implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int servId;
    @Column(unique = true)
    private String name;

    public Service() {
    }

    public Service(int servId, String name) {
        this.servId = servId;
        this.name = name;
    }

    public int getServId() {
        return servId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

