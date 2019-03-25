package views;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import controller.UserInterface;
import models.User;

@WebServlet("/Login.java")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  response.setContentType("text/html;charset=UTF-8");
	      int user_type;
	      String user_email = request.getParameter("email").toString();
	      String user_password = request.getParameter("psw").toString();
	      System.out.println("--> user email: " + user_email + " user password: " + user_password);

	      try {	
	    	  	User user = UserInterface.getUser(user_email, user_password);
	    	  	if(user!=null){
	    	  		HttpSession session = request.getSession();
				    session.setAttribute("user_email", user_email);
				    session.setAttribute("user_password", user_password);
				    user_type = user.getUser_type();
			    	session.setAttribute("login", true);
				    session.setAttribute("user_type", user_type);
				    System.out.println("-->login.java: valid user");

				    /*case of market - update name*/
				    if(user_type == 1)
				    	session.setAttribute("market_name", user_password);
				    
				    request.getRequestDispatcher("/HomePage.jsp").forward(request, response);
	    	  	}
	    	  	else {
	    	  		System.out.println("-->login.java: invalid user");
	    	  		request.getRequestDispatcher("/InvalidUserOrPass.jsp").forward(request, response);
	    	  	}
	      } catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
	}

}
