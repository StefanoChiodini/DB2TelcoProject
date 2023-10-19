<%--
  Created by IntelliJ IDEA.
  User: nnzcs
  Date: 21/04/2022
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order completed</title>
</head>
<body>
<%
    if(request.getSession().getAttribute("failedPayment")==null) {
%>
<div>
    <h1>Order Completed</h1> <br>
    <p>Go back to the home page</p> <br>
    <form action="logout" method="get">
        <input type="submit" value="Landing Page">
    </form>
</div>
<%
    } else {
%>
<div>
    <h1>Order Failed</h1> <br>
    <p>Go back to the landing page to try the payment again</p><br>
    <form action="logout" method="get">
        <input type="submit" value="Landing Page">
    </form>

</div>
<%
    }
%>
</body>
</html>
