package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "fixedinternetserv", schema = "dbtest")
public class FixedInternetServ implements Serializable {
    @Id
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "servIdFI", referencedColumnName = "servId")
    private Service servIdFI;
    @Column()
    private int gBs;
    private float extraGBs;

    public FixedInternetServ() {
    }

}
