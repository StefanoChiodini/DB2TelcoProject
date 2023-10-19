<%@ page import="java.util.List" %>
<%@ page import="it.polimi.db2telcoproject.entity.*" %>
<%@ page import="it.polimi.db2telcoproject.entity.Package" %><%--
  Created by IntelliJ IDEA.
  User: nnzcs
  Date: 28/04/2022
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sales Report</title>
</head>
<%
    List<Package> packages = (List<Package>) request.getSession().getAttribute("packages");
%>
<body>
<h1>Welcome to the sales report page</h1>
<div style="text-align: right">
    Hi ${user.username} <br>
    <form action="logout" method="GET">
        <input type="submit" value="logout">
    </form>
</div>
<div>
    <form action="sales-report" method="post">
        <select name="packages">
            <%
                for (Package p : packages) {
            %>
            <option value="<%=p.getPkgId()%>"><%=p.getName()%></option>
            <%}%>
        </select>
        <br>
        <select name="validityPeriod">
            <option value="-">-</option>
            <option value="12">12</option>
            <option value="24">24</option>
            <option value="36">36</option>
        </select><br>
        <input type="submit" value="Select">
    </form>
</div>
<%
    if(request.getSession().getAttribute("orders")!=null) {
        List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
        float valueWOpt = (float) request.getSession().getAttribute("valueWOpt");
        float valueWoOpt = (float) request.getSession().getAttribute("valueWoOpt");
        float averageOptSold = (float) request.getSession().getAttribute("averageOptSold");
        int totalSales = (int) request.getSession().getAttribute("totalSales");

%>
<div>
    <h3>Stats for the selected package (and validity period)</h3>
    <h4>Orders containing the selected package (and validity period)</h4>
    <p>Total sales: <%=totalSales%></p>
    <%
        for (Order o : orders) {
    %>
    <p>Order: <%=o.getOrderId()%>, total value: <%=o.getTotalValue()%>, validity period: <%=o.getValidityPeriod()%>, associated User <%=o.getUsername().getUsername()%></p><br>
    <%
        }
    %>
    <h4>Total values of sales with optional products</h4>
    <p><%=valueWOpt%></p><br>
    <h4>Total values of sales without optional products</h4>
    <p><%=valueWoOpt%></p><br>
    <h4>Average number of optional products sold</h4>
    <p><%=averageOptSold%></p><br>
</div>
<%
    }
%>
<%
    List<User> insolventUsers;
    List<Order> suspendedOrders;
    List<Alert> existingAlerts;
    OptionalProduct bestseller;
    Float bestsellerValue;
    try {
        insolventUsers= (List<User>) request.getSession().getAttribute("insolventUsers");
        suspendedOrders = (List<Order>) request.getSession().getAttribute("suspendedOrders");
        existingAlerts = (List<Alert>) request.getSession().getAttribute("activeAlerts");
        bestseller = (OptionalProduct) request.getSession().getAttribute("bestsellerOpt");
        bestsellerValue = (Float) request.getSession().getAttribute("bestsellerValue");
%>
<div>
    <h3>List of insolvent Users:</h3>
    <%
        for(User u : insolventUsers) {
    %>
    <p>Username: <%=u.getUsername()%> has failed <%=u.getFailedPayments()%> payment(s)</p><br>
    <%
        }
    %>
    <h3>List of suspended Orders:</h3>
    <%
        for(Order o : suspendedOrders) {
    %>
    <p>Order with OrderId=<%=o.getOrderId()%> is not paid, amount to pay: <%=o.getTotalValue()%>, connected User <%=o.getUsername().getUsername()%></p><br>
    <%
        }
    %>
    <h3>List of Alerts:</h3>
    <%
        for(Alert a : existingAlerts) {
    %>
    <p>Alert with alertId: <%=a.getAlertId()%>, last payment rejected value: <%=a.getAmount()%> for orderId <%=a.getFailedOrderId()%>. User: <%=a.getUsername()%>, email <%=a.getEmail()%></p><br>
    <%
        }
    %>
    <h3>Bestseller optional product</h3>
    <p>The bestseller optional product is: <%=bestseller.getName()%>, which generated a total value of <%=bestsellerValue%>€</p>
</div>
<%
    } catch (Exception ignored) {}
%>
</body>
</html>
