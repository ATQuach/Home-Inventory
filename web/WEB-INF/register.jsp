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
    <body>
        <h1>Home nVentory</h1>
        <h2>Register</h2>
        <form method="post" action="register">
            <label>Email:</label>
            <input type="email" name="add_email" value="">
            <br>
            <label>Password:</label>
            <input type="password" name="add_password" value="">
            <br>
            <label>First Name:</label>
            <input type="text" name="add_first_name" value="">
            <br>
            <label>Last Name:</label>
            <input type="text" name="add_last_name" value="">
            <br>
            <input type="submit" name="action" value="Submit">
            <br>
            <button onclick="location.href='login'" type="button">Back</button>
        </form>
        ${message}
    </body>
</html>
