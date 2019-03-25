package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.SupermarketInterface;
import models.Supermarket;

@WebServlet("/AddSupermarket.java")
public class AddSupermarket extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		 response.setContentType("text/html;charset=UTF-8");
		 int inSystem = 0;
		 String market_name = request.getParameter("s_name").toString();
		 String market_web = request.getParameter("s_link").toString();
		 String market_image = request.getParameter("image_link").toString();
		 System.out.println("--> super name: " + market_name);
		 try {
			 Supermarket market = SupermarketInterface.getMarket(market_name);
			if(market != null) {
				inSystem = 1;
				request.getRequestDispatcher("/ExistUser.jsp").forward(request, response);
			 }
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		 
		 if(inSystem == 0) {
			 try {
				SupermarketInterface.insertSuper(market_name, market_web, market_image);
				System.out.println("--> new market had been inserted market name: " + market_name);
				request.getRequestDispatcher("/MarketAdded.jsp").forward(request, response);
			} catch (IllegalAccessException |ClassNotFoundException | SQLException e) {e.printStackTrace();}
		 }		 
	}

}
