package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.*;
import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.service.OrderService;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Time;
import java.util.Date;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/order-servlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB (name = "it.polimi.db2telcoproject.service/OrderService")
    private OrderService orderService;


    public OrderServlet() {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if(session.getAttribute("existingOrder")!=null) {
            Order existingOrder = (Order) session.getAttribute("existingOrder");
            orderService.retryOrder(existingOrder, req.getParameter("payment") != null);
        } else {
            int validityPeriod = (int) session.getAttribute("validityperiod");
            float totalValue = (float) session.getAttribute("totalValue");
            Date startDate = (Date) session.getAttribute("start-date");
            long millis = System.currentTimeMillis();
            Date orderDate = new Date(millis);
            Package selectedPackage = (Package) session.getAttribute("selectedPackage");
            List<OptionalProduct> selectedOptProducts = (List<OptionalProduct>) session.getAttribute("selectedOptProducts");
            orderService.createOrder(validityPeriod, totalValue, startDate, orderDate, orderDate, user, selectedPackage, selectedOptProducts, req.getParameter("payment") != null);
        }
        if(req.getParameter("payment")==null) {
            req.getSession().invalidate();
            req.getSession(true).setAttribute("user", user);
            req.getSession().setAttribute("failedPayment", true);
            resp.sendRedirect(getServletContext().getContextPath() + "/endpage.jsp");
            return;
        }
        req.getSession().invalidate();
        req.getSession().setAttribute("user", user);
        resp.sendRedirect(getServletContext().getContextPath() + "/endpage.jsp");
    }
}
