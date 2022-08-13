package servlets;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import services.AccountService;

/**
 *
 * @author Andrew Quach
 */
public class LoginServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        HttpSession session = request.getSession();
        String logout = request.getParameter("logout");

        if (logout != null)
        {
            session.invalidate();
            String message = "You have successfully logged out.";
            request.setAttribute("message", message);
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        if (session.getAttribute("email") != null)
        {
            response.sendRedirect("inventory");
            return;
        }

        getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountService as = new AccountService();

        try
        {
            if (email == null || email.equals("") || password == null || password.equals(""))
            {
                String message = "Invalid login.";
                request.setAttribute("message", message);
                getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
                return;
            }

            User user = as.login(email, password);
            if (user != null && user.getActive() == true)
            {
                String firstName = user.getFirstName();
                String lastName = user.getLastName();

                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("firstName", firstName);
                session.setAttribute("lastName", lastName);
                if (user.getRole().getRoleId() == 1)
                {
                    response.sendRedirect("admin");
                } else
                {
                    response.sendRedirect("inventory");
                }
            } else
            {
                String message = "Email does not match password.";
                request.setAttribute("message", message);
                getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
                return;
            }

        } catch (Exception ex)
        {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
