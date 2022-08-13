package services;

import dataaccess.CategoryDB;
import models.Category;

/**
 *
 * @author Andrew Quach
 */
public class CategoryService
{
    public Category get(int categoryID) throws Exception 
    {
        CategoryDB categoryDB = new CategoryDB();
        Category category = categoryDB.get(categoryID);
        return category;
    }
    
    public void insert(String categoryName) throws Exception
    {
        Category category = new Category(0, categoryName);
        CategoryDB categoryDB = new CategoryDB();
        categoryDB.insert(category);
    }
    
    public void update(int categoryID, String categoryName) throws Exception
    {
        CategoryDB categoryDB = new CategoryDB();
        Category category = categoryDB.get(categoryID);
        category.setCategoryName(categoryName);
        categoryDB.update(category);
    }
}
