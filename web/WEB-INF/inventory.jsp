<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory</title>
        <style>
            /*            .addUser {
                            float: left;
                        }
                        
                        .manageUsers {
                            float: left;
                        }
                        
                        .editUser {
                            float: left;
                        }*/

            table {
                border-collapse: collapse;
                border: 1px solid #dddddd;
            }

            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
            }
        </style>
    </head>
    <body>
        <h1>Home Inventory</h1>
        <h3>Menu</h3>
        <ul>
            <li><a href=inventory>Inventory</a></li>
            <li><a href=admin>Admin</a></li>
            <li><a href=login?logout>Logout</a></li>
        </ul>
        
        <div class="manageInventory">
        <h2>Inventory for ${firstName} ${lastName}</h2>
        <table class="inventoryTable">
            <tr>
                <th>Category</th>
                <th>Name</th>
                <th>Price</th>
                <th>Delete</th>
            </tr>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.category.categoryName}</td>
                    <td>${item.itemName}</td>
                    <td>$<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${item.price}"/></td>
                    <c:url value="/inventory" var="deleteurl">
                        <c:param name="action" value="delete"/>
                        <c:param name="itemID" value="${item.itemId}"/>
                    </c:url>
                    <td><a href="${deleteurl}"><input type="button" name="delete_button" value="Delete"></a></td>
                </tr>
            </c:forEach>
        </table>
        </div>
        <br>
        ${message}
        
        <div class="addItem">
            <h2>Add Item</h2>
            <form method="post" action="inventory">
                <label>Category:</label>
                <select name="categoryList" id="categoryList">
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}">${category.categoryName}</option>
                </c:forEach>
                </select>
                <br>
                <label>Name:</label>
                <input type="text" name="add_item_name" value="">
                <br>
                <label>Price:</label>
                <input type="text" name="add_item_price" value="">
                <br>
                <input type="hidden" name="action" value="add_item">
                <input type="submit" value="Save">
            </form>
        </div>
    </body>
</html>
