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
        
        <div class="container">
            <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
                <a href="inventory" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
                    <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
                    <span class="fs-4">Home nVentory</span>
                </a>

                <ul class="nav nav-pills">
                    <li class="nav-item"><a href="inventory" class="nav-link">Home</a></li>
                        <c:if test="${showAdmin == true}">
                        <li class="nav-item"><a href="admin" class="nav-link">Admin</a></li>
                        </c:if>
                    <li class="nav-item"><a href="account" class="nav-link  active" aria-current="page"">Account</a></li>
                    <li class="nav-item"><a href="login?logout" class="nav-link">Logout</a></li>
                </ul>
            </header>
        </div>

        <c:if test="${edit == true}">
            <div class="container">
                <h2>${editUser.email}</h2>
                <br>
                <h4>Edit Account</h4>
                <form action="account" method="post">
                    <input type="hidden" name="edit_email" placeholder="Email" value="${editUser.email}">
                    <label>First Name:</label>
                    <input class="form-control" type="text" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
                    <br>
                    <label>Last Name:</label>
                    <input class="form-control" type="text" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
                    <br>
                    <label>Password:</label>
                    <input class="form-control" type="password" name="edit_password" placeholder="Password" value="${editUser.password}">
                    <br>
                    <input type="hidden" name="action" value="edit">
                    <input type="submit" value="Save" class="btn btn-outline-primary">
                </form>
                ${message}
                <br>
                <br>
                <c:url value="/account" var="editurl">
                    <c:param name="action" value="deactivate"/>
                    <c:param name="email" value="${editUser.email}"/>
                </c:url>
                <br>
                <a href="${editurl}"><input type="button" name="deactivate" value="Deactivate Account" class="btn btn-outline-danger"></a>
                <br>
                <br>
                ${message2}
            </div>
        </c:if>
    </body>
</html>
