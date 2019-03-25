package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import models.Product;
import models.Supermarket;

public class JdbcSupermarket {
	
	/*********************************************************************************************
	 Function Name: getMarket
	 Input: nSupermarket market
	 Output: ResultSet
	 Description: return market from markets table
	 ********************************************************************************************/
	public static ResultSet getMarket(Supermarket market) throws SQLException {
		PreparedStatement statement = null;
		ResultSet result = null;
		String market_name = market.getSuper_name();
		try {
			String query = "SELECT * FROM CS_MARKETS where MARKET_NAME=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,market_name);		
			result = statement.executeQuery();
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: insertMarket
	 Input: nSupermarket market
	 Output: none
	 Description: insert new market to markets table
	 ********************************************************************************************/
	public static void insertMarket(Supermarket supermarket) throws SQLException {
		PreparedStatement statement = null;
		try {
			String name = supermarket.getSuper_name();
			String website = supermarket.getWebsite();
			String image = supermarket.getImage_link();
			double quality = supermarket.getQuality();
			String query = "INSERT INTO CS_MARKETS (MARKET_NAME, MARKET_WEB, MARKET_IMAGE, MARKET_QUALITY, MARKET_REVNO) VALUES (?, ?, ?, ?, ?)";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,name);		
			statement.setString(2,website);
			statement.setString(3,image);
			statement.setDouble(4,quality);
			statement.setInt(5, 0);
			statement.executeUpdate();			
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();	
			
	}
	
	/*********************************************************************************************
	 Function Name: deleteMarket
	 Input: Supermarket market
	 Output: none
	 Description: delete market from markets table
	 ********************************************************************************************/
	public static void deleteMarket(Supermarket supermarket) throws SQLException {
		PreparedStatement statement = null;
		try {
			/*delete row of the market*/
			String name = supermarket.getSuper_name();
			String query = "DELETE FROM CS_MARKETS WHERE MARKET_NAME=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,name);
			statement.executeUpdate();			
			/*delete dynamic table of the market*/
			query = "DROP TABLE CS_"+name;
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();			
	}

	/*********************************************************************************************
	 Function Name: SelectAllMarkets
	 Input: none
	 Output: ResultSet
	 Description: return all markets in table
	 ********************************************************************************************/
	public static ResultSet SelectAllMarkets() {
		PreparedStatement statement = null;
		ResultSet result = null;
		try {
			String query = "SELECT * FROM CS_MARKETS";
			statement = JdbcCommon.connection.prepareStatement(query);
			result = statement.executeQuery();
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: SelectAllProducts
	 Input: Supermarket supermarket
	 Output: ResultSet
	 Description: return all products in the current market
	 ********************************************************************************************/
	public static ResultSet SelectAllProducts(Supermarket supermarket) {
		PreparedStatement statement = null;
		ResultSet result = null;
		String market_name = supermarket.getSuper_name();
		try {
			String query = "SELECT * FROM CS_"+market_name;
			statement = JdbcCommon.connection.prepareStatement(query);
			result = statement.executeQuery();
		} catch (SQLException e) {e.printStackTrace();}		
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: CreateTable
	 Input: Supermarket supermarket
	 Output: none 
	 Description: create new table of products to the current table
	 ********************************************************************************************/
	public static void CreateTable(Supermarket supermarket) throws SQLException {
		PreparedStatement statement = null;
		String market_name = supermarket.getSuper_name();
		try {
			String query = "CREATE TABLE CS_"+market_name+"("
					+ "PRODUCT_NAME VARCHAR(30) NOT NULL,"
					+ "PRODUCT_COMPANY VARCHAR(30) NOT NULL,"
					+ "PRODUCT_EXIST BOOLEAN DEFAULT FALSE,"
					+ "PRODUCT_PRICE DOUBLE DEFAULT 0,"
					+ "PRODUCT_CATEGORY VARCHAR(30) NOT NULL"
					+ ");";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}

	/*********************************************************************************************
	 Function Name: InsertTable
	 Input: Supermarket supermarket, Vector<Product> products
	 Output: none 
	 Description: insert products to current market table
	 ********************************************************************************************/
	public static void InsertTable(Supermarket supermarket, Vector<Product> products) throws SQLException {
		PreparedStatement statement = null;
		String market_name = supermarket.getSuper_name();
		try {
			Product current_product = new Product();
			for(int i=0; i<products.size();i++) {
				current_product =  products.elementAt(i);
				String query = "INSERT INTO CS_"+market_name+" (PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_PRICE, PRODUCT_EXIST, PRODUCT_CATEGORY) VALUES (?, ?, ?, ?, ?)";
				statement = JdbcCommon.connection.prepareStatement(query);
				statement.setString(1,current_product.getProduct_name());		
				statement.setString(2,current_product.getProduct_company());
				statement.setInt(3,0);
				statement.setBoolean(4,false);
				statement.setString(5, current_product.getProduct_category());
				statement.executeUpdate();		
			}
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();		
	}

	/*********************************************************************************************
	 Function Name: updateProduct
	 Input: Supermarket supermarket, Product product, String action
	 Output: none 
	 Description: update product status in current market table
	 ********************************************************************************************/
	public static void updateProduct(Supermarket supermarket, Product product, String action) throws SQLException {
		PreparedStatement statement = null;
		String query;
		try {
			if(action.equals("add")) {
				query = "UPDATE CS_"+supermarket.getSuper_name()+" SET PRODUCT_EXIST=?, PRODUCT_PRICE=? WHERE PRODUCT_NAME=? and PRODUCT_COMPANY=?";
				statement = JdbcCommon.connection.prepareStatement(query);
				statement.setBoolean(1, true);
				statement.setDouble(2,product.getProduct_price());
				statement.setString(3, product.getProduct_name());
				statement.setString(4, product.getProduct_company());
				statement.executeUpdate();	
			}
			else {
				query = "UPDATE CS_"+supermarket.getSuper_name()+" SET PRODUCT_EXIST=?, PRODUCT_PRICE=? WHERE PRODUCT_NAME=? and PRODUCT_COMPANY=?";
				statement = JdbcCommon.connection.prepareStatement(query);
				statement.setBoolean(1, false);
				statement.setDouble(2,0);
				statement.setString(3, product.getProduct_name());
				statement.setString(4, product.getProduct_company());
				statement.executeUpdate();	
			}
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}
	
	/*********************************************************************************************
	 Function Name: deleteProductFromMarket
	 Input: Supermarket market, Product product
	 Output: none 
	 Description: delete product row from current market table
	 ********************************************************************************************/
	public static void deleteProductFromMarket(Supermarket market, Product product) throws SQLException {
		PreparedStatement statement = null;
		String market_name = market.getSuper_name();
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();
		try {
			String query = "DELETE FROM CS_"+market_name+" WHERE PRODUCT_NAME=? and PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();
	}
	
	/*********************************************************************************************
	 Function Name: insertProductToMarket
	 Input: Supermarket market, Product product
	 Output: none 
	 Description: insert new product row to current market table
	 ********************************************************************************************/
	public static void insertProductToMarket(Supermarket market, Product product) throws SQLException {
		PreparedStatement statement = null;
		String market_name = market.getSuper_name();
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();
		String product_category = product.getProduct_category();
		try {
			String query = "INSERT INTO CS_"+market_name+" (PRODUCT_NAME, PRODUCT_COMPANY, PRODUCT_PRICE, PRODUCT_EXIST, PRODUCT_CATEGORY) VALUES (?, ?, ?, ?, ?)";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			statement.setDouble(3,0);
			statement.setBoolean(4,false);
			statement.setString(5,product_category);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}		
		statement.close();
	}
	
	/*********************************************************************************************
	 Function Name: getProduct
	 Input: Supermarket market, Product product
	 Output: ResultSet
	 Description: return a product from the current market table
	 ********************************************************************************************/
	public static ResultSet getProduct(Supermarket market, Product product) {
		PreparedStatement statement = null;
		ResultSet result = null;
		String market_name = market.getSuper_name();
		String product_name = product.getProduct_name();
		String product_company = product.getProduct_company();		
		try {
			String query = "SELECT * FROM CS_"+market_name+" WHERE PRODUCT_NAME=? AND PRODUCT_COMPANY=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,product_name);
			statement.setString(2,product_company);
			result = statement.executeQuery();
			return result;
		} catch (SQLException e) {e.printStackTrace();}
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: rateMarket
	 Input: Supermarket supermarket, int rating_no, double new_quality
	 Output: none
	 Description: update the current market in the new rating
	 ********************************************************************************************/
	public static void rateMarket(Supermarket supermarket, int rating_no, double new_quality) throws SQLException {
		PreparedStatement statement = null;
		String query;
		try {
			query = "UPDATE CS_MARKETS" +" SET MARKET_REVNO=?, MARKET_QUALITY=? WHERE MARKET_NAME=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setInt(1, rating_no);
			statement.setDouble(2, new_quality);
			statement.setString(3, supermarket.getSuper_name());
			statement.executeUpdate();	
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}	
}
