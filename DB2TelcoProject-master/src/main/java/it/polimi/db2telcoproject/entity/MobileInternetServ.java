package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "mobileinternetserv", schema = "dbtest")
public class MobileInternetServ implements Serializable {
    @Id
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "servIdMI", referencedColumnName = "servId")
    private Service servIdMI;
    @Column()
    private int gBs;
    private float extraGBs;

    public MobileInternetServ() {
    }

}