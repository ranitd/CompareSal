<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.SupermarketInterface"%>
<%@ page import="models.Supermarket"%>
<%@ page import="java.util.Vector"%>
    
<html>
<head>
<meta charset="windows-1255">
<title>Admin Markets In Web</title>
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- Add icon library -->
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' crossorigin='anonymous'>
<style>
* {box-sizing: border-box}
body{
	margin: 0px;
	font-family: Shuneet, Helvetica, sans-serif;
}

.grid-container {
  display: grid;
  grid-template-columns: 20% 20% 20% 20% ;
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
  height: 250px;
  width: 90%;
}
.element_header{
	height:15%;
}
.element_body{
	height: 40%;
	overflow: auto;
}
.element_footer{
	background-color: #f2f2f2;
	font-size: 30px;
	border-radius: 8px;
	color: black;
	height: 45%;	
}


/*image into column*/
.img-responsive{
	max-width: 110px;	
}
.checked {
  color: orange;
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
  width: 20%;
  height: 8%;
  font-family: Shuneet, Helvetica, sans-serif;
}

.tablink:hover {
  background-color: #ddd;
}
#remove {
	float: right;
	background-color: white;
	height: 35px;
	border: none;
 	cursor: pointer;
	opacity: 0.9;
  	border-radius: 8px;
}
#homeIcon{
	right: 5px;
	float: right;
}
#head_title{
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
else{
	int user_type = (Integer)session.getAttribute("user_type");
	if (user_type != 2)
		return;
}
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px">Markets In Web</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black" onclick="history.back()"/></i>
</header>

<form action="RemoveMarket.java" method="POST">
<br><br><br>
<div class="grid-container">
	<%
	Vector<Supermarket> result = SupermarketInterface.getAllMarkets();
	Supermarket current_market = new Supermarket();
	for(int i=0; i<result.size(); i++){
		current_market = result.elementAt(i);
		String image = current_market.getImage_link();
		String website = current_market.getWebsite();
		String name = current_market.getSuper_name();
		int quality = current_market.getQuality();
		%>
		<div class="column">
		<div class="element_header">
		<button id="remove" type="submit" name="market_name" value="<%=name%>">
		<i class='fas fa-trash-alt' style='font-size:30px'></i>
		</button></div>
		<div class="element_body"><br><center><img src=<%=image%> class="img-responsive" alt="Image"></center></div>
		<div class="element_footer"><br>
			<%for(int j=0; j<quality;j++){%>
			<span class="fa fa-star checked"></span>
			<%}
			for(int k=0; k<(5-quality); k++){%>
			<span class="fa fa-star"></span>
			<%}%>
			<br><a style="font-size: 30px" href=<%=website%>><%=name%></a>
		</div>
		</div>
		<%}%>
</div>
</form>

</body>
</html>