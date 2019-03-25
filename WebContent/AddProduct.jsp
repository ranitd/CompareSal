<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add New Product</title>
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

/* Add styles to the form container */
.container {
  position: absolute;
  right: 33%;
  margin: 20px;
  max-width: 550px;
  padding: 16px;
  height: 480px;
  font-size: 25px;
}

/* Full-width input fields */
input[type=text], select {
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
  background-color: #ff8533;
  color: black;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
  border-radius: 8px;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

.button[type=submit]:hover {
  opacity: 1;
}
p{
	text-align: center;
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
<label id="head_title" style="font-size:30px; float: left;">Adding new product</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black; float: right;" onclick="history.back()"/></i>
</header>
	<form action="AddProduct.java" method="POST" class="container">
	<br><br>
  	<p>Adding new product</p>	
    <label for="p_name">Product Name</label>
    <input type="text" placeholder="Enter product name" name="p_name" required="" oninvalid="this.setCustomValidity('Enter product name')" oninput="setCustomValidity('')">
	<br>
    <label for="p_company">Product Company</label>
    <input type="text" placeholder="Enter product company" name="p_company" required="" oninvalid="this.setCustomValidity('Enter product company')" oninput="setCustomValidity('')">
	<br>
    <label for="p_category">Product Category</label>
	<select name="p_category">
		<option value="Other">Other</option>
		<option value="Meat&Fish">Meat&Fish</option>
		<option value="Dairy Products">Dairy Products</option>
		<option value="Cleaners">Cleaners</option>
		<option value="Legumes">Legumes</option>
		<option value="Fruits&Vegetables">Fruits&Vegetables</option>
		<option value="Drinks&Alcohol">Drinks&Alcohol</option>
  </select>
	<br>
	<label for="p_link">Image Link</label>
    <input type="text" placeholder="Enter link of the image" name="p_link" required="" oninvalid="this.setCustomValidity('Enter link of image')" oninput="setCustomValidity('')">
	<button type="submit" class="signupbtn">Add Product</button>
	</form>
</body>
</html> 