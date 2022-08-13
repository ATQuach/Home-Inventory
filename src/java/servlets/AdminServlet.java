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
import models.Category;
import models.User;
import services.AccountService;
import services.CategoryService;
import services.InventoryService;

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
        InventoryService is = new InventoryService();
        CategoryService cs = new CategoryService();

        request.setAttribute("addUser", true);
        request.setAttribute("addCategory", true);

        request.setAttribute("show_manage_users", true);
        request.setAttribute("show_manage_categories", false);

        HttpSession session = request.getSession();
        String emailSession = (String) session.getAttribute("email");
        try
        {
            User user = as.get(emailSession);
            if (user.getRole().getRoleId() != 1)
            {
                response.sendRedirect("login");
            } else
            {
                request.setAttribute("showAdmin", true);
            }
        } catch (Exception ex)
        {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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
                request.setAttribute("show_manage_users", true);
                request.setAttribute("show_manage_categories", false);
            } else if (action != null && action.equals("edit"))
            {
                String email = request.getParameter("email");
                User user = as.get(email);

                request.setAttribute("editUser", user);
                request.setAttribute("edit", true);
                request.setAttribute("addUser", false);
                request.setAttribute("show_manage_users", true);
                request.setAttribute("show_manage_categories", false);

            } else if (action != null && action.equals("edit_category"))
            {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Category category = cs.get(categoryId);

                request.setAttribute("editCategory", category);
                request.setAttribute("editCate", true);
                request.setAttribute("addCategory", false);
                request.setAttribute("show_manage_users", false);
                request.setAttribute("show_manage_categories", true);
            } else if (action != null && action.equals("manageUsers"))
            {
                request.setAttribute("show_manage_users", true);
                request.setAttribute("show_manage_categories", false);
            } else if (action != null && action.equals("manageCategories"))
            {
                request.setAttribute("show_manage_users", false);
                request.setAttribute("show_manage_categories", true);
            }

            List<User> users = as.getAll();
            request.setAttribute("users", users);
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e)
        {
            request.setAttribute("message", "No users found");
        }

        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        AccountService as = new AccountService();
        InventoryService is = new InventoryService();
        CategoryService cs = new CategoryService();

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

                request.setAttribute("show_manage_users", true);
                request.setAttribute("show_manage_categories", false);
            } else if (action.equals("edit"))
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

                request.setAttribute("show_manage_users", true);
                request.setAttribute("show_manage_categories", false);
            } else if (action.equals("addCategory"))
            {
                String message2 = "Category added!";
                request.setAttribute("message2", message2);
                String category = request.getParameter("add_category");

                cs.insert(category);
                request.setAttribute("show_manage_users", false);
                request.setAttribute("show_manage_categories", true);
            } else if (action.equals("editCategory"))
            {
                String message2 = "Category saved!";
                request.setAttribute("message2", message2);
                int categoryID = Integer.parseInt(request.getParameter("edit_category_id"));
                String categoryName = request.getParameter("edit_category");

                cs.update(categoryID, categoryName);
                request.setAttribute("show_manage_users", false);
                request.setAttribute("show_manage_categories", true);
            }

            List<User> users = as.getAll();
            List<Category> categories = is.getAllCategories();
            request.setAttribute("users", users);
            request.setAttribute("categories", categories);
            request.setAttribute("addUser", true);
            request.setAttribute("addCategory", true);

        } catch (Exception ex)
        {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
        return;
    }
}
