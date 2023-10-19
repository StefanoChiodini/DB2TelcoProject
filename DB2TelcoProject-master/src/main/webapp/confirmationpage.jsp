<%@ page import="java.util.ArrayList" %>
<%@ page import="it.polimi.db2telcoproject.entity.OptionalProduct" %>
<%@ page import="it.polimi.db2telcoproject.entity.Package" %>
<%@ page import="java.util.Date" %>
<%@ page import="it.polimi.db2telcoproject.entity.Order" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: nnzcs
  Date: 13/04/2022
  Time: 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Confirmation page</title>
</head>
<body>
<%
    if(request.getSession().getAttribute("existingOrder")==null) {
    Package selectedPackage = (Package) request.getSession().getAttribute("selectedPackage");
    float totalValue = (float) request.getSession().getAttribute("totalValue");
    int validityPeriod = (int) request.getSession().getAttribute("validityperiod");

%>
<h1>
    You have selected the following package with these optional products:
</h1>
<div style="text-align: right">
    <p>
        Hi ${user.username}
    </p>
</div>
<div>
    Chosen package: <%=selectedPackage.getName()%> <br>
    With these characteristics: <br>
    Validity Period: <%=validityPeriod%> months <br>
    Start date: <%=request.getSession().getAttribute("start-date").toString()%> <br>
</div>
<%
    if(request.getSession().getAttribute("selectedOptProducts")!=null) {
%>
<div>
    These are the optional products selected
<%
    ArrayList<OptionalProduct> selectedOptionalProducts = (ArrayList<OptionalProduct>) request.getSession().getAttribute("selectedOptProducts");
    for (OptionalProduct p : selectedOptionalProducts) {
%>
    <br><%=p.getName()%>
    <%}%>
</div>
<%}%>
<br>
<div>
    <p>The total amount to pay is <%=totalValue%>€</p>
</div>
<%
    if(request.getSession().getAttribute("user")!=null) {
%>
<div>
    <form action="order-servlet?payment=true" method="post">
        <input type="submit" value="Buy (payment accepted)">
    </form>
    <form action="order-servlet" method="post">
        <input type="submit" value="Buy (payment rejected)">
    </form>
</div>
<%
    } else {
        request.getSession().setAttribute("token", true);
%>
<div>
    Please login or register to complete the order
    <button><a href="loginpage.jsp">Login</a></button>
</div>
<%
    }} else {
    Order existingOrder = (Order) request.getSession().getAttribute("existingOrder");
%>
<h1>
    You have selected the following package with these optional products:
</h1>
<div>
    Chosen package: <%=existingOrder.getPkgId().getName()%> <br>
    With these characteristics: <br>
    Validity Period: <%=existingOrder.getValidityPeriod()%> months <br>
    Start date: <%=existingOrder.getStartDate().toString()%> <br>
</div>
<%
    if(existingOrder.getSelectedProducts() != null && !existingOrder.getSelectedProducts().isEmpty()) {
%>
<div>
    These are the optional products selected
    <%
        List<OptionalProduct> selectedOptionalProducts = existingOrder.getSelectedProducts();
        for (OptionalProduct p : selectedOptionalProducts) {
    %>
    <br><%=p.getName()%>
    <%}%>
</div>
<%}%>
<br>
<div>
    <p>The total amount to pay is <%=existingOrder.getTotalValue()%>€</p>
</div>
<div>
    <form action="order-servlet?payment=true" method="post">
        <input type="submit" value="Buy (payment accepted)">
    </form>
    <form action="order-servlet" method="post">
        <input type="submit" value="Buy (payment rejected)">
    </form>
</div>
<%
    }
%>

</body>
</html>
