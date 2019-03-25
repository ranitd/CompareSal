<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%> 
    
<html>
<head>
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- link for animation style -->
<link rel="stylesheet" type="text/css" href="css/animations.css">
<!-- links for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' crossorigin='anonymous'>
<style>
* {box-sizing: border-box;}
body { 
  margin: 0;
  font-family: Shuneet, Helvetica, sans-serif;

}
#object{
	background-color: #ffffff;
	visibility: hidden;
}

.overlay {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0, 0.9);
  overflow-x: hidden;
  transition: 0.5s;
}

.overlay-content {
  position: relative;
  top: 25%;
  width: 100%;
  text-align: center;
  margin-top: 30px;
}

.overlay a {
  padding: 8px;
  text-decoration: none;
  font-size: 36px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.overlay a:hover, .overlay a:focus {
  color: #f1f1f1;
}

.overlay .closebtn {
  position: absolute;
  top: 20px;
  right: 45px;
  font-size: 60px;
}
#menu{
	float: left;
}
</style>
</head>
<body>
<%
	if(session.getAttribute("login") == null){
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
		return;
	}
	int user_type = (Integer)session.getAttribute("user_type");
	String user = null;
%>
<%if(user_type == 0){
	user = session.getAttribute("user_email").toString();
%>
<div id="myNav" class="overlay">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <div class="overlay-content">
    <a href="ClientRatePage.jsp">Rate Markets</a>
    <a href="MarketsInWeb.jsp">Markets In Web</a>
	<a href="AboutUs.jsp">About Us</a>
	<a href="index.jsp">Log off</a>	
  </div>
</div>
<br><br>
<div id = "menu">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<i class="fa fa-th" style="font-size:30px;color:black" onclick="openNav()"></i>&nbsp;&nbsp;&nbsp;&nbsp;
<i class="fas fa-cart-plus" style="font-size:30px;color:black" onclick="document.location.href='NewShoppingCart.jsp'"></i>
</div>
<%}%>
<%if(user_type == 1){
	user = session.getAttribute("market_name").toString();
%>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<i class="fa fa-th" style="font-size:30px;color:black;" onclick="openNav()"></i></div>
<div id="myNav" class="overlay">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <div class="overlay-content">
    <a href="MarketsProducts.jsp">Update Storage</a>	
    <a href="MarketsInWeb.jsp">Markets In Web</a>
	<a href="index.jsp">Log off</a>	
  </div>
</div>	
<%}%>
<%if(user_type == 2){
	user = "Adminisration";
%>
<br>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<i class="fa fa-th" style="font-size:30px;color:black;" onclick="openNav()"></i></div>
<div id="myNav" class="overlay">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <div class="overlay-content">
    <a href="ProductStorage.jsp">Products Storage</a>
    <a href="AddProduct.jsp">Add New Product</a>
	<a href="AdminMarketsInWeb.jsp">Supermarkets In Web</a>
	<a href="AddSupermarket.jsp">Add New Supermarket</a>	
	<a href="index.jsp">Log off</a>	
  </div>
</div>	
<%}%>
<div style="margin-top:210px;">
	<center>
	<div id="object" class="fadeIn"><label style="font-size: 30px;"><%=user%></label><br>
	<img src="images/compareSall_orange_circle.png" width="20%">
	</div></center>
</div>
<script>
<!-- script for menu button -->
function openNav() {
  document.getElementById("myNav").style.width = "100%";
}
function closeNav() {
  document.getElementById("myNav").style.width = "0%";
}
</script>
</body>
</html>