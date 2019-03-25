package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.ProductInterface;



@WebServlet("/RemoveProduct.java")
public class RemoveProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String product = request.getParameter("product");
		int index = product.indexOf("_");
		String company = product.substring(index+1,product.length());
		String name = product.substring(0, index);
		try {
			ProductInterface.deleteProduct(name, company);
			System.out.println("the product: " + name + " from company: " + company + " was deleted");
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		
		/*return to the web*/
		request.getRequestDispatcher("/ProductStorage.jsp").forward(request, response);
	}

}
