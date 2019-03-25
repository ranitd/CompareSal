<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<html>
<head>
<title>Registration</title>
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
  width: 25%; 
  height: 30%
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
input[type=email], input[type=password], input[type=text] {
  width: 100%;
  padding: 10px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
  font-family: Shuneet, Helvetica, sans-serif;
  font-size: 20px;
}

input[type=email]:focus, input[type=password]:focus, input[type=text]:focus {
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
  <form action="Registration.java" method="POST" class="container">
    <center>
   	 <img src="images/compareSall_orange.png">
   	</center>
  	<p>Please enter your personal details for registration</p>

	
    <label for="email">Email Address</label>
    <input type="email" placeholder="Enter your email address" name="email" required="" oninvalid="this.setCustomValidity('invalid email address')" oninput="setCustomValidity('')">

    <label for="psw">Password</label>
    <input type="password" id="psw" placeholder="Enter your password" name="psw" required="" oninvalid="this.setCustomValidity('Enter your password')" oninput="setCustomValidity('')">

    <label for="psw-repeat">Confirm Password</label>
    <input type="password" id="Cpsw" placeholder="Enter your confirm password" name="psw-repeat" required="" oninvalid="this.setCustomValidity('Please enter your confirm password')" oninput="setCustomValidity('')" onchange="checkValid()">
    
    <p>Creating the user confirms the <a href="TermsAndPolicies.jsp" style="color:dodgerblue">terms and policies</a>.</p>
	
	<button type="submit" class="signupbtn">Registration</button>
	<button type="button" class="cancelbtn" onclick="document.location.href='index.jsp'">Cancel</button>
  </form>
<script>
	function checkValid(){
	var psw = document.getElementById("psw").value;
	var cpsw = document.getElementById("Cpsw").value;
	if (psw != cpsw){
		document.getElementById("psw").value="";
		document.getElementById("Cpsw").value="";
		alert("Confirm password must be equal to password");
	}
	}
</script>
</body>
</html>