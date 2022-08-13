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
        <h1>Home nVentory</h1>
        <h3>Menu</h3>
        <ul>
            <li><a href=inventory>Inventory</a></li>
            <c:if test="${showAdmin == true}">
            <li><a href=admin>Admin</a></li>
            </c:if>
            <li><a href=account>Account</a></li>
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
                    <th>Edit</th>
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
                                <c:url value="/inventory" var="editurl">
                                    <c:param name="action" value="edit"/>
                                    <c:param name="itemID" value="${item.itemId}"/>
                                </c:url>
                        <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit"></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <br>
        ${message}

        <c:if test="${add == true}">
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
        </c:if>

        <c:if test="${edit == true}">
            <div class="editItem">
                <h2>Edit Item</h2>
                <form method="post" action="inventory">
                    <input type="hidden" name="edit_item_id" placeholder="ItemID" value="${editItem.itemId}">
                    <label>Category:</label>
                    <select name="edit_category" id="categoryList">
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}" <c:if test="${editItem.category.categoryId == category.categoryId }">selected</c:if>>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                    <br>
                    <label>Name:</label>
                    <input type="text" name="edit_item_name" value="${editItem.itemName}">
                    <br>
                    <label>Price:</label>
                    <input type="text" name="edit_item_price" value="${editItem.price}">
                    <br>
                    <input type="hidden" name="action" value="edit_item">
                    <input type="submit" value="Save">
                </form>
            </div>
        </c:if>
    </body>
</html>
