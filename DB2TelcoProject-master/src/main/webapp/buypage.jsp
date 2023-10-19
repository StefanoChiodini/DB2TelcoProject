<%@ page import="it.polimi.db2telcoproject.entity.User" %>
<%@ page import="it.polimi.db2telcoproject.entity.Package" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="it.polimi.db2telcoproject.entity.OptionalProduct" %>
<%@ page import="it.polimi.db2telcoproject.entity.PackagesPrices" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Package> packages = (List<Package>) request.getSession().getAttribute("packages");
%>
<html>
<head>
    <title>Buy Page</title>
</head>
<body>

<%if (request.getSession().getAttribute("user")!=null) {
    User connectedUser = (User) request.getSession().getAttribute("user");
    String username = connectedUser.getUsername();
%>
<div>
    <h1>Welcome in the buy page, select a package to create an order</h1>
    <div style="text-align: right">
        Hi <%=username%> <br>
        <form action="logout" method="GET">
            <input type="submit" value="logout">
        </form>
    </div>
</div>

<%
} else {
%>
<div>
    <h1>Welcome in the buy page, select a package to create an order</h1>
    <div style="text-align: right">
        Hi guest <br>
        <button><a href="landingpage.jsp">Landing Page</a></button>
    </div>
</div>
<%}
%>
<div>
    <form action="#">
        <select name="packages">
            <%
                //this is the package form; this creates a selectable package list
                for (Package p : packages) {
            %>
            <option value="<%=p.getPkgId()%>"><%=p.getName()%></option>
            <%}%>
        </select>
        <input type="submit" value="Select">
    </form>
</div>
<div>
    <%
        Package selected = null;
        for(Package p :packages) {
            if (request.getParameter("packages")!=null && p.getPkgId() == Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("packages")))) {
                out.println("The selected package has the following characteristics");
                out.println("<br>" + p.getService1Id().getName());
                selected = p;
                request.getSession().setAttribute("selectedPackage", selected);
                if(p.getService2Id()!=null)
                    out.println("<br>" + p.getService2Id().getName());
                if(p.getService3Id()!=null)
                    out.println("<br>" + p.getService3Id().getName());
                if(p.getService4Id()!=null)
                    out.println("<br>" + p.getService4Id().getName());
            }
        }
    %>
</div>
<% if (selected!=null) { %>
<div>
    <form action="confirmation-servlet" method="post">
        <fieldset name="selectedproducts">
            <legend>Select your optional products</legend>
            <%if(selected.getProducts()!=null && !selected.getProducts().isEmpty()) {
                for (OptionalProduct product : selected.getProducts()) {
            %>
            <input type="checkbox" name="selectedproducts" value="<%=product.getProdId()%>"><%=product.getName()%> = <%=product.getMonthlyFee()%>€/month</input>
            <br>
            <%}}%>
        </fieldset>
        <select name="validityperiod">
            <%
                int period = 0;
                for(PackagesPrices prices : selected.getPrices()) {
                    float value = prices.getValue();
            %>
            <option value="<%=period+=12%>"><%=period%> months= <%=value%>€/month</option>
            <%}%>
        </select>
        <label for="start-date">Select the start date of your order</label>
        <input type="date" id="start-date" name="start-date" value="2022-05-11" min="2022-05-11" max="2022-12-31">
        <input type="submit" value="Buy">
    </form>
</div>
<% }%>
</body>
</html>
