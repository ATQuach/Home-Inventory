<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset New Password</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body class="container text-center">
        <main class="form-signin w-199 m-auto">
            <form action="reset" method="post">
                <h1 class="form-control-dark">Home nVentory</h1>
                <h2>Enter a new password</h2>
                <input class="form-control" type="password" name="newPassword" value="">
                <br>
                <input type="hidden" name="reset" value="uuid">
                <input type="submit" value="Submit" class="btn btn-lg btn-outline-primary">
            </form>
        </main>
    </body>
</html>
