<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body class="text-center">
        <main class="form-signin w-199 m-auto">
        <form method="post" action="login">
        <h1>Home nVentory</h1>
        <h2 class="h3 mb-3 fw-normal">Login</h2>
            <label for="floatingInput">Email:</label>
            <input type="email" name="email" value="" id="floatingInput" class="form_control" placeholder="name@example.com">
            <br>
            <label for="floatingInput">Password:</label>
            <input type="password" name="password" value="" id="floatingInput" class="form_control">
            <br>
            <input type="submit" value="Login" class="btn btn-sm btn-secondary">
        </form>
        <form action="register" value="">
            <input type="submit" value="Register" class="btn btn-sm btn-secondary" />
        </form>
        ${message}
        </div>
        </main>
    </body>
</html>
