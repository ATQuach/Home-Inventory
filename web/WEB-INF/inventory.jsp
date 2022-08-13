<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home nVentory</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body>

        <div class="container">
            <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
                <a href="inventory" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                    <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
                    <span class="fs-4">Home nVentory</span>
                </a>

                <ul class="nav nav-pills">
                    <li class="nav-item"><a href="inventory" class="nav-link active" aria-current="page">Home</a></li>
                        <c:if test="${showAdmin == true}">
                            <li class="nav-item"><a href="admin" class="nav-link">Admin</a></li>
                        </c:if>
                    <li class="nav-item"><a href="account" class="nav-link">Account</a></li>
                    <li class="nav-item"><a href="login?logout" class="nav-link">Logout</a></li>
                </ul>
            </header>
        </div>

        <div class="container">
            <h2 class="text-left">Inventory for ${firstName} ${lastName}</h2>
            <br>
            <table class="table table-hover">
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
                        <td><a href="${deleteurl}"><input type="button" name="delete_button" value="Delete" class="btn btn-primary"></a></td>
                                <c:url value="/inventory" var="editurl">
                                    <c:param name="action" value="edit"/>
                                    <c:param name="itemID" value="${item.itemId}"/>
                                </c:url>
                        <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit" class="btn btn-primary"></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    <center><h3>${message}</h3></center>
    <br>

    <c:if test="${add == true}">
        <div class="text-center">
            <h3>Add Item</h3>
            <form method="post" action="inventory">
                <label class="form-label">Category</label>
                <select class="w-auto form-select container" name="categoryList" id="categoryList">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.categoryName}</option>
                    </c:forEach>
                </select>
                <br>

                <div class="w-50 container">
                    <div class="row">
                        <div class="col">
                            <input type="text" class="form-control" placeholder="Name" aria-label="Name" name="add_item_name">
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" placeholder="Price" aria-label="Price" name="add_item_price">
                        </div>
                    </div>
                </div>
                <br>


                <input type="hidden" name="action" value="add_item">
                <input type="submit" value="Save" class="btn btn-primary">
            </form>
        </div>
    </c:if>

    <c:if test="${edit == true}">
        <div class="editItem text-center">
            <h2>Edit Item</h2>
            <form method="post" action="inventory">
                <input type="hidden" name="edit_item_id" placeholder="ItemID" value="${editItem.itemId}">
                <label class="form-label">Category</label>
                <select class="w-auto form-select container" name="edit_category" id="categoryList">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}" <c:if test="${editItem.category.categoryId == category.categoryId }">selected</c:if>>${category.categoryName}</option>
                    </c:forEach>
                </select>
                <br>
                <div class="w-50 container">
                    <div class="row">
                        <div class="col">
                            <input type="text" class="form-control" aria-label="Name" name="edit_item_name" value="${editItem.itemName}">
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" aria-label="Price" name="edit_item_price" value="${editItem.price}">
                        </div>
                    </div>
                </div>
                <br>

                <input type="hidden" name="action" value="edit_item">
                <input type="submit" value="Save" class="btn btn-primary">
            </form>
        </div>
    </c:if>
</body>
</html>
