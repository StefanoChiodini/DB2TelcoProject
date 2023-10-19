package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.OptionalProduct;
import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.entity.Service;
import it.polimi.db2telcoproject.entity.User;
import it.polimi.db2telcoproject.service.OptionalProductsService;
import it.polimi.db2telcoproject.service.PackageService;
import it.polimi.db2telcoproject.service.UserService;


import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/*
after login, subscribe or continue as guest we pass always through this servlet. This servlet is used before the home page.jsp so it contains
the redirect to the home page, and it could not been called/used by the home.jsp
 */


@WebServlet(name = "HomePageServlet", value = "/home-page-servlet")
public class HomePageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/UserService")
    private UserService usrService;
    @EJB(name = "it.polimi.db2telcoproject.service/PackageService")
    private PackageService pkgService;
    @EJB(name = "it.polimi.db2telcoproject.service/OptionalProductsService")
    private OptionalProductsService opService;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User connectedUser = (User) req.getSession().getAttribute("user");
        List<Package> availablePackages = pkgService.availablePackages();
        req.getSession().setAttribute("packages",availablePackages);
        if(connectedUser!=null && connectedUser.isEmployee()) {
            List<Service> existingServices = pkgService.existingServices();
            List<OptionalProduct> existingProducts = opService.existingProducts();
            req.getSession().setAttribute("existingProducts", existingProducts);
            req.getSession().setAttribute("existingServices", existingServices);
            resp.sendRedirect(getServletContext().getContextPath() + "/homeemployee.jsp");
            return;
        }
        resp.sendRedirect(getServletContext().getContextPath() + "/home.jsp");
    }
}
