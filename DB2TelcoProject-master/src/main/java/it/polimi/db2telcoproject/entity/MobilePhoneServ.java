package it.polimi.db2telcoproject.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "mobilephoneserv", schema = "dbtest")
public class MobilePhoneServ implements Serializable {
    @Id
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "servIdMP", referencedColumnName = "servId")
    private Service servIdMP;
    @Column()
    private int minutes;
    private int sms;
    private float extraSms;
    private float extraMin;

    public MobilePhoneServ() {
    }

}
