<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.SupermarketInterface"%>
<%@ page import="models.Supermarket"%>
<%@ page import="java.util.Vector"%>
    
<html>
<head>
<title>Client Markets In Web</title>
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<!-- link for menu icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Add icon library -->
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
  height: 300px;
  width: 100%;
}

.element_body{
	height: 50%;
	overflow: auto;
}
.element_footer{
	background-color: #f2f2f2;
	font-size: 30px;
	border-radius: 8px;
	color: black;
	height: 50%;
	
}


/*image into column*/
.img-responsive{
	max-width: 100px;	
}
#homeIcon{
	right: 5px;
	float: right;
}
#head_title{
	float: left;
}
.checked {
  color: orange;
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
	if (user_type == 2)
		return;
}
%>
<header>
<!-- header of page -->
<label id="head_title" style="font-size:30px">Markets In Web</label>
<i class="fa fa-home" id="homeIcon"style="font-size:30px;color:black" onclick="history.back()"/></i>
</header>
<br>

<nav>
<div class="grid-container">
	<%
	Vector<Supermarket> result = SupermarketInterface.getAllMarkets();
	Supermarket current_market = new Supermarket();
	for(int i=0; i<result.size(); i++){
		current_market = result.elementAt(i);
		String image = current_market.getImage_link();
		String website = current_market.getWebsite();
		String name = current_market.getSuper_name();
		int quality = (int)current_market.getQuality();
		%>
		  <div class="column">
		    <div class="element_body"><br><img src=<%=image%> class="img-responsive" alt="Image"></div>
			<div class="element_footer"><br>
			<%for(int j=0; j<quality;j++){%>
				<span class="fa fa-star checked"></span>
			<%}
			for(int k=0; k<(5-quality); k++){%>
				<span class="fa fa-star"></span>
			<%}%>
			<label style="font-size:20px;">(<%=current_market.getReviewers_no()%> reviews)</label>
				<br><br><a style="font-size: 30px" href=<%=website%>><%=name%></a>
			</div>
		  </div>
	<%}%>


  
</div>
</nav>
</body>
</html>