package views;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.UserInterface;
import models.User;

@WebServlet("/Registration.java")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   response.setContentType("text/html;charset=UTF-8");
	   int inSystem = 0;
	   String user_email = request.getParameter("email").toString();
	   String user_password = request.getParameter("psw").toString();   
	   System.out.println("--> user email: " + user_email + " user password: " + user_password);
	   
		try {
				User user = UserInterface.getUser(user_email, user_password);
				if (user != null) {
					inSystem = 1;
					request.getRequestDispatcher("/ExistUser.jsp").forward(request, response);
			   }
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e1) {e1.printStackTrace();}   
	   
	   if(inSystem == 0) {
		   try {
			   UserInterface.insertUser(user_email, user_password, 0);
			   System.out.println("--> new user client had been inserted user email: " + user_email);
			   request.getRequestDispatcher("/UserAdded.jsp").forward(request, response);
		   } catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}

	   	}
	}

}
