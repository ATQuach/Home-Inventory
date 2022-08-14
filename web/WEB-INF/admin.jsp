<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
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
                    <li class="nav-item"><a href="admin" class="nav-link active" aria-current="page">Admin</a></li>
                    <li class="nav-item"><a href="account" class="nav-link">Account</a></li>
                    <li class="nav-item"><a href="login?logout" class="nav-link">Logout</a></li>
                </ul>
            </header>
        </div>

        <h2 class=" container text-left">Admin Portal for ${firstName} ${lastName}</h2>

        <div class="w-25 container text-left">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <c:url value="/admin" var="usersurl">
                        <c:param name="action" value="manageUsers"/>
                    </c:url>   
                    <a class="nav-link" aria-current="page" href="${usersurl}" name="action" value="manageUsers">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users align-text-bottom" aria-hidden="true"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                        Manage Users
                    </a>

                </li>
                <li class="nav-item">
                    <c:url value="/admin" var="categoriesurl">
                        <c:param name="action" value="manageCategories"/>
                    </c:url>    
                    <a class="nav-link" href="${categoriesurl}" name="action" value="manageCategories">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layers align-text-bottom" aria-hidden="true"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                        Manage Categories
                    </a>

                </li>
            </ul>
        </div>

        <c:if test="${show_manage_users == true}">
            <main class="col-md-9 ms-sm-auto col-lg-auto px-md-4">

                <h3 class="container text-left">Manage Users</h3>

                <div class="container d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">

                    <table class="table table-hover">
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
                                <td><a href="${deleteurl}"><input type="button" name="delete_button" value="Delete" class="btn btn-outline-primary"></a></td>
                                        <c:url value="/admin" var="editurl">
                                            <c:param name="action" value="edit"/>
                                            <c:param name="email" value="${user.email}"/>
                                        </c:url>
                                <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit" class="btn btn-outline-primary"></a></td>
                            </tr>
                        </c:forEach>
                    </table>


                    <br>
                    <c:if test="${addUser == true}">
                        <div class="w-50 container text-center">
                            <h3>Add User</h3>
                            <form class="container" method="post" action="admin">
                                <input class="form-control" placeholder="Email" type="email" name="add_email">
                                <br>
                                <input class="form-check-input" type="checkbox" name="add_active" value="true"> Active
                                <br>
                                <br>
                                <input class="form-control" placeholder="First Name" type="text" name="add_first_name">
                                <br>
                                <input class="form-control" placeholder="Last Name" type="text" name="add_last_name">
                                <br>
                                <input class="form-control" placeholder="Password" type="password" name="add_password">
                                <br>
                                <select class="w-auto form-select container" name="add_roles" id="roles">
                                    <option value="1">system admin</option>
                                    <option value="2">regular user</option>
                                    <option value="3">company admin</option>
                                </select>
                                <br>
                                <input type="hidden" name="action" value="add">
                                <input type="submit" value="Save" class="btn btn-outline-primary">
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${edit == true}">
                        <div class="w-50 container text-center">
                            <h3>Edit ${editUser.email}</h3>
                            <form class="container" action="admin" method="post">
                                <input type="hidden" name="edit_email" placeholder="Email" value="${editUser.email}">
                                <br>
                                <c:choose>
                                    <c:when test="${editUser.active == true}">
                                        <input class="form-check-input" type="checkbox" name="edit_active" checked="checked" value="true" />
                                    </c:when>
                                    <c:otherwise>
                                        <input class="form-check-input" type="checkbox" name="edit_active" value="true" />
                                    </c:otherwise>
                                </c:choose>   
                                Active
                                <br>
                                <br>
                                <input type="text" class="form-control" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
                                <br>
                                <input type="text" class="form-control" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
                                <br>
                                <input class="form-control" type="password" name="edit_password" placeholder="Password" value="${editUser.password}">
                                <br>
                                <select class="w-auto form-select container" name="edit_roles">
                                    <option value="1" <c:if test="${editUser.role.roleId == 1 }">selected</c:if>>system admin</option>
                                    <option value="2" <c:if test="${editUser.role.roleId == 2 }">selected</c:if>>regular user</option>
                                    <option value="3" <c:if test="${editUser.role.roleId == 3 }">selected</c:if>>company admin</option>
                                    </select>
                                    <br>
                                    <input type="hidden" name="action" value="edit">
                                    <input type="submit" value="Save" class="btn btn-outline-primary">
                                </form>

                            </div>

                    </c:if>
                    <center>${message}</center>
                </div>

            </c:if>

            <c:if test="${show_manage_categories == true}">
                <div class="container d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                    <br>
                    <div class="w-50 container">
                        <h3>Manage Categories</h3>
                        <br>
                        <table class="table table-hover">
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
                                    <td><a href="${editurl}"><input type="button" name="edit_button" value="Edit" class="btn btn-outline-primary"></a></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                    <br>
                    <div class="container text-center">
                        <c:if test="${addCategory == true}">
                            <div class="w-50 container">
                                <h3>Add Category</h3>
                                <form class="container" method="post" action="admin">
                                    <input class="form-control" placeholder="Category" type="text" name="add_category">
                                    <br>
                                    <input type="hidden" name="action" value="addCategory">
                                    <input type="submit" value="Save" class="btn btn-outline-primary">
                                </form>
                            </div>
                        </c:if>


                        <c:if test="${editCate == true}">
                            <div class="w-50 container">
                                <h3>Edit Category</h3>
                                <form class="container" method="post" action="admin">
                                    <input type="hidden" name="edit_category_id" placeholder="CategoryID" value="${editCategory.categoryId}">
                                    <input class="form-control" placeholder="Category" type="text" name="edit_category" value="${editCategory.categoryName}">
                                    <br>
                                    <input type="hidden" name="action" value="editCategory">
                                    <input type="submit" value="Save" class="btn btn-outline-primary">
                                </form>
                            </div>
                        </c:if>
                        <br>
                        <center>${message2}</center>
                    </div>
                </c:if>
        </main>
    </body>
</html>
