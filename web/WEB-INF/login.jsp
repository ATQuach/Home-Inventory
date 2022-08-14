<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body class="container div">
        <main class="form-signin w-199 m-auto">
            <form method="post" action="login">
                <h1 class="form-control-dark">Home nVentory</h1>
                <br>
                <h2>Login</h2>
                <div class="mb-3">
                    <label for="formGroupExampleInput" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="formGroupExampleInput" placeholder="name@example.com">
                </div>
                <div class="mb-3">
                    <label for="formGroupExampleInput2" class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" id="formGroupExampleInput2" placeholder="Type your password">
                </div>
                <br>
                <a href="reset">Forgot password?</a>
                <br><br>
                <input type="submit" value="Login" class="btn btn-lg btn-outline-primary">
            </form>
            <br>
            <form action="register" value="">
                <input type="submit" value="Register" class="btn btn-lg btn-outline-primary" />
            </form>
            <br>
            ${message}
            </div>
        </main>
    </body>
</html>
