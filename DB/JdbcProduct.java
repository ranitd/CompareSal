package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.Product;

public class JdbcProduct {

	/*********************************************************************************************
	 Function Name: getProduct
	 Input: Product product
	 Output: ResultSet
	 Description: return a product from products table
	 ********************************************************************************************/
	public static ResultSet getProduct(Product product) throws SQLException {
		PreparedStatement statement = null;
		ResultSet result = null;
		String name = product.getProduct_name();
		String company = product.getProduct_company();
		try {
			String query = "SELECT * FROM CS_PRODUCTS where PRODUCT_NAME=? and PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,name);	
			statement.setString(2,company);
			result = statement.executeQuery();			
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: insertProduct
	 Input: Product product
	 Output: none
	 Description: insert new product to products table
	 ********************************************************************************************/
	public static void insertProduct(Product product) throws SQLException {
		PreparedStatement statement = null;
		try {
			String name = product.getProduct_name();
			String company = product.getProduct_company();
			String image = product.getProduct_image();
			String category = product.getProduct_category();	
			String query = "INSERT INTO CS_PRODUCTS (PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_CATEGORY, PRODUCT_IMAGE) VALUES (?, ?, ?, ?)";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,name);		
			statement.setString(2,company);
			statement.setString(3,category);
			statement.setString(4,image);
			statement.executeUpdate();			
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();				
	}
	
	/*********************************************************************************************
	 Function Name: deleteProduct
	 Input: Product product
	 Output: none
	 Description: delete product from products table
	 ********************************************************************************************/
	public static void deleteProduct(Product product) throws SQLException {
		PreparedStatement statement = null;
		try {
			String name = product.getProduct_name();
			String company = product.getProduct_company();
			String query = "DELETE FROM CS_PRODUCTS WHERE PRODUCT_NAME=? and PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,name);
			statement.setString(2,company);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();			
	}
	
	/*********************************************************************************************
	 Function Name: SelectAll
	 Input: none
	 Output: ResultSet
	 Description: return all products from products table
	 ********************************************************************************************/
	public static ResultSet SelectAll() {
		PreparedStatement statement = null;
		ResultSet result = null;
		try {
			String query = "SELECT * FROM CS_PRODUCTS";
			statement = JdbcCommon.connection.prepareStatement(query);
			result = statement.executeQuery();			
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}
}
