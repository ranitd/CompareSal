package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.SupermarketInterface;


@WebServlet("/RemoveMarket.java")
public class RemoveMarket extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String market_name = request.getParameter("market_name");
		try {
			SupermarketInterface.deleteMarket(market_name);
			System.out.println("the market " + market_name + " was deleted");
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		
		/*return to the web*/
		request.getRequestDispatcher("/AdminMarketsInWeb.jsp").forward(request, response);
	}

}
