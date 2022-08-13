<%-- 
    Document   : account
    Created on : 10-Aug-2022, 11:05:39 AM
    Author     : Andrew Quach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
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
        
    <c:if test="${edit == true}">
        <div class="editUser">
            <h2>${editUser.email}</h2>
            <h3>Edit Account</h3>
            <form action="account" method="post">
                <input type="hidden" name="edit_email" placeholder="Email" value="${editUser.email}">
                <label>First Name:</label>
                <input type="text" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
                <br>
                <label>Last Name:</label>
                <input type="text" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
                <br>
                <label>Password:</label>
                <input type="password" name="edit_password" placeholder="Password" value="${editUser.password}">
                <br>
                <input type="hidden" name="action" value="edit">
                <input type="submit" value="Save">
            </form>
            ${message}
            <br>
            <br>
            <c:url value="/account" var="editurl">
                <c:param name="action" value="deactivate"/>
                <c:param name="email" value="${editUser.email}"/>
            </c:url>
            <a href="${editurl}"><input type="button" name="deactivate" value="Deactivate Account"></a>
            <br>
            ${message2}
        </div>
    </c:if>
</body>
</html>
