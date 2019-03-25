<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.ProductInterface"%>
<%@ page import="models.Product"%>
<%@ page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Products Storage</title>
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' crossorigin='anonymous'>
<style>
* {box-sizing: border-box}

/* Set height of body and the document to 100% */
body, html {
  height: 100%;
  margin: 0;
  font-family: Shuneet, Helvetica, sans-serif;
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
  cursor: pointer;
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
/* Full-width input fields */
input[type=text] {
  width: 100%;
  padding: 10px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

input[type=text]:focus {
  background-color: #ddd;
  outline: none;
  font-family: Shuneet, Helvetica, sans-serif;
}

/* Set a style for all buttons */
button[type=submit] {
  background-color: white;
  color: black;
  border: none;
  cursor: pointer;
  opacity: 0.9;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

.button[type=submit]:hover {
  opacity: 1;
}
p{
	text-align: center;
	font-size: 30px;
}
table {
    font-family: Shuneet, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
  border: 1px solid #000000;
  text-align: center;
  padding: 8px;
  font-size: 25px;
}

tr:nth-child(even) {
  background-color: white;
}
h2{
	text-align:center;
}
.container {
	width: 93%;
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
	if (user_type != 2)
		return;
}
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px; float:left;">Products Storage</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black; float: right;" onclick="history.back()"/></i>
</header>
<%
Vector<Product> result = ProductInterface.getAllProducts();
Product current_product = new Product();
%>
<br><br>
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
</div>

<center>

<div id="AllProducts" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}%>  
</table>
</form>
</div>
</div>

<div id="Meat&Fish" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Meat&Fish")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="DairyProducts" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Dairy Products")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="Cleaners" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Cleaners")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="Legumes" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Legumes")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="Fruits&Vegetables" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Fruits&Vegetables")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="Drinks&Alcohol" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Drinks&Alcohol")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>

<div id="Other" class="tabcontent">
<div class="container">
<form action="RemoveProduct.java" method="POST">
<br><br>
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Delete From Storage</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String image = current_product.getProduct_image();
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		if(category.equals("Other")){
 %>
  <tr>
    <td><%=name%></td>
    <td><%=company%></td>
	<td><button id="remove" type="submit" name="product" value="<%=name%>_<%=company%>">
	<i class='fas fa-trash-alt' style='font-size:25px'></i></button>
	</td>
  </tr>
 <%}}%>  
</table>
</form>
</div>
</div>


</center>
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


