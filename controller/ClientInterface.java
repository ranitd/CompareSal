package controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import DB.JdbcClient;
import DB.JdbcCommon;
import models.Client;
import models.Product;


public class ClientInterface {

	/*********************************************************************************************
	 Function Name: updateCurrentCart
	 Input: String client_email, String product_name, String product_company, int product_quantity,
			String action
	 Output: none 
	 Description: update product status in dynamic table of current cart user according to action
	 ********************************************************************************************/
	public static void updateCurrentCart(String client_email, String product_name, String product_company, int product_quantity,
			String action) throws IllegalAccessException, ClassNotFoundException, SQLException {
		JdbcCommon.openConnection(); //connect to db
		Client client = new Client(client_email);
		Product product = new Product(product_name, product_company, product_quantity);
		ResultSet result = JdbcClient.getProduct(client, product);
		/*product exist*/
		if(result.next()) {
			if (action.equals("remove"))
				JdbcClient.deleteProduct(client, product);
			else if(action.equals("add"))
				JdbcClient.updateProduct(client, product);
		}
		/*product does not exist*/
		else {
			if(action.equals("add"))
				JdbcClient.insertProduct(client, product);
		}
		/*close at end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
	}

	/*********************************************************************************************
	 Function Name: createCurrentCart
	 Input: String client_email
	 Output: none 
	 Description: create new table for current cart for the user and add the products
	 ********************************************************************************************/
	public static void createCurrentCart(String client_email) throws SQLException, IllegalAccessException, ClassNotFoundException {
		Client client = new Client(client_email);
		String email = client.getUser_email();
		email = email.replace("@", "");
		email = email.replace(".", "");
		String table_name = null;
		JdbcCommon.openConnection();
		/*check if table already exist*/
		ResultSet result = JdbcClient.isExist();		
		while (result.next()) {
			table_name = result.getString("TABLE_NAME");
			if(table_name.equals("CS_"+email+"_CURRENTCART") || table_name.equals("cs_"+email+"_currentcart"))
				return;
		}
		/*create new table*/
		JdbcClient.createCurrentCart(client);

		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: getCurrentCart
	 Input: String client_email
	 Output: Vector<Product>
	 Description: return vector of products in the current cart of the user
	 ********************************************************************************************/
	public static Vector<Product> getCurrentCart(String client_email) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Client client = new Client(client_email);
		Vector<Product> products = new Vector<Product>();
		JdbcCommon.openConnection();
		ResultSet result = JdbcClient.getCurrentCart(client);
		while(result.next()) {
			Product product = new Product();
			product.setProduct_name(result.getString("PRODUCT_NAME"));
			product.setProduct_company(result.getString("PRODUCT_COMPANY"));
			product.setProduct_quantity(result.getInt("PRODUCT_QUANTITY"));
			products.addElement(product);
		}
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return products;
	}
	
	/*********************************************************************************************
	 Function Name: getProduct
	 Input: String client_email, String product_name, String product_company
	 Output: Product
	 Description: return a product from the current cart
	 ********************************************************************************************/
	public static Product getProduct(String client_email, String product_name, String product_company) throws SQLException, IllegalAccessException, ClassNotFoundException {
		Client client = new Client(client_email);
		Product product = new Product(product_name, product_company);
		JdbcCommon.openConnection();
		ResultSet result = JdbcClient.getProduct(client, product);
		if(result.next())
			product.setProduct_quantity(result.getInt("PRODUCT_QUANTITY"));
		else
			product = null;
			
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		
		return product;
	}

	/*********************************************************************************************
	 Function Name: deleteCurrentCart
	 Input: String client_email
	 Output: none
	 Description: delete the current cart of the user
	 ********************************************************************************************/
	public static void deleteCurrentCart(String client_email) throws SQLException, IllegalAccessException, ClassNotFoundException {
		Client client = new Client(client_email);
		JdbcCommon.openConnection();
		JdbcClient.deleteCurrentCart(client);
		JdbcCommon.closeConnection();

	}
}

