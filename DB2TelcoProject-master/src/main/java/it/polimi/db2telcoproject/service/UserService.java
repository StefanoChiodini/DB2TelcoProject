package it.polimi.db2telcoproject.service;

import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.entity.User;
import it.polimi.db2telcoproject.exception.CredentialsException;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import java.util.List;

@Stateless
public class UserService {
    @PersistenceContext(unitName = "TelcoEJB")
    private EntityManager em;

    public UserService() {
    }

    public User checkCredentials(String usrn, String pwd) throws CredentialsException, NonUniqueResultException {
        List<User> uList;
        try {
            uList = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, usrn).setParameter(2, pwd)
                    .getResultList();
        } catch (PersistenceException e) {
            e.printStackTrace();
            throw new CredentialsException("Could not verify credentials");
        }
        if (uList.isEmpty())
            return null;
        else if (uList.size() == 1)
            return uList.get(0);
        throw new NonUniqueResultException("More than one user registered with same credentials");
    }

    public boolean existingUser(String username) {
        List<User> userList = em.createNamedQuery("User.existingUsername", User.class).setParameter(1,username).getResultList();
        return !userList.isEmpty();
    }

    public User createUser(String username, String password, String email) {
        //here the object is new transient
        User newUser = new User(username, password, email);
        //here the object became managed
        em.persist(newUser);
        //here the object is sent to the db
        em.flush();
        return newUser;
    }

}

