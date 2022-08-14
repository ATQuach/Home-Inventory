package servlets;

import dataaccess.UserDB;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import services.AccountService;

/**
 *
 * @author Andrew Quach
 */
public class ResetPasswordServlet extends HttpServlet {

    String uuid;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        uuid = request.getParameter("uuid");

        if (uuid != null) {

            getServletContext().getRequestDispatcher("/WEB-INF/resetNewPassword.jsp").forward(request, response);
            return;

        } else {

            getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
            return;

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURL().toString();
        String email = request.getParameter("email");
        AccountService as = new AccountService();
        String path = getServletContext().getRealPath("/WEB-INF");
        UserDB userDB = new UserDB();
        User user = new User();
        if (email != null) {
            try
            {
                user = userDB.get(email);
            } catch (Exception ex)
            {
                Logger.getLogger(ResetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        String reset = request.getParameter("reset");
        if (reset != null) {
            if (reset.equals("reset")) {
                if (user == null) {
                    String message = "Email address not found in the system.";
                    request.setAttribute("message", message);
                    getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
                    return;
                }
                as.resetPassword(email, path, url);
                String message = "Reset link has been sent to your email";
                request.setAttribute("message", message);
                getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
                return;
            }
            if (reset.equals("uuid")) {
                String newPassword = request.getParameter("newPassword");
                as.changePassword(uuid, newPassword);
                String message = "Password has been successfully changed. Please " + "<a href=login>Login</a>" + ".";
                request.setAttribute("message", message);
                getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
                return;
            }
        }

    }

}
