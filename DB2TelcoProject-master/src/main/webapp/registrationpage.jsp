<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Registration Page</title>
</head>
<body>
<h1>SIGN IN</h1>
<form action="register-servlet" method="POST">
    Username: <input type="text" name="username" required><br>
    Password: <input type="password" name="pwd" required><br>
    Email: <input type="text" name="mail" required><br>
    Employee: <input type="checkbox" name="employee" id="employee" value="employee">
    <br>
    <input type="submit" value="Register">
    <p>${errorMsgReg}</p>
</form>
<p>If you already have an account go back to the landing page</p>
<form>
    <button><a href="landingpage.jsp">Landing Page</a></button>
</form>
</body>