package servlets;

import java.io.IOException;
import java.util.List;
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
 * @author Andrew
 */
public class AdminServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        AccountService as = new AccountService();

        request.setAttribute("add", true);

        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");

//        try {
//            if (!name.equals("admin") && !name.equals("admin2")) {
//                response.sendRedirect("login");
//                return;
//            }
//        } catch (NullPointerException e) {
//            response.sendRedirect("login");
//            return;
//        }
        try
        {
            String action = request.getParameter("action");
            if (action != null && action.equals("delete"))
            {
                String email = request.getParameter("email");
                if (!emailSession.equals(email))
                {
                    String message = "User deleted!";
                    request.setAttribute("message", message);
                    as.delete(email);
                } else
                {
                    String message = "Cannot delete yourself!";
                    request.setAttribute("message", message);
                }

            } else if (action != null && action.equals("edit"))
            {

                String email = request.getParameter("email");
                User user = as.get(email);

                request.setAttribute("editUser", user);
                request.setAttribute("edit", true);
                request.setAttribute("add", false);
            }

            List<User> users = as.getAll();
            request.setAttribute("users", users);
        } catch (Exception e)
        {
            request.setAttribute("message", "No users found");
        }

        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        AccountService as = new AccountService();

        try
        {
            String action = request.getParameter("action");

            if (request.getParameter("add_email") != null && !request.getParameter("add_email").equals("") && action.equals("add"))
            {
                String message = "User added!";
                request.setAttribute("message", message);
                String email = request.getParameter("add_email");
                String password = request.getParameter("add_password");
                String firstname = request.getParameter("add_first_name");
                String lastname = request.getParameter("add_last_name");
                boolean active = Boolean.parseBoolean(request.getParameter("add_active"));
                int roleId = Integer.parseInt(request.getParameter("add_roles"));

                as.insert(email, active, firstname, lastname, password, roleId);
            } 
            else if (action.equals("edit"))
            {
                String message = "User saved!";
                request.setAttribute("message", message);
                String email = request.getParameter("edit_email");
                String firstname = request.getParameter("edit_first_name");
                String lastname = request.getParameter("edit_last_name");
                String password = request.getParameter("edit_password");
                boolean active = Boolean.parseBoolean(request.getParameter("edit_active"));
                int roleId = Integer.parseInt(request.getParameter("edit_roles"));

                as.update(email, active, firstname, lastname, password, roleId);
            }

            List<User> users = as.getAll();
            request.setAttribute("users", users);
            request.setAttribute("add", true);

        } catch (Exception ex)
        {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
    }
}
