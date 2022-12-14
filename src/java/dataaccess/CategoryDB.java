package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import models.Category;

/**
 *
 * @author Andrew Quach
 */
public class CategoryDB {

    public List<Category> getAll() throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            List<Category> categoryList = em.createNamedQuery("Category.findAll", Category.class).getResultList();
            return categoryList;
        } finally {
            em.close();
        }
    }

    public Category get(int categoryID) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            Category category = em.find(Category.class, categoryID);
            return category;
        } finally {
            em.close();
        }
    }
    
    public void insert(Category category) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction et = em.getTransaction();
        
        try
        {
            et.begin();
            em.persist(category);
            et.commit();
        } catch (Exception e) 
        {
            et.rollback();
        } finally
        {
            em.close();
        }
    }

    public void update(Category category) throws Exception
    {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction et = em.getTransaction();
        try 
        {
            et.begin();
            em.merge(category);
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
