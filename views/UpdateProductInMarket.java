package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import controller.SupermarketInterface;

@WebServlet("/UpdateProductInMarket.java")
public class UpdateProductInMarket extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action;
		double price = Double.valueOf(request.getParameter("price"));
		String name = request.getParameter("product_name").toString();
		String company = request.getParameter("product_company").toString();
		String category = request.getParameter("product_category").toString();
		HttpSession session = request.getSession();
		String market_name = session.getAttribute("market_name").toString();
		/*define the action*/
		if(price == 0)
			action = "remove";
		else
			action="add";
			
		try {
			SupermarketInterface.updateProduct(market_name, name, company, category, price, action);
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		
		/*return to the web*/
		request.getRequestDispatcher("/MarketsProducts.jsp").forward(request, response);
	}
}
