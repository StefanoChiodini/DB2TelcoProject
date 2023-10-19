package it.polimi.db2telcoproject.servlet;

import it.polimi.db2telcoproject.entity.User;
import it.polimi.db2telcoproject.exception.CredentialsException;
import it.polimi.db2telcoproject.service.UserService;
import org.apache.commons.text.StringEscapeUtils;


import javax.ejb.EJB;
import javax.persistence.NonUniqueResultException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @EJB(name = "it.polimi.db2telcoproject.service/UserService")
    private UserService usrService;

    public LoginServlet() {
        super();
    }

    public void init() throws ServletException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // obtain and escape params
        String usrn = null;
        String pwd = null;
        try {
            usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
            pwd = StringEscapeUtils.escapeJava(request.getParameter("pwd"));
            if (usrn == null || pwd == null || usrn.isEmpty() || pwd.isEmpty()) {
                throw new Exception("Missing or empty credential value");
            }

        } catch (Exception e) {
            // for debugging only e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
            return;
        }
        User user;
        try {
            // query db to authenticate for user
            user = usrService.checkCredentials(usrn, pwd);
        } catch (CredentialsException | NonUniqueResultException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Could not check credentials");
            return;
        }

        // If the user exists, add info to the session and go to home page, otherwise
        // show login page with error message

        if (user == null) {
            request.getSession().setAttribute("errorMsg", "Invalid username or password");
            response.sendRedirect(getServletContext().getContextPath() + "/loginpage.jsp");

        } else {
            if(!user.isEmployee()) {
                request.getSession().setAttribute("user", user);
                if(request.getSession().getAttribute("token")!=null && (boolean) request.getSession().getAttribute("token")==true) {
                    response.sendRedirect(getServletContext().getContextPath() + "/confirmationpage.jsp");
                    request.getSession().removeAttribute("token");
                }
                else
                    response.sendRedirect("home-page-servlet");
            }
            else {
                request.getSession().setAttribute("user", user);
                response.sendRedirect("home-page-servlet");
            }
        }

    }

    public void destroy() {
    }
}
