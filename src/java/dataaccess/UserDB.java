package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import models.User;

/**
 *
 * @author Andrew Quach
 */
public class UserDB
{

    public List<User> getAll() throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try
        {
            List<User> userList = em.createNamedQuery("User.findAll", User.class).getResultList();
            return userList;
        } finally
        {
            em.close();
        }
    }

    public User get(String email) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try
        {
            User user = em.find(User.class, email);
            return user;
        } finally
        {
            em.close();
        }
    }

    public void insert(User user) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction et = em.getTransaction();

        try
        {
            et.begin();
            em.persist(user);
            et.commit();
        } catch (Exception e)
        {
            et.rollback();
        } finally
        {
            em.close();
        }
    }

    public void update(User user) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction et = em.getTransaction();
        try
        {
            et.begin();
            em.merge(user);
            et.commit();
        } catch (Exception e)
        {
            et.rollback();
        } finally
        {
            em.close();
        }
    }

    public void delete(User user) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction et = em.getTransaction();
        try
        {
            et.begin();
            em.remove(em.merge(user));
            et.commit();
        } catch (Exception e)
        {
            et.rollback();
        } finally
        {
            em.close();
        }
    }

}
