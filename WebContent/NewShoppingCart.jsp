<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.ProductInterface"%>
<%@ page import="controller.ClientInterface"%>
<%@ page import="models.Product"%>
<%@ page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<head>
<title>Shopping Cart</title>
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- link for menu icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body{
	font-family: Shuneet, Helvetica, sans-serif;
	font-size: 50px;
}
nav{
	height: 580px;
	overflow: auto;	
}
.tabcontent {
  display: none;
}
.grid-container {
  display: grid;
  grid-template-columns: 10% 10% 10% 10% 10% 10% 10% 10% 10%;
  grid-column-gap: 10px;
  grid-row-gap: 10px;;
  background-color: white;
  padding: 10px;
  height: 5px;
  justify-content: center;  
}

.grid-container > div {
  text-align: center;
  font-size: 30px;
  border: 1px solid black;
  border-radius: 8px;
  text-align: center;
  padding-top: 10px;
  height: 200px;
  width: 100%;

}

.element_body{
	height: 60%;
	overflow: auto;
}
.element_footer{
	background-color: #f2f2f2;
	font-size: 17px;
	border-radius: 8px;
	color: black;
	height: 40%;
	
}

/* Set a style for all buttons */
button, input[type=button], input[type=submit] {
  background-color: #ff8533;
  padding: 5px 10px;
  margin: 5px 0;
  border: none;
  cursor: pointer;
  width: 60%;
  height: 40%;
  border-radius: 8px;
  text-align: center;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 17px;
}

/*image into column*/
.img-responsive{
	max-width: 80px;	
}

/*toolbar above products*/
/* Add a black background color to the top navigation */
.topnav {
  background-color: #ff8533;
  overflow: hidden;
  padding: 0px 0px;
  border-radius: 8px;
}

/* Style the links inside the navigation bar */
.topnav a {
  float: left;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 25px;
}

/* Change the color of links on hover */
.topnav a:hover {
  background-color: #ddd;
  color: black;
}

/* Add a color to the active/current link */
.topnav a.active {
  background-color: #ddd;
  color: black;
}
/* Style the search box inside the navigation bar */
.topnav input[type=text] {
  float: left;
  padding: 6px;
  border: none;
  margin-top: 8px;
  margin-left: 16px;
  font-size: 17px;
  border-radius: 8px;
}

/* Set a style for all buttons */
#endCart {
  background-color: #ff8533;
  color: black;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  border-radius: 8px;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 25px;
  text-align: center;
}
.tablink {
	cursor: pointer;
}

input[type=text]{
	width: 13%;
	padding: 5px 10px;
	margin: 5px 0;
	border: none;
	cursor: pointer;
	height: 27%;
	border-radius: 8px;
	text-align: center;
	font-family: Shuneet, Helvetica, sans-serif;
	font-size: 17px;	
}
</style>
</head>
<body>
<%
if(session.getAttribute("login") == null){
	request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	return;
}
else{
	int user_type = (Integer)session.getAttribute("user_type");
	if (user_type != 0)
		return;
}
%>

<%
String client_email = session.getAttribute("user_email").toString();
session.setAttribute("client_email", client_email);
ClientInterface.createCurrentCart(client_email);
Vector<Product> all_products = ProductInterface.getAllProducts();
Vector<Product> cart_products = ClientInterface.getCurrentCart(client_email);
Product current_product = new Product();
Product inCart_product = new Product();
int quantity;
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px; float: left;">Create Shopping Cart</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black;float: right;" onclick="document.location.href='HomePage.jsp'"/></i>
</header>
<br>

<!-- product list -->
<div class="topnav">
  <a class="tablink" onclick="openPage('AllProducts', this)" id="defaultOpen">All Products</a>
  <a class="tablink" onclick="openPage('Meat&Fish', this)">Meat&Fish</a>
  <a class="tablink" onclick="openPage('DairyProducts', this)">Dairy Products</a>
  <a class="tablink" onclick="openPage('Cleaners', this)">Cleaners</a>
  <a class="tablink" onclick="openPage('Legumes', this)">Legumes</a>
  <a class="tablink" onclick="openPage('Fruits&Vegetables', this)">Fruits&Vegetables</a>
  <a class="tablink" onclick="openPage('Drinks&Alcohol', this)">Drinks&Alcohol</a>
  <a class="tablink" onclick="openPage('Other', this)">Other</a>
 <!--  <input id="search" type="text" placeholder="Search.."> -->
</div>
<nav>
<div id="AllProducts" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		inCart_product = ClientInterface.getProduct(client_email, name, company);
		if(inCart_product != null){
			quantity = inCart_product.getProduct_quantity();
		}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
  

<%}%>
</div>
</div>
<div id="Meat&Fish" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Meat&Fish")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="DairyProducts" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Dairy Products")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="Cleaners" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Cleaners")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="Legumes" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Legumes")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="Fruits&Vegetables" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Fruits&Vegetables")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="Drinks&Alcohol" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Drinks&Alcohol")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
<div id="Other" class="tabcontent">
<div class="grid-container">
<%
	for(int i=0; i<all_products.size(); i++){
		quantity = 0;
		current_product = all_products.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Other")){
			inCart_product = ClientInterface.getProduct(client_email, name, company);
			if(inCart_product != null){
				quantity = inCart_product.getProduct_quantity();
			}
%>
  	<div class="column">
    <div class="element_body"><img src=<%=image%> class="img-responsive" alt="Image"></div>
	<div class="element_footer">
			<label><%=name%></label><br>
			<label><%=company%></label><br>
			<form action="UpdateClientCurrentCart.java" method="POST">
			<input type="text" name="product_name" value="<%=name%>" style="display:none;">
			<input type="text" name="product_company" value="<%=company%>" style="display:none;">	
			<input type="submit" id="productButton" value="Update Cart">		  
			<input type="text" name="product_quantity" value="<%=quantity%>"></form>	
	</div>	
  </div>
<%}}%>
</div>
</div>
</nav>
<footer>
	<form action="CalcMarketAlgorithm.java" method="POST">
	<input type="submit" id="endCart" value="End Shopping Cart">
	</form>
</footer>

<script>
	function openPage(pageName, elmnt){
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
			  tabcontent[i].style.display = "none";
		  }
			  
		  tablinks = document.getElementsByClassName("tablink");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].style.backgroundColor = "#ff8533";
		  }
		  document.getElementById(pageName).style.display = "block";
		  elmnt.style.backgroundColor = "#ddd";
	}
	//Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
</script>

</body>
</html>