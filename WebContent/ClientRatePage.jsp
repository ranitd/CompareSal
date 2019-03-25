<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.SupermarketInterface"%>
<%@ page import="models.Supermarket"%>
<%@ page import="java.util.Vector"%>
<html>
<head>
<title>Client Rating Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body, html {
  height: 100%;
  font-family: Shuneet, Helvetica, sans-serif;
}

* {
  box-sizing: border-box;
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

::placeholder{
	color: black;
}

/* Full-width input fields */
input[type=text], select {
  width: 100%;
  padding: 15px;
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
button, input[type=button] {
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

.button:hover {
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
	if (user_type != 0)
		return;
}
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px">Rate Markets</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black;float:right;" onclick="history.back()"/></i>
</header>
<br>
<form action="ClientRating.java" method="POST">
  <div class="container">	
    <label for="name">Supermarket Rating</label>

	<select id="market" name="supermarkets" required="" oninvalid="this.setCustomValidity('Incorrect market')" oninput="setCustomValidity('')">
		<option value="">Choose Supermarket</option>
			<%
	Vector<Supermarket> result = SupermarketInterface.getAllMarkets();
	Supermarket current_market = new Supermarket();
	for(int i=0; i<result.size(); i++){
		current_market = result.elementAt(i);
		String name = current_market.getSuper_name();
		%>
		<option value="<%=name%>"><%=name%></option>
		<%}%>
  </select>
  
      <label for="name">Rating Value</label>

	<select name="review" required="" oninvalid="this.setCustomValidity('Incorrect Rating')" oninput="setCustomValidity('')">
		<option id="rate_review" value="">Choose a value</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
  </select>
	<button type="submit">Send</button>
  </div>
  </form>
</body>
</html>