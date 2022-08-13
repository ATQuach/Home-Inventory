<%-- 
    Document   : register
    Created on : 10-Aug-2022, 10:21:32 AM
    Author     : Andrew Quach
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body class="container text-center">
        <main class="form-signin w-199 m-auto">
            <form method="post" action="register">
                <h1 class="form-control-dark">Home nVentory</h1>
                <h3>Register</h3>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" placeholder="name@example.com" name="add_email">
                    <label>Email address</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" placeholder="Password" name="add_password">
                    <label>Password</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" placeholder="First Name" name="add_first_name">
                    <label>First Name</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" placeholder="Last Name" name="add_last_name">
                    <label>Last Name</label>
                </div>
                <input type="submit" name="action" value="Submit" class="btn btn-lg btn-primary">
                <br>
                <br>
                <button onclick="location.href = 'login'" type="button" class="btn btn-lg btn-primary">Back</button>
            </form>
            ${message}
        </main>
    </body>
</html>
