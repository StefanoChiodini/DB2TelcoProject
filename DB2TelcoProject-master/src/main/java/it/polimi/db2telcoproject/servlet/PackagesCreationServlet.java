package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.OptionalProduct;
import it.polimi.db2telcoproject.entity.Service;
import it.polimi.db2telcoproject.service.OptionalProductsService;
import it.polimi.db2telcoproject.service.PackageService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PackagesCreationServlet", value = "/pc-servlet")
public class PackagesCreationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB (name = "it.polimi.db2telcoproject.service/PackageService")
    private PackageService pkgService;
    @EJB (name = "it.polimi.db2telcoproject.service/OptionalProductsService")
    private OptionalProductsService opService;

    public PackagesCreationServlet() {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = StringEscapeUtils.escapeJava(req.getParameter("namePkg"));
        //this is a vector of string that contains only the selected services id
        String[] selectedServicesIds = req.getParameterValues("selectedServices");
        //here I call a pkgService method to obtain the name of selected services starting only with the service id
        //so I obtain the list of selected services with their real name
        List<Service> selectedServices = pkgService.findSelectedServices(selectedServicesIds);
        if(selectedServices == null || selectedServices.isEmpty() || selectedServices.size()>4) {
            req.getSession().setAttribute("creationError", "More than 4 services selected or not selected at all");
            resp.sendRedirect(getServletContext().getContextPath() + "/homeemployee.jsp");
            return;
        }
        List<OptionalProduct> selectedProducts = null;
        if(req.getParameterValues("selectedProducts")!=null)
            selectedProducts = opService.selectedProducts(req.getParameterValues("selectedProducts"));
        float[] prices = new float[3];
        prices[0] = Float.parseFloat(req.getParameter("validity12"));
        prices[1] = Float.parseFloat(req.getParameter("validity24"));
        prices[2] = Float.parseFloat(req.getParameter("validity36"));
        pkgService.createPackage(name, selectedServices, selectedProducts, prices);
        resp.sendRedirect(getServletContext().getContextPath() + "/actionconfirmation.jsp");
    }
}
