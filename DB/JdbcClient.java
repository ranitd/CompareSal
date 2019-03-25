package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.Client;
import models.Product;

public class JdbcClient {	

	/*********************************************************************************************
	Function Name: isExist
	Input: none
	Output: ResultSet
	Description: checks if the client current cart already exist
	********************************************************************************************/
	public static ResultSet isExist() throws SQLException {
		PreparedStatement statement = null;
		ResultSet result = null;
		try {
				String query = "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=?";
				statement = JdbcCommon.connection.prepareStatement(query);
				statement.setString(1, "comparesall");
				result = statement.executeQuery();
				return result;				
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}

	/*********************************************************************************************
	Function Name: createCurrentCart
	Input: Client client
	Output: none 
	Description: create new table of products to the current cart
	********************************************************************************************/
	public static void createCurrentCart(Client client) throws SQLException {
		PreparedStatement statement = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		try {
			String query = "CREATE TABLE CS_"+client_email+"_CURRENTCART"+"("
					+ "PRODUCT_NAME VARCHAR(30) NOT NULL,"
					+ "PRODUCT_COMPANY VARCHAR(30) NOT NULL,"
					+ "PRODUCT_QUANTITY INT DEFAULT 0"
					+ ");";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}	

	/*********************************************************************************************
	Function Name: insertProduct
	Input: Client client, Vector<Product> products
	Output: none 
	Description: insert product to ~new~ table
	********************************************************************************************/
	public static void insertProduct(Client client, Product product) throws SQLException {
		PreparedStatement statement = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();
		int product_quantity = product.getProduct_quantity();
		try {
			String query = "INSERT INTO CS_"+client_email+"_CURRENTCART"+" (PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_QUANTITY) VALUES (?, ?, ?)";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			statement.setInt(3, product_quantity);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();		
	}

	/*********************************************************************************************
	Function Name: deleteProduct
	Input: Client client, Product product
	Output: none
	Description: delete product from client table
	********************************************************************************************/
	public static void deleteProduct(Client client, Product product) throws SQLException {
		PreparedStatement statement = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();
		try {
			String query = "DELETE FROM CS_"+client_email+"_CURRENTCART"+" WHERE PRODUCT_NAME=? and PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();		
	}	
	
	/*********************************************************************************************
	Function Name: getCurrentCart
	Input: Client client
	Output: ResultSet
	Description: return current cart table of the client
	********************************************************************************************/
	public static ResultSet getCurrentCart(Client client) {
		PreparedStatement statement = null;
		ResultSet result = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		try {
			String query = "SELECT * FROM CS_"+client_email+"_CURRENTCART";
			statement = JdbcCommon.connection.prepareStatement(query);
			result = statement.executeQuery();
			return result;
		} catch (SQLException e) {e.printStackTrace();}		
		return result;		
	}
	
	/*********************************************************************************************
	Function Name: getProduct
	Input: Client  client, Product product
	Output: ResultSet
	Description: return a product from the current cart table of the client
	********************************************************************************************/
	public static ResultSet getProduct(Client  client, Product product) {
		PreparedStatement statement = null;
		ResultSet result = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();		
		try {
			String query = "SELECT * FROM CS_"+client_email+"_CURRENTCART WHERE PRODUCT_NAME=? AND PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			result = statement.executeQuery();
			return result;
		} catch (SQLException e) {e.printStackTrace();}
		return result;
	}
	
	/*********************************************************************************************
	Function Name: updateProduct
	Input: Client client, Vector<Product> products
	Output: none 
	Description: update quantity of exist product
	********************************************************************************************/
	public static void updateProduct(Client client, Product product) throws SQLException {
		PreparedStatement statement = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();
		int product_quantity = product.getProduct_quantity();
		try {
			String query = "UPDATE CS_"+client_email+"_CURRENTCART"+" SET PRODUCT_QUANTITY=? WHERE PRODUCT_NAME=? AND PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setInt(1, product_quantity);
			statement.setString(2,product_name);
			statement.setString(3,product_company);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();		
	}

	/*********************************************************************************************
	Function Name: deleteCurrentCart
	Input: Client client
	Output: none
	Description: delete current cart table of the client
	********************************************************************************************/
	public static void deleteCurrentCart(Client client) throws SQLException {
		PreparedStatement statement = null;
		String client_email = client.getUser_email();
		client_email=client_email.replace("@", "");
		client_email=client_email.replace(".", "");
		try {
			/*delete dynamic table of the market*/
			String query = "DROP TABLE CS_"+client_email+"_CURRENTCART";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();			
	}
}
