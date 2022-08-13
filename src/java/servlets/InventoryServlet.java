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
import models.Item;
import models.User;
import services.AccountService;
import services.InventoryService;

/**
 *
 * @author Andrew Quach
 */
public class InventoryServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        HttpSession session = request.getSession();
        InventoryService is = new InventoryService();
        AccountService as = new AccountService();
        String email = (String) session.getAttribute("email");
        request.setAttribute("add", true);

        try
        {
            User user = as.get(email);
            if (user.getRole().getRoleId() == 1)
            {
                request.setAttribute("showAdmin", true);
            }
        } catch (Exception ex)
        {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (session.getAttribute("email") == null)
        {
            response.sendRedirect("login");
            return;
        }

        try
        {
            String action = request.getParameter("action");

            if (action != null && action.equals("delete"))
            {
                int itemId = Integer.parseInt(request.getParameter("itemID"));
                boolean isDeleted = is.delete(itemId, email);
                if (isDeleted)
                {
                    request.setAttribute("message", "Deleted item.");
                }
            } else if (action != null && action.equals("edit"))
            {
                int itemId = Integer.parseInt(request.getParameter("itemID"));
                Item item = is.get(itemId);
                request.setAttribute("editItem", item);
                request.setAttribute("edit", true);
                request.setAttribute("add", false);
            }

            List<Item> items = is.getAll(email);
            List<Category> categories = is.getAllCategories();
            request.setAttribute("items", items);
            request.setAttribute("categories", categories);

        } catch (Exception ex)
        {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        AccountService as = new AccountService();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        

        InventoryService is = new InventoryService();

        String action = request.getParameter("action");

        try
        {
            User user = as.get(email);
            if (user.getRole().getRoleId() == 1)
            {
                request.setAttribute("showAdmin", true);
            }
            if (action != null && action.equals("add_item"))
            {
                String categoryId = request.getParameter("categoryList");
                String itemName = request.getParameter("add_item_name");
                String itemPrice = request.getParameter("add_item_price");
                is.insert(itemName, Integer.parseInt(itemPrice), Integer.parseInt(categoryId), email);
                request.setAttribute("message", "Added item.");
            } else if (action != null && action.equals("edit_item"))
            {
                String message = "Item saved!";
                request.setAttribute("message", message);

                int itemId = Integer.parseInt(request.getParameter("edit_item_id"));
                int category = Integer.parseInt(request.getParameter("edit_category"));
                String name = request.getParameter("edit_item_name");
                double price = Double.parseDouble(request.getParameter("edit_item_price"));
                is.update(itemId, name, price, category, email);
            }

            List<Item> items = is.getAll(email);
            List<Category> categories = is.getAllCategories();
            request.setAttribute("items", items);
            request.setAttribute("categories", categories);
            request.setAttribute("add", true);
            
        } catch (Exception ex)
        {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
        }

        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
        return;
    }
}
