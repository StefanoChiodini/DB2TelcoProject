package it.polimi.db2telcoproject.servlet;

import
        it.polimi.db2telcoproject.service.OptionalProductsService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "OptProductsCreationServlet", value = "/opc-servlet")
public class OptProductsCreationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/OptionalProductsService")
    OptionalProductsService opService;

    public OptProductsCreationServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = StringEscapeUtils.escapeJava(req.getParameter("nameOp"));
        float fee;
        try {
            fee = Float.parseFloat(StringEscapeUtils.escapeJava(req.getParameter("fee")));
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("creationError", "Not a number");
            resp.sendRedirect(getServletContext().getContextPath() + "/homeemployee.jsp");
            return;
        }
        opService.createOptionalProduct(name, fee);
        resp.sendRedirect(getServletContext().getContextPath() + "/actionconfirmation.jsp");
    }
}
