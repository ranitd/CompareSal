package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import controller.ClientInterface;
import models.Product;


@WebServlet("/UpdateClientCurrentCart.java")
public class UpdateClientCurrentCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action;
		int quantity = Integer.valueOf(request.getParameter("product_quantity"));
		String product_name = request.getParameter("product_name").toString();
		String product_company = request.getParameter("product_company").toString();
		HttpSession session = request.getSession();
		String client_email = session.getAttribute("client_email").toString();
		/*define the action*/
		if(quantity == 0) {
			action = "remove";
			Product remove_product;
			try {
				remove_product = ClientInterface.getProduct(client_email, product_name, product_company);
				if(remove_product == null)
					/*return to the web*/
					request.getRequestDispatcher("/NewShoppingCart.jsp").forward(request, response);
			} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();} 

		}
		else
			action="add";
			
		try {
			ClientInterface.updateCurrentCart(client_email, product_name, product_company,quantity, action);
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();} 
		
		/*return to the web*/
		request.getRequestDispatcher("/NewShoppingCart.jsp").forward(request, response);
	}

}
