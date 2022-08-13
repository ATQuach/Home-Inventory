<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Home nVentory</h1>
        <h2>Login</h2>
        <form method="post" action="login">
            <label>Email:</label>
            <input type="email" name="email" value="">
            <br>
            <label>Password:</label>
            <input type="password" name="password" value="">
            <br>
            <input type="submit" value="Login">
        </form>
        <form action="register" value="">
            <input type="submit" value="Register" />
        </form>
        ${message}
    </body>
</html>
