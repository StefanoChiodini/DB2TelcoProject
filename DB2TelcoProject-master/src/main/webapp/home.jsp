<%@ page import="java.util.List" %>
<%@ page import="it.polimi.db2telcoproject.entity.*" %>
<%@ page import="it.polimi.db2telcoproject.entity.Package" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Home</title>
</head>
<body>
<%
    User connectedUser = null;
    List<Package> packages = (List<Package>) request.getSession().getAttribute("packages");
    if (request.getSession().getAttribute("user") != null)
        connectedUser = (User) request.getSession().getAttribute("user");
    if (connectedUser != null) {
%>
<div>
    <h1>WELCOME TO THE TELCO-SERVICE HOME</h1>
    <div style="text-align: right">
        <p>
            Hi ${user.username}
        </p>
        <form action="logout" method="GET">
            <input type="submit" value="logout">
        </form>
    </div>
</div>
<%
    if(connectedUser.isInsolvent()) {
%>
   <div>
       Failed payment for one or more order(s): <br>

       <form action="confirmation-servlet?existingOrder=true" method="post">
           <fieldset name = "selectedOrder">
               <legend>Select the order you want to try the payment again for</legend>
               <%
                   for(Order o : connectedUser.getOrders()) {
                       if(!o.isPaid()) {
               %>
               <input type="radio" name="selectedOrder" value="<%=o.getOrderId()%>"><%=o.getPkgId().getName()%>, amount to pay: <%=o.getTotalValue()%><br>
               <%
                       }}
               %>
           </fieldset>
           <input type="submit" value="Retry Payment">
       </form>

   </div>
<%
    }
%>
<%
} else {
%>
<h1>WELCOME TO THE TELCO-SERVICE HOME</h1>
<p>
    Hi guest
</p>
<button><a href="landingpage.jsp">Landing Page</a></button>
<%
    }//here im printing the list of all packages proposed by the application,
    //this is the section made by the guest and not for the logged user
    for (Package p : packages) {
%>
<p>
    <%=p.getName()%>:<br> <%
    int period = 12;
    for (PackagesPrices q : p.getPrices()) {
    %>
    <%=period%> months:
    <%=q.getValue()%> euros <br>
    <%
            period += 12;
    }
    %>
    <%
        if (p.getService1Id() != null) {
    %>
    <%=p.getService1Id().getName()%>
    <%
        }
    %>
    <%
        if (p.getService2Id() != null) {
    %>
    <%=p.getService2Id().getName()%>
    <%
        }
    %>
    <%
        if (p.getService3Id() != null) {
    %>
    <%=p.getService3Id().getName()%>
    <%
        }
    %>
    <%
        if (p.getService4Id() != null) {
    %>
    <%=p.getService4Id().getName()%>
    <%
        }
    %>
</p> <br>
<%
    }%>
<div>
    <!--this is only a redirect to buyPage-->
    If you have found a service package you're interested in please proceed to the buy page
    <button><a href="buypage.jsp">Buy Page</a></button>
</div>
</body>
</html>