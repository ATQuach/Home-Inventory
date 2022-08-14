package services;

import dataaccess.RoleDB;
import dataaccess.UserDB;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import models.Role;
import models.User;

public class AccountService
{

    public List<User> getAll() throws Exception
    {
        UserDB userDB = new UserDB();
        List<User> users = userDB.getAll();
        return users;
    }

    public User login(String email, String password)
    {
        UserDB userDB = new UserDB();

        try
        {
            User user = userDB.get(email);
            if (password.equals(user.getPassword()) && user.getResetPasswordUuid() == null)
            {
                return user;
            }
        } catch (Exception e)
        {
        }

        return null;
    }

    public User get(String email) throws Exception
    {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        return user;
    }

    public void insert(String email, boolean active, String firstName, String lastName, String password, int roleId) throws Exception
    {
        User user = new User(email, active, firstName, lastName, password);
        RoleDB roleDB = new RoleDB();
        Role role = roleDB.get(roleId);
        user.setRole(role);
        UserDB userDB = new UserDB();
        userDB.insert(user);
    }

    public boolean insertNewUser(String email, boolean active, String firstName, String lastName, String password, int roleId) throws Exception
    {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        if (user == null)
        {
            User newUser = new User(email, active, firstName, lastName, password);
            RoleDB roleDB = new RoleDB();
            Role role = roleDB.get(roleId);
            newUser.setRole(role);
            userDB.insert(newUser);
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public void update(String email, boolean active, String firstName, String lastName, String password, int roleId) throws Exception
    {
        RoleDB roleDB = new RoleDB();
        Role role = roleDB.get(roleId);
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        user.setRole(role);
        user.setActive(active);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPassword(password);
        userDB.update(user);
    }

    public void delete(String email) throws Exception
    {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        userDB.delete(user);
    }

    public User resetPassword(String email, String path, String url)
    {
        UserDB userDB = new UserDB();

        try
        {
            User user = userDB.get(email);
            String uuid = UUID.randomUUID().toString();
            user.setResetPasswordUuid(uuid);
            userDB.update(user);
            String to = user.getEmail();
            String subject = "Home nVentory Reset Password";
            String template = path + "/emailtemplates/resetPassword.html";
            String link = url + "?uuid=" + uuid;

            HashMap<String, String> tags = new HashMap<>();
            tags.put("firstname", user.getFirstName());
            tags.put("lastname", user.getLastName());
            tags.put("link", link);
         
            
            GmailService.sendMail(to, subject, template, tags);

            return user;
        } catch (Exception e)
        {
        }

        return null;
    }

    public boolean changePassword(String uuid, String password)
    {
        UserDB userDB = new UserDB();
        try
        {
            User user = userDB.getByUUID(uuid);
            user.setPassword(password);
            user.setResetPasswordUuid(null);
            userDB.update(user);
            return true;
        } catch (Exception ex)
        {
            return false;
        }
    }
}
