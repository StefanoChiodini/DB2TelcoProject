<%@ page import="java.util.List" %>
<%@ page import="it.polimi.db2telcoproject.entity.Service" %>
<%@ page import="it.polimi.db2telcoproject.entity.OptionalProduct" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Welcome to the employee application</h1>
<div style="text-align: right">
    Hi ${user.username} <br>
    <form action="logout" method="GET">
        <input type="submit" value="logout">
    </form>
</div>
<h2>For info about the sales go to the Sales Report Page</h2>
<button><a href="sales-report">Sales Report Page</a></button>
<div>
    Here you can create a new optional product
</div>
<form action="opc-servlet" method="post">
    Name: <input type="text" name="nameOp" required><br>
    MonthlyFee: <input type="number" name="fee" step="any" min="0" required><br>
    <input type="submit" value="Create Optional Product">
</form>
<p>${creationError}</p>
<div>
    Here you can create a new service package
</div>
<%
    List<Service> existingServices = (List<Service>) request.getSession().getAttribute("existingServices");
    List<OptionalProduct> existingProducts = (List<OptionalProduct>) request.getSession().getAttribute("existingProducts");
%>
<form action="pc-servlet" method="post">
    Name: <input type="text" name="namePkg" required><br>
    <fieldset name="selectedServices">
        <legend>Select the services associated with the new Service Package</legend>
        <%
            for(Service s : existingServices) {
        %>
        <input type="checkbox" name="selectedServices" value="<%=s.getServId()%>"><%=s.getName()%><br>
        <%
            }
        %>
    </fieldset>
    <input type="number" name="validity12" step="any" placeholder="Fee for 12 months" required>
    <input type="number" name="validity24" step="any" placeholder="Fee for 24 months" required>
    <input type="number" name="validity36" step="any" placeholder="Fee for 36 months" required> <br>
    <fieldset name="selectedProducts">
        <legend>Selected the optional products which can be bind to this package</legend>
        <%
            for(OptionalProduct o : existingProducts) {
        %>
        <input type="checkbox" name="selectedProducts" value="<%=o.getProdId()%>"><%=o.getName()%>, Monthly Fee: <%=o.getMonthlyFee()%><br>
        <%
            }
        %>
    </fieldset>
    <input type="submit" value="Create Package">
</form>
<p>${creationError}</p>
</body>
</html>
