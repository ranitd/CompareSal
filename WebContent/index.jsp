<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<%@ page import="controller.ClientInterface"%>
<%@ page import = "controller.StartInterface"%>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- link for font -->
<link href='http://serve.fontsproject.com/css?family=Shuneet:400' rel='stylesheet' type='text/css'>
<style>
body, html {
  height: 100%;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 25px;
}

* {
  box-sizing: border-box;
}

img { 
  width: 40%; 
  height: 30%;

}

/* Add styles to the form container */
.container {
  position: absolute;
  right: 37%;
  margin: 20px;
  max-width: 400px;
  padding: 16px;
  height: 480px;
}

/* Full-width input fields */
input[type=email], input[type=password] {
  width: 100%;
  padding: 10px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

input[type=email]:focus, input[type=password]:focus {
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

</style>
</head>
<body>
<%
	/*remove the last session*/
	if(!session.isNew())
		session.removeAttribute("login");
	StartInterface.checkDatabase();
%>
<form action="Login.java" method="POST">
  <div class="container">
  <center>
  <img src="images/compareSall_orange.png">
  </center>
	<br>
    <label for="email">Email Address</label>
    <input type="email" placeholder="Please enter an email" name="email"  required="" oninvalid="this.setCustomValidity('Incorrect email address')" oninput="setCustomValidity('')">
   
   <label for="psw">Password</label>
    <input type="password" placeholder="Please enter a password" name="psw" required="" oninvalid="this.setCustomValidity('Please enter a password')" oninput="setCustomValidity('')">
	<center>

    <button type="submit" class="signupbtn">Login</button>
	<br>
	<input type="button" value="Registration" onclick="document.location.href='RegistrationPage.jsp'">
	</center>
	</div>
</form>

</body>
</html>