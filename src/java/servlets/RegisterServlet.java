package servlets;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.AccountService;

/**
 *
 * @author Andrew Quach
 */
public class RegisterServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        getServletContext().getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        AccountService as = new AccountService();
        String action = request.getParameter("action");
        if (request.getParameter("add_email") != null && !request.getParameter("add_email").equals("") && action.equals("Submit"))
            {
            try {
                String email = request.getParameter("add_email");
                String password = request.getParameter("add_password");
                String firstname = request.getParameter("add_first_name");
                String lastname = request.getParameter("add_last_name");
                if (as.insertNewUser(email, true, firstname, lastname, password, 2))
                {
                    String message = "Account Created!";
                    request.setAttribute("message", message);
                }
                else
                {
                    String message = "Email already exists in the system. Please login.";
                    request.setAttribute("message", message);
                }
                
            } catch (Exception ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            } 
        
        getServletContext().getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
        return;
    }

}
