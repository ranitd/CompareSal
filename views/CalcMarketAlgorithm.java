package views;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import controller.ClientInterface;
import controller.SupermarketInterface;
import models.Product;
import models.Supermarket;

@WebServlet("/CalcMarketAlgorithm.java")
public class CalcMarketAlgorithm extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String client_email = session.getAttribute("client_email").toString();
		client_email = client_email.replace("@", "");
		client_email = client_email.replace(".", "");
		Vector<Product> products = null;
		String product_name, product_company, market_name, markets_inAlg=null;
		double product_price, market_price, alg_result, alpha = 0.8, min_result = 0;
		Product current_product;
		Supermarket profitable_market = null;
		int error = 0, i, product_quantity;
		try {
			products = ClientInterface.getCurrentCart(client_email);
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		
		/*no product in cart*/
		if(products.size() == 0) {
			error = 1;
			request.getRequestDispatcher("/EmptyCartMessage.jsp").forward(request, response);
		}
		
		Vector<Supermarket> markets = null;
		try {
			markets = SupermarketInterface.getAllMarkets();
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
	
		/*no markets in web*/
		if (markets.size() == 0) {
			error = 1;
			request.getRequestDispatcher("/NoMarketMessage.jsp").forward(request, response);
		}

		Supermarket current_market;
		/*going over all markets in web*/
		for(i=0; i<markets.size(); i++) {
			current_market = markets.elementAt(i);
			current_market.setCart_price(0);
			current_market.setIn_algorithm(true);
			market_name = current_market.getSuper_name();
			
			/*check according to all products in the current cart*/
			for(int j=0; j<products.size(); j++) {
				current_product = products.elementAt(j);
				product_name = current_product.getProduct_name();
				product_company = current_product.getProduct_company();
				product_quantity = current_product.getProduct_quantity();
				try {
					current_product = SupermarketInterface.getProduct(market_name, product_name, product_company);
					if(current_product.isProduct_exist() == false) {
						current_market.setIn_algorithm(false);
						break;
					}
				} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
				/*update price of cart in current market*/
				product_price = current_product.getProduct_price();
				market_price = current_market.getCart_price();
				market_price +=product_price*product_quantity;
				current_market.setCart_price(market_price);	
			}/*end of products vector*/		
		}/*end of markets vector*/
		
		for(i = 0; i<markets.size(); i++) {
			if(markets.elementAt(i).isIn_algorithm() == true) {
				/*calculate result according to quality of market and the price of the cart*/
				alg_result = alpha*markets.elementAt(i).getCart_price() + (1-alpha)*markets.elementAt(i).getQuality();
				markets.elementAt(i).setTotal_result(alg_result);
				/*first market*/
				if(markets_inAlg == null)
					markets_inAlg = markets.elementAt(i).getSuper_name();
				else
					markets_inAlg = markets_inAlg+", "+markets.elementAt(i).getSuper_name();
			}
		}
		
		/*state the most profitable market*/
		for(i=0;i<markets.size();i++)
			if((min_result > markets.elementAt(i).getTotal_result() || min_result == 0) && markets.elementAt(i).isIn_algorithm() == true) {
				min_result = markets.elementAt(i).getTotal_result();
				profitable_market = markets.elementAt(i);				
			}
		if(profitable_market == null) {
			error = 1;
			request.getRequestDispatcher("/NoMarketForCart.jsp").forward(request, response);
		}
		
		if(error == 0) {
		/*save data for the next page*/
		session.setAttribute("profitableMarket", profitable_market.getSuper_name());
		session.setAttribute("price", profitable_market.getCart_price());
		session.setAttribute("client_email", client_email);
		session.setAttribute("markets_inAlg", markets_inAlg);
		request.getRequestDispatcher("/ClientResultPage.jsp").forward(request, response);
		}
						
	}
	

}
