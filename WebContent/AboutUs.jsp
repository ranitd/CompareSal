<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>


<html>
<head>
<title>About Us</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- link for menu icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body, html {
  height: 100%;
  font-family: Shuneet, Helvetica, sans-serif;
}

* {
  box-sizing: border-box;
}

img{
	width: 20%; 
	height: 30%;
}

/* Add styles to the form container */
.container {
  position: absolute;
  right: 25%;
  margin: 20px;
  max-width: 750px;
  padding: 16px;
  height: 480px;
  font-size: 25px;
}
#homeIcon{
	 position: relative;
 	 float: right;
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
<i id="homeIcon" class="fa fa-home" style="font-size:30px;color:black" onclick="history.back()"></i>
<div class="container">
    <center>
 	<img src="images/compareSall_orange.png">
  	</center>
    <p>Who we are?</p>
    <p>In CompareSall you can create your shopping cart you wish to purchase, and we will give you our recommendation from which supermarket this current shopping cart would be profitable.</p>
	<p>Please Notice: CompareSall do not take responsibility for the purchase!<p>
    <p>Contact us:	noBodyCares@gmail.com  1-800-800-800</p>
</div>
</body>
</html>