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
import services.AccountService;
import services.InventoryService;

/**
 *
 * @author Andrew
 */
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        InventoryService is = new InventoryService();
        AccountService as = new AccountService();
        String email = (String) session.getAttribute("email");
        
        if (session.getAttribute("email") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String action = request.getParameter("action");
            
            if (action != null && action.equals("delete")) {
                int itemId = Integer.parseInt(request.getParameter("itemID"));
                boolean isDeleted = is.delete(itemId, email);
                if (isDeleted) {
                    request.setAttribute("message", "Deleted item.");
                }
            }
            
            List<Item> items = is.getAll(email);
            request.setAttribute("items", items);
            
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
            
        } catch (Exception ex) {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        InventoryService is = new InventoryService();
        
        String action = request.getParameter("action");
        String itemId = request.getParameter("itemId");
        String categoryId = request.getParameter("categoryList");
        String itemName = request.getParameter("add_item_name");
        String itemPrice = request.getParameter("add_item_price");
        
        try {
            if (action != null && action.equals("add_item")) {
                is.insert(itemName, Integer.parseInt(itemPrice), Integer.parseInt(categoryId), username);
            }
            request.setAttribute("message", "Added item.");
        } catch (Exception ex) {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
        }

        try {
            List<Item> items = is.getAll(username);
            request.setAttribute("items", items);
            
            List<Category> categories = is.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (Exception ex) {
            Logger.getLogger(InventoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
        }
        
        getServletContext().getRequestDispatcher("/WEB-INF/inventory.jsp").forward(request, response);
        return;
    }
}
