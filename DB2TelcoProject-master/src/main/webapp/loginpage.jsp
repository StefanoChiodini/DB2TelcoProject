<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login page</title>
</head>
<body>
<h1>TELCO SERVICE LOGIN</h1>

<form action="login-servlet" method="POST">
    Username: <input type="text" name="username" required><br>
    Password: <input type="password" name="pwd" required><br>
    <br>
    <input type="submit" value="Login">
    <p>${errorMsg}</p>
</form>
<br>
<p>If you haven't an account go back to the <a href="landingpage.jsp">LandingPage</a></p>


</body>
</html>