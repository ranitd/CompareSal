<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add New Supermarket</title>
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

/* Style tab links */
.tablink {
  background-color: #ff8533;
  color: black;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 35px;
  width: 20%;
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
/* Add styles to the form container */
.container {
  position: absolute;
  right: 31%;
  margin: 20px;
  max-width: 550px;
  padding: 16px;
  height: 480px;
  font-size: 25px;
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
<label id="head_title" style="font-size:30px; float:left;">Adding new supermarket</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black; float: right;" onclick="history.back()"/></i>
</header>

	<form action="AddSupermarket.java" method="POST" class="container">
	<br><br>
		<p>Adding new supermarket</p>	
		<label for="s_name">Supermarket Name</label>
		<input type="text" placeholder="Enter supermarket name" name="s_name" required="" oninvalid="this.setCustomValidity('Enter supermarket name')" oninput="setCustomValidity('')">
		<br>
		<label for="s_link">Supermarket Link</label>
		<input type="text" placeholder="Enter supermarket link" name="s_link" required="" oninvalid="this.setCustomValidity('Enter supermarket link')" oninput="setCustomValidity('')">
		<br>
		<label for="image_link">Supermarket Image Link</label>
		<input type="text" placeholder="Enter supermarket image link" name="image_link" required="" oninvalid="this.setCustomValidity('Enter supermarket image link')" oninput="setCustomValidity('')">
		<button type="submit">Add Supermarket</button>
	</form>
</body>
</html> 