package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="fixedphoneserv", schema="dbtest")
public class FixedPhoneServ implements Serializable {
    @Id
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "servIdFP", referencedColumnName = "servId")
    private Service servIdFI;

    public FixedPhoneServ() {
    }

}
