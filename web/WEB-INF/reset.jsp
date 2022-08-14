<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet" href="css/bootstrap.css"></link>
    </head>
    <body class="container text-center">
        <main class="form-signin w-199 m-auto">
            <form action="reset" method="post">
                <h1 class="form-control-dark">Home nVentory</h1>
                <h2 >Reset Password</h2>
                <p>Please enter your email address to reset your password.</p>
                <div class="form-floating mb-3">
                    Email address: <input type="email" class="form-control" name="email" value="">
                </div>
                <br>
                <input type="hidden" name="reset" value="reset">
                <input type="submit" value="Submit" class="btn btn-lg btn-primary">
                <br>
                <br>
                <button onclick="location.href = 'login'" type="button" class="btn btn-lg btn-primary">Back</button
                <br>
                <br>
                <br>
            </form>
            ${message}
        </main>
    </body>
</html>
