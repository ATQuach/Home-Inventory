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
        <h1>Home nVentory</h1>
        <h3>Menu</h3>
        <ul>
            <li><a href=inventory>Inventory</a></li>
            <li><a href=admin>Admin</a></li>
            <li><a href=account>Account</a></li>
            <li><a href=login?logout>Logout</a></li>
        </ul>

        <h2>Admin Portal (Logged in as ${firstName} ${lastName})</h2>
        <div class="manageUsers">
            <h2>Manage Users</h2>
            <table class="usersTable">
                <tr>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Active</th>
                    <th>Delete</th>
                    <th>Edit</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.role.roleName}</td>
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

        ${message}
        <c:if test="${addUser == true}">
            <div class="addUser">
                <h3>Add User</h3>
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
                <h3>Edit ${editUser.email}</h3>
                <form action="admin" method="post">
                    <input type="hidden" name="edit_email" placeholder="Email" value="${editUser.email}">
                    <c:choose>
                        <c:when test="${editUser.active == true}">
                            <input type="checkbox" name="edit_active" checked="checked" value="true" />
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" name="edit_active" value="true" />
                        </c:otherwise>
                    </c:choose>    
                    Active
                    <br>
                    <input type="text" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
                    <br>
                    <input type="text" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
                    <br>
                    <input type="password" name="edit_password" placeholder="Password" value="${editUser.password}">
                    <br>
                    <select name="edit_roles">
                        <option value="1" <c:if test="${editUser.role.roleId == 1 }">selected</c:if>>system admin</option>
                        <option value="2" <c:if test="${editUser.role.roleId == 2 }">selected</c:if>>regular user</option>
                        <option value="3" <c:if test="${editUser.role.roleId == 3 }">selected</c:if>>company admin</option>
                        </select>
                        <br>
                        <input type="hidden" name="action" value="edit">
                        <input type="submit" value="Save">
                    </form>
                </div>
        </c:if>


        <div class="manageCategories">
            <h2>Manage Categories</h2>
            <table class="categoriesTable">
                <tr>
                    <th>Category</th>
                    <th>Edit</th>
                </tr>
                <c:forEach var="category" items="${categories}">
                    <tr>
                        <td>${category.categoryName}</td>                
                        <c:url value="/admin" var="editurl">
                            <c:param name="action" value="edit_category"/>
                            <c:param name="categoryId" value="${category.categoryId}"/>
                        </c:url>
                        <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit"></a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        ${message2}
        
        <c:if test="${addCategory == true}">
            <div class="addCategory">
                <h3>Add Category</h3>
                <form method="post" action="admin">
                    <input placeholder="Category" type="text" name="add_category">
                    <br>
                    <input type="hidden" name="action" value="addCategory">
                    <input type="submit" value="Save">
                </form>
            </div>
        </c:if>

        <c:if test="${editCate == true}">
            <div class="editCategory">
                <h2>Edit Category</h2>
                <form method="post" action="admin">
                    <input type="hidden" name="edit_category_id" placeholder="CategoryID" value="${editCategory.categoryId}">
                    <input placeholder="Category" type="text" name="edit_category" value="${editCategory.categoryName}">
                    <br>
                    <input type="hidden" name="action" value="editCategory">
                    <input type="submit" value="Save">
                </form>
            </div>
        </c:if>

    </body>
</html>
