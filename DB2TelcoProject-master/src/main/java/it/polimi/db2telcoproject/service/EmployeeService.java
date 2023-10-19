package it.polimi.db2telcoproject.service;

import it.polimi.db2telcoproject.entity.*;
import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.queries.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class EmployeeService {
    @PersistenceContext(unitName = "TelcoEJB")
    private EntityManager em;

    public EmployeeService() {
    }

    public User createEmployee(String username, String password, String email) {
        User newEmployee = new User(username, password, email, true);
        em.persist(newEmployee);
        em.flush();
        return newEmployee;
    }

    public List<User> insolventUsers() {
        List<User> insolventUsers = new ArrayList<>();
        for (InsolventUser i : em.createNamedQuery("InsolventUser.allInsolvent",InsolventUser.class).getResultList())
            insolventUsers.add(i.getUserid());
        return insolventUsers;
    }

    public List<Order> suspendedOrders() {
        List<Order> orders = new ArrayList<>();
        for (SuspendedOrder s : em.createNamedQuery("SuspendedOrder.allSusOrders", SuspendedOrder.class).getResultList())
            orders.add(s.getOrder());
        return orders;
    }

    public List<Alert> alerts() {
        List<Alert> alerts = new ArrayList<>();
        List<AlertQuery> queries = em.createNamedQuery("AlertQuery.allAlerts", AlertQuery.class).getResultList();
        for(AlertQuery a : queries)
            alerts.add(a.getAlert());
        return alerts;
    }

    public List<Order> allOrders() {
        return em.createNamedQuery("Order.allOrders", Order.class).getResultList();
    }

    public List<Order> activeOrdersByPkgAndVP(Package selectedPackage, int validityPeriod) {
        return em.createNamedQuery("Order.packagesSoldPerVP", Order.class).setParameter(1, selectedPackage).setParameter(2, validityPeriod).getResultList();
    }

    public List<Order> activeOrdersByPkg(Package selectedPackage) {
        return em.createNamedQuery("Order.packagesSold", Order.class).setParameter(1, selectedPackage).getResultList();
    }

    public int numberOfSalesByPkg(Package selectedPackage) {
        List<PackagesSold> sold = em.createNamedQuery("PackagesSold.totalPackagesSold", PackagesSold.class).setParameter(1, selectedPackage.getPkgId()).getResultList();
        int total = 0;
        for (PackagesSold s : sold)
            total += s.getSales();
        return total;
    }

    public int numberOfSalesByPkgAndVp(Package selectedPackage, int validityPeriod) {
        return em.createNamedQuery("PackagesSold.totalPackagesSoldPerVP", PackagesSold.class).setParameter(1,selectedPackage).setParameter(2,validityPeriod).getResultList().get(0).getSales();
    }

    public float totalValuePerOpt(Package selectedPackage, boolean opt) {
        if(opt)
            return em.createNamedQuery("PackagesSoldWO.withOpt", PackagesSoldWithOpt.class).setParameter(1,selectedPackage.getPkgId()).getResultList().get(0).getSales();
        return em.createNamedQuery("PackagesSoldWO.withoutOpt", PackagesSoldWithOpt.class).setParameter(1,selectedPackage.getPkgId()).getResultList().get(0).getSales();
    }

    public float averageOpt(Package selectedPackage) {
        return em.createNamedQuery("AverageOptPerPkg.average", AverageOptPerPkg.class).setParameter(1,selectedPackage.getPkgId()).getResultList().get(0).getAverage();
    }

    public OptSales bestseller() {
        return em.createNamedQuery("OptSales.bestseller", OptSales.class).getResultList().get(0);
    }
}
