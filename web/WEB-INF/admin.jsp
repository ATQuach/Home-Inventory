<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
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

        <div class="manageUsers">
            <h2>Manage Users</h2>
            <table class="usersTable">
                <tr>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Active</th>
                    <th>Role</th>
                    <th>Delete</th>
                    <th>Edit</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.active}">
                                    <c:set var="Yes" value="true" />Yes
                                </c:when>
                                <c:otherwise>
                                    <c:set var="No" value="false" />No  
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${user.role.roleName}</td>
                        <c:url value="/admin" var="deleteurl">
                            <c:param name="action" value="delete"/>
                            <c:param name="email" value="${user.email}"/>
                        </c:url>                     
                        <td><a href="${deleteurl}"><input type="button" name="delete_button" value="Delete"></a></td>
                                <c:url value="/admin" var="editurl">
                                    <c:param name="action" value="edit"/>
                                    <c:param name="email" value="${user.email}"/>
                                </c:url>
                        <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit"></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <br>
        ${message}
        <c:if test="${add == true}">
            <div class="addUser">
                <h2>Add User</h2>
                <form method="post" action="admin">
                    <input placeholder="Email" type="email" name="add_email">
                    <br>
                    <input type="checkbox" name="add_active" value="true">Active
                    <br>
                    <input placeholder="First Name" type="text" name="add_first_name">
                    <br>
                    <input placeholder="Last Name" type="text" name="add_last_name">
                    <br>
                    <input placeholder="Password" type="password" name="add_password">
                    <br>
                    <select name="add_roles" id="roles">
                        <option value="1">system admin</option>
                        <option value="2">regular user</option>
                        <option value="3">company admin</option>
                    </select>
                    <br>
                    <input type="hidden" name="action" value="add">
                    <input type="submit" value="Save">
                </form>
            </div>
        </c:if>

        <c:if test="${edit == true}">
            <div class="editUser">
                <h2>Edit ${editUser.email}</h2>
                <form action="admin" method="post">
                    <input type="text" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
                    <br>
                    <input type="text" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
                    <br>
                    <input type="password" name="edit_password" placeholder="Password" value="${editUser.password}">
                    <br>
                    <input type="hidden" name="action" value="edit">
                    <input type="submit" value="Save">
                </form>
            </div>
        </c:if>

    </body>
</html>