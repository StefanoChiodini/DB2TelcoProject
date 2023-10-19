package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.service.PackageService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BuyServlet", value = "/buy-servlet")
public class BuyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/PackageService")
    private PackageService pkgService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String selectedId = StringEscapeUtils.escapeJava(req.getParameter("packages"));
        Package selectedPackage = pkgService.findPackage(Integer.parseInt(selectedId));
        req.getSession().setAttribute("selectedPackage", selectedPackage);
        resp.sendRedirect(getServletContext().getContextPath() + "/productselection.jsp");
    }
}
