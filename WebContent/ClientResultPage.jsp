<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.ClientInterface"%>
<%@ page import="controller.SupermarketInterface"%>
<%@ page import="models.Supermarket"%>
<html>
<head>
<meta charset="windows-1255">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Client Result Page</title>
</head>
<style>
body{
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 30px;
}
/* Set a style for all buttons */
button {
  background-color: #ff8533;
  color: black;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 10%;
  opacity: 0.9;
  border-radius: 8px;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

.button:hover {
  opacity: 1;
}
</style>
<body>
<%
if(session.isNew()){
	request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	return;
}
else{
	if(session.getAttribute("login") == null){
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
		return;
	}
}
%>

<%
String market_name = session.getAttribute("profitableMarket").toString();
double market_price = Double.valueOf(session.getAttribute("price").toString());
String client_email = session.getAttribute("client_email").toString();
String markets_inAlg = session.getAttribute("markets_inAlg").toString();
ClientInterface.deleteCurrentCart(client_email);
Supermarket market = SupermarketInterface.getMarket(market_name);
%>
<%if(markets_inAlg != null){ %>

<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px; float: left;">Create Shopping Cart</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black;float: right;" onclick="document.location.href='HomePage.jsp'"/></i>
</header>

<center>
<br><br>
<p style=font-size:30px;>The profitable market for this cart is:</p>
<p><img src="<%=market.getImage_link()%>"></p>
<p>The price of the cart is: <%=market_price%> NIS.</p>
<p style="font-size: 20px;">Please Notice: The algorithm was executed only for the following markets: <%=markets_inAlg%>.</p>
<p style="font-size:20px;">The reason some markets might not participate in the algorithm is that some products from the cart are not sold there.</p>

</center>
<%}%>
<%if(markets_inAlg == null){%>
	<p>There are no markets that sell the whole products you choose on your cart.</p>
<%} %>

</body>
</html>