package views;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import controller.ProductInterface;
import models.Product;

@WebServlet("/AddProduct.java")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/InvalidEnter.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		 response.setContentType("text/html;charset=UTF-8");
		 int inSystem = 0;
		 String product_name = request.getParameter("p_name").toString();
		 String product_company = request.getParameter("p_company").toString();
		 String product_category = request.getParameter("p_category").toString();
		 String product_image = request.getParameter("p_link").toString();
		 System.out.println("--> product name: " + product_name);
		 try {
			 Product product = ProductInterface.getProduct(product_name, product_company);
			if(product !=null) {
				inSystem = 1;
				request.getRequestDispatcher("/ExistProduct.jsp").forward(request, response);
			 }
		} catch (IllegalAccessException | ClassNotFoundException | SQLException e) {e.printStackTrace();}
		 
		 if(inSystem == 0) {
			 try {
				ProductInterface.insertProduct(product_name, product_company, product_category, product_image);
				System.out.println("--> new product had been inserted, product name: " + product_name);
				request.getRequestDispatcher("/ProductAdded.jsp").forward(request, response);
			} catch (IllegalAccessException |ClassNotFoundException | SQLException e) {e.printStackTrace();}
		 }		 
	}
}
