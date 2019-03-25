<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<html>
<head>
<meta charset="windows-1255">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<title>Error</title>
</head>
<style>
body{
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 30px;
}
/* Set a style for all buttons */
button {
  background-color: #ff8533;
  color: black;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 10%;
  opacity: 0.9;
  border-radius: 8px;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

.button:hover {
  opacity: 1;
}
</style>
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
<center>
<p>The product is already in CompareSall storage</p>
<button type="button" class="agreebtn" onclick="history.back()">Back</button>
</center>
</body>
</html>