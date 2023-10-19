package it.polimi.db2telcoproject.service;

import it.polimi.db2telcoproject.entity.OptionalProduct;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless
public class OptionalProductsService {
    @PersistenceContext(unitName = "TelcoEJB")
    private EntityManager em;

    public OptionalProductsService() {
    }

    public OptionalProduct findOptionalProduct(Integer id) {
        return em.find(OptionalProduct.class, id);
    }

    public void createOptionalProduct(String name, float monthlyFee) {
        OptionalProduct newOpt = new OptionalProduct(name, monthlyFee);
        em.persist(newOpt);
        em.flush();
    }

    public List<OptionalProduct> selectedProducts(String[] productsId) {
        List<OptionalProduct> selectedProducts = new ArrayList<>();
        for(String s : productsId)
            selectedProducts.add(em.find(OptionalProduct.class, Integer.parseInt(s)));
        return selectedProducts;
    }


    public List<OptionalProduct> existingProducts() {
        return em.createNamedQuery("OptionalProduct.existingProducts", OptionalProduct.class).getResultList();
    }
}
