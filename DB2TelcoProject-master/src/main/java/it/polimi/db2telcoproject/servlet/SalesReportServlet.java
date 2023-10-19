package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.OptionalProduct;
import it.polimi.db2telcoproject.entity.Order;
import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.queries.OptSales;
import it.polimi.db2telcoproject.service.EmployeeService;
import it.polimi.db2telcoproject.service.PackageService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "SalesReportServlet", value = "/sales-report")
public class SalesReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject/EmployeeService")
    private EmployeeService empService;
    @EJB(name = "it.polimi.db2telcoproject/PackageService")
    private PackageService pkgService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OptSales bestseller = empService.bestseller();
        req.getSession().setAttribute("bestsellerOpt",bestseller.getProduct());
        req.getSession().setAttribute("bestsellerValue",bestseller.getTotalValue());
        req.getSession().setAttribute("insolventUsers", empService.insolventUsers());
        req.getSession().setAttribute("suspendedOrders", empService.suspendedOrders());
        req.getSession().setAttribute("activeAlerts", empService.alerts());
        resp.sendRedirect(getServletContext().getContextPath() + "/salesreport.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Package selectedPackage = pkgService.findPackage(Integer.parseInt(StringEscapeUtils.escapeJava(req.getParameter("packages"))));
        int validityPeriod;
        List<Order> orders;
        int totalSales = 0;
        try {
            validityPeriod = Integer.parseInt(StringEscapeUtils.escapeJava(req.getParameter("validityPeriod")));
            orders= empService.activeOrdersByPkgAndVP(selectedPackage, validityPeriod);
            totalSales = empService.numberOfSalesByPkgAndVp(selectedPackage, validityPeriod);
        } catch (Exception e) {
            orders = empService.activeOrdersByPkg(selectedPackage);
            totalSales = empService.numberOfSalesByPkg(selectedPackage);
        }
        req.getSession().setAttribute("totalSales", totalSales);
        req.getSession().setAttribute("orders", orders);
        float totalValueWithOp = empService.totalValuePerOpt(selectedPackage, true);
        float totalValueWoOp = empService.totalValuePerOpt(selectedPackage, false);
        float averageOptSold = empService.averageOpt(selectedPackage);
        req.getSession().setAttribute("valueWOpt", totalValueWithOp);
        req.getSession().setAttribute("valueWoOpt", totalValueWoOp);
        req.getSession().setAttribute("averageOptSold", averageOptSold);
        resp.sendRedirect(getServletContext().getContextPath() + "/salesreport.jsp");
    }
}
