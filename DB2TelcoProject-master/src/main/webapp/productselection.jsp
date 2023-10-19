<%@ page import="it.polimi.db2telcoproject.entity.Package" %><%--
  Created by IntelliJ IDEA.
  User: nnzcs
  Date: 12/04/2022
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Select Optional Products</title>
</head>
<%
    Package selectedPackage = (Package) request.getSession().getAttribute("selectedPackage");
    String name = selectedPackage.getName();
%>
<body>
You have selected package <%=name%>
</body>
</html>
