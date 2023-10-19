package it.polimi.db2telcoproject.service;

import it.polimi.db2telcoproject.entity.*;
import it.polimi.db2telcoproject.entity.Package;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class PackageService {
    @PersistenceContext(unitName = "TelcoEJB")
    private EntityManager em;

    public List<Package> availablePackages() {
        return em.createNamedQuery("Package.availablePackages", Package.class).getResultList();
    }

    public Package findPackage(int id) {
        return em.find(Package.class, id);
    }

    public float findPrice(int pkgId, int period) {
        PackagesPrices price = em.createNamedQuery("PackagesPrices.findValueByPeriod", PackagesPrices.class).setParameter(1, pkgId).setParameter(2, period).getResultList().get(0);
        return price.getValue();
    }

    public List<Service> existingServices() {
        return em.createNamedQuery("Service.existingServices", Service.class).getResultList();
    }

    public List<Service> findSelectedServices(String[] ids) {
        List<Service> services = new ArrayList<>();
        if(ids != null && ids.length != 0) {//at least one service must be present
            for (String s : ids) {
                services.add(em.find(Service.class, Integer.parseInt(s)));
            }
            return services;
        }
        return null;
    }

    public void createPackage(String name, List<Service> services, List<OptionalProduct> products, float[] prices) {
        Package createdPackage = new Package(name, services, products);
        PackagesPrices prices12 = new PackagesPrices(prices[0], createdPackage, em.find(ValidityPeriod.class, 12));
        PackagesPrices prices24 = new PackagesPrices(prices[1], createdPackage, em.find(ValidityPeriod.class, 24));
        PackagesPrices prices36 = new PackagesPrices(prices[2], createdPackage, em.find(ValidityPeriod.class, 36));
        em.persist(createdPackage);
        em.persist(prices12);
        em.persist(prices24);
        em.persist(prices36);

    }


}
