<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.ProductInterface"%>
<%@ page import="controller.SupermarketInterface"%>
<%@ page import="models.Product"%>
<%@ page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<head>
<title>Products Of Market</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- link for menu icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
* {box-sizing: border-box}

/* Set height of body and the document to 100% */
body, html {
  height: 100%;
  margin: 0;
  font-family: Shuneet, Helvetica, sans-serif;
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
/* Style tab links */
.tablink {
  background-color: #ff8533;
  color: black;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 34px;
  width: 12.5%;
  height: 8%;
  font-family: Shuneet, Helvetica, sans-serif;
}

.tablink:hover {
  background-color: #ddd;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
  color: black;
  display: none;
  padding: 100px 20px;
  height: 100%;
}

/* Full-width input fields */
input[type=text] {
  width: 80px;
  height: 20px;
  padding: 5px;
  margin: 5px 0 5px 0;
  border: none;
  background: #f1f1f1;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
  text-align:center;
}

input[type=text]:focus {
  background-color: #ddd;
  outline: none;
  font-family: Shuneet, Helvetica, sans-serif;

}

/* Set a style for all buttons */
button[type=submit] {
  background-color: #ff8533;
  border-radius: 2px;
  color: black;
  border: none;
  cursor: pointer;
  opacity: 0.9;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
  width:50%;
  height: 30%;
  border-radius: 6px;
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
  padding: 4px;
  font-size: 25px;
}

tr:nth-child(even) {
  background-color: white;
}
h2{
	text-align:center;
}
.container {
	height: 600px;
}
.tablink {
	cursor: pointer;
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
	if (user_type != 1)
		return;
}
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px">Products Storage</label>
<i class="fa fa-home" style="font-size:30px;color:black; float:right;" onclick="history.back()"/></i>
</header><br>
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
<%
String market_name = session.getAttribute("market_name").toString();
Vector<Product> result = SupermarketInterface.getAllProducts(market_name);
Product current_product = new Product();
%>
<div id="AllProducts" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
 %>
  <form action="UpdateProductInMarket.java" method="POST">
  <tr>
  <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>	
  </tr>
   </form>
 <%}%>  
 </table>

 </div></div>
<div id="Meat&Fish" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Meat&Fish")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
   <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
  </form>
 <%}}%>  
 </table>
 </div></div>
<div id="DairyProducts" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Dairy Products")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
    <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
<div id="Cleaners" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Cleaners")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
    <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
<div id="Legumes" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Legumes")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
    <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
<div id="Fruits&Vegetables" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Fruits&Vegetables")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
    <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
<div id="Drinks&Alcohol" class="tabcontent">
<div class="container">
<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Drinks&Alcohol")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
   <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
<div id="Other" class="tabcontent">
<div class="container">

<table>
  <tr>
    <th>Product Name</th>
	<th>Product Company</th>
    <th>Product Category</th>
    <th>Product Status</th>
    <th>Price</th>
    <th>Action</th>
  </tr>
 <%
	for(int i=0; i<result.size(); i++){
		current_product = result.elementAt(i);
		String name = current_product.getProduct_name();
		String company = current_product.getProduct_company();
		String category = current_product.getProduct_category();
		double price = current_product.getProduct_price();
		boolean exist = current_product.isProduct_exist();
		if(category.equals("Other")){
 %>
 <form action="UpdateProductInMarket.java" method="POST">
  <tr>
   <input type="text" name="product_name" value="<%=name%>" style="display:none;">
  <input type="text" name="product_company" value="<%=company%>" style="display:none;">
  <input type="text" name="product_category" value="<%=category%>" style="display:none;">
    <td><%=name%></td>
    <td><%=company%></td>
    <td><%=category%></td>
    <td>
    <%if(price == 0){%>
    <label>Not In Supermarket</label>
    <%}else{%>
    <label>In Supermarket</label><%} %>
    </td>
	<td> <input type="text" name="price" value=<%=price%>></td>
	<td> <button type="submit">Update Price</button></td>
  </tr>
   </form>
 <%}}%>  
 </table>
 </div></div>
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


