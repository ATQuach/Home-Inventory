package services;

import dataaccess.CategoryDB;
import dataaccess.ItemDB;
import dataaccess.UserDB;
import java.util.List;
import models.Category;
import models.Item;
import models.User;

public class InventoryService {

    public List<Item> getAll(String email) throws Exception {
        ItemDB itemsDB = new ItemDB();
        List<Item> items = itemsDB.getAll(email);
        return items;
    }
    
    public List<Category> getAllCategories() throws Exception {
        CategoryDB categoriesDB = new CategoryDB();
        List<Category> categories = categoriesDB.getAll();
        return categories;
    }

    public Item get(int itemID) throws Exception {
        ItemDB itemsDB = new ItemDB();
        Item item = itemsDB.get(itemID);
        return item;
    }

    public void insert(String itemName, double price, int categoryId, String owner) throws Exception {
        Item item = new Item(0, itemName, price);
        UserDB userDB = new UserDB();
        User user = userDB.get(owner);
        item.setOwner(user);
        Category category = new Category(categoryId);
        item.setCategory(category);
        
        ItemDB itemsDB = new ItemDB();
        itemsDB.insert(item);
    }

    public void update(int itemID, String itemName, double price, int categoryId, String owner) throws Exception {
        ItemDB itemsDB = new ItemDB();
        Item item = itemsDB.get(itemID);
        item.setItemName(itemName);
        item.setPrice(price);
        CategoryDB categoryDB = new CategoryDB();
        Category category = new Category(categoryId);
        item.setCategory(category);
        UserDB userDB = new UserDB();
        User user = userDB.get(owner);
        item.setOwner(user);
        itemsDB.update(item);
    }
    
    public boolean delete(int itemID, String email) throws Exception {
        ItemDB itemsDB = new ItemDB();
        Item item = itemsDB.get(itemID);
        if (item.getOwner().getEmail().equals(email)) {
            itemsDB.delete(item);
            return true;
        } 
        return false;
    }

}
