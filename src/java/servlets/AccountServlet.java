package servlets;

import dataaccess.UserDB;
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
public class AccountServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        try
        {
            HttpSession session = request.getSession();
            if (session.getAttribute("email") == null)
            {
                response.sendRedirect("login");
                return;
            }
            String email = (String) session.getAttribute("email");
            request.setAttribute("edit", true);
            AccountService as = new AccountService();
            User user = as.get(email);
            if (user.getRole().getRoleId() == 1)
            {
                request.setAttribute("showAdmin", true);
            }
            request.setAttribute("editUser", user);
            String action = request.getParameter("action");
            if (action != null && action.equals("deactivate"))
            {
                String firstname = user.getFirstName();
                String lastname = user.getLastName();
                String password = user.getPassword();
                int roleId = user.getRole().getRoleId();
                if (roleId != 1)
                {
                    as.update(email, false, firstname, lastname, password, roleId);
                    String message2 = "Account deactivated!";
                    request.setAttribute("message2", message2);
                } else
                {
                    String message2 = "Cannot deactivate this account.";
                    request.setAttribute("message2", message2);
                }
            }
            getServletContext().getRequestDispatcher("/WEB-INF/account.jsp").forward(request, response);
            return;
        } catch (Exception ex)
        {
            Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        AccountService as = new AccountService();
        String action = request.getParameter("action");
        if (action.equals("edit"))
        {
            try
            {
                String email = request.getParameter("edit_email");
                String firstname = request.getParameter("edit_first_name");
                String lastname = request.getParameter("edit_last_name");
                String password = request.getParameter("edit_password");
                UserDB userDB = new UserDB();
                User user = userDB.get(email);
                boolean active = user.getActive();
                int roleId = user.getRole().getRoleId();
                as.update(email, active, firstname, lastname, password, roleId);
                String message = "Saved! Changes will be made the next time you login!";
                user = userDB.get(email);
                request.setAttribute("editUser", user);
                request.setAttribute("message", message);
                request.setAttribute("edit", true);
            } catch (Exception ex)
            {
                Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        getServletContext().getRequestDispatcher("/WEB-INF/account.jsp").forward(request, response);
        return;
    }

}
