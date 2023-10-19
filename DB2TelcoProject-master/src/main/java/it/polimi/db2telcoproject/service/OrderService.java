package it.polimi.db2telcoproject.service;

import it.polimi.db2telcoproject.entity.*;
import it.polimi.db2telcoproject.entity.Package;

import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Stateful
public class OrderService {
    @PersistenceContext (unitName = "TelcoEJB")
    private EntityManager em;
    private List<Order> orders = new ArrayList<>();

    public OrderService() {
    }

    public void createOrder(int validityPeriod, float totalValue, Date startDate, Date orderDate, Date hour, User user, Package selectedPackage, List<OptionalProduct> selectedOptProducts, boolean valid) {
        Order createdOrder = new Order(validityPeriod, totalValue, startDate, orderDate, hour, user, selectedPackage, selectedOptProducts, valid);
        user.addOrder(createdOrder);
        orders.add(createdOrder);
        if(!valid) {
            user.failedPayment();
            user.setInsolvent(true);
        }
        em.persist(createdOrder);
        em.merge(user);
        em.flush();
        if(user.getFailedPayments() >= 3 && user.getFailedPayments() % 3 == 0) {
            Alert createdAlert = new Alert(orderDate, hour, totalValue, user.getEmail(), createdOrder.getOrderId(), user.getUsername());
            em.persist(createdAlert);
        }
    }

    public void retryOrder(Order existingOrder, boolean paymentCompleted) {
        User user = existingOrder.getUsername();
        if(!paymentCompleted) {
            user.failedPayment();
            if(user.getFailedPayments() >= 3 && user.getFailedPayments() % 3 == 0) {
                Alert createdAlert = new Alert(existingOrder.getDate(), existingOrder.getHour(), existingOrder.getTotalValue(), user.getEmail(), existingOrder.getOrderId(), user.getUsername());
                em.persist(createdAlert);
            }
        } else {
            int failedCounter=0;
            for (Order o : user.getOrders())
                if (!o.isPaid())
                    failedCounter++;
            existingOrder.setPaid(true);
            if(failedCounter <= 1)
                user.setInsolvent(false);
        }
        em.merge(user);
        em.merge(existingOrder);
        em.flush();

    }

    public Order findOrderById(int id) {
        return em.find(Order.class, id);
    }
}
