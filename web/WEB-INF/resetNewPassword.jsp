<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset New Password</title>
    </head>
    <body>
        <h1>Enter a new password</h1>
        <form action="reset" method="post">
            <input type="password" name="newPassword" value="">
            <br>
            <input type="hidden" name="reset" value="uuid">
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
