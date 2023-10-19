package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.User;
import it.polimi.db2telcoproject.exception.CredentialsException;
import it.polimi.db2telcoproject.service.EmployeeService;
import it.polimi.db2telcoproject.service.UserService;
import org.apache.commons.text.StringEscapeUtils;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register-servlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/UserService")
    private UserService usrService;
    @EJB(name = "it.polimi.db2telcoproject.service/EmployeeService")
    private EmployeeService empService;

    public RegisterServlet() {
        super();
    }

    public void init() throws ServletException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = null;
        String password = null;
        String username = null;
        boolean employee = false;
        try {
            username = StringEscapeUtils.escapeJava(req.getParameter("username"));
            password = StringEscapeUtils.escapeJava(req.getParameter("pwd"));
            email = StringEscapeUtils.escapeJava(req.getParameter("mail"));
            if(req.getParameter("employee")!=null)
                employee = true;
            if (username == null || password == null || username.isEmpty() || password.isEmpty() || email == null || email.isEmpty() ) {
                throw new Exception("Missing or empty credential value");
            }
            if(!email.contains("@") || !email.contains(".")) //check if an email is in the format name@domain.com
                throw new CredentialsException("F");
        }  catch (CredentialsException e1) {
            req.getSession().setAttribute("errorMsgReg", "Not an email");
            resp.sendRedirect(getServletContext().getContextPath() + "/registrationpage.jsp");
        }   catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
        }
        boolean existingUser = usrService.existingUser(username);
        if(existingUser) {
            req.getSession().setAttribute("errorMsgReg", "Already existing username");
            resp.sendRedirect(getServletContext().getContextPath() + "/registrationpage.jsp");
        }
        else {
            if(!employee) {
                User createdUser = usrService.createUser(username,password,email);
                if(createdUser != null) {
                    req.getSession().setAttribute("user", createdUser);
                    resp.sendRedirect("home-page-servlet");
                }
            }
            else {
                User createdEmployee = empService.createEmployee(username, password, email);
                if(createdEmployee != null) {
                    req.getSession().setAttribute("user", createdEmployee);
                    resp.sendRedirect("home-page-servlet");
                }
            }

        }


    }
}
