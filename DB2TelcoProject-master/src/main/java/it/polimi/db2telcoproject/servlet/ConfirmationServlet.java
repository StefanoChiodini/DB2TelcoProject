package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.OptionalProduct;
import it.polimi.db2telcoproject.entity.Order;
import it.polimi.db2telcoproject.entity.Package;
import it.polimi.db2telcoproject.entity.User;
import it.polimi.db2telcoproject.service.OptionalProductsService;
import it.polimi.db2telcoproject.service.OrderService;
import it.polimi.db2telcoproject.service.PackageService;
import it.polimi.db2telcoproject.service.UserService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet (name = "confirmationServlet", value = "/confirmation-servlet")
public class ConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/UserService")
    private UserService usrService;
    @EJB(name = "it.polimi.db2telcoproject.service/PackageService")
    private PackageService pkgService;
    @EJB(name = "it.polimi.db2telcoproject.service/OptionalProductsService")
    private OptionalProductsService optService;
    @EJB(name = "it.polimi.db2telcoproject.service/OrderService")
    private OrderService orderService;

    public ConfirmationServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
    }
    //this is the only servlet that interacts with the home page
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        float totalValue = 0;
        User connectedUser = (User) req.getSession().getAttribute("user");
        if(req.getParameter("existingOrder")!=null) {
            try {
                Order selectedOrder = orderService.findOrderById(Integer.parseInt(req.getParameter("selectedOrder")));
                req.getSession().setAttribute("existingOrder", selectedOrder);
            } catch (NumberFormatException e) {
                resp.sendRedirect(getServletContext().getContextPath() + "/home.jsp");
                return;
            }
        } else {
            int period = Integer.parseInt(StringEscapeUtils.escapeJava(req.getParameter("validityperiod"))); //validity period (12, 24, 36)
            req.getSession().setAttribute("validityperiod", period);
            Package selectedPackage = (Package) req.getSession().getAttribute("selectedPackage"); //package
            float value = pkgService.findPrice(selectedPackage.getPkgId(), period); //price per month
            totalValue = value * period;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date startDate = sdf.parse(req.getParameter("start-date"));
                req.getSession().setAttribute("start-date", startDate);
            } catch (ParseException e) {
                req.getSession().setAttribute("start-date", new Date(0)); //starting date
            }
            if (req.getParameterValues("selectedproducts") != null) {
                List<OptionalProduct> selectedOptProducts = optService.selectedProducts(req.getParameterValues("selectedproducts"));
                for (OptionalProduct o : selectedOptProducts)
                    totalValue += o.getMonthlyFee() * period;
                req.getSession().setAttribute("selectedOptProducts", selectedOptProducts);
            }
            int tt = (int) (totalValue * 100);
            totalValue = ((float) tt) / 100;
            req.getSession().setAttribute("totalValue", totalValue);
        }
        resp.sendRedirect(getServletContext().getContextPath() + "/confirmationpage.jsp");
    }
}
