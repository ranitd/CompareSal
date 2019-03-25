package controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import DB.JdbcCommon;
import DB.JdbcSupermarket;
import DB.JdbcUser;
import models.Product;
import models.Supermarket;

public class SupermarketInterface {

	/*********************************************************************************************
	 Function Name: getMarket
	 Input: String market_name
	 Output: Supermarket 
	 Description: return supermarket
	 ********************************************************************************************/
	public static Supermarket getMarket(String market_name) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name);
		JdbcCommon.openConnection();
		ResultSet result = JdbcSupermarket.getMarket(market);
		if(result.next()) {
			market.setImage_link(result.getString("MARKET_IMAGE"));
			market.setQuality(result.getInt("MARKET_QUALITY"));
			market.setWebsite(result.getString("MARKET_WEB"));
			market.setReviewers_no(result.getInt("MARKET_REVNO"));
		}
		else
			market = null;
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return market;
	}
	
	/*********************************************************************************************
	 Function Name: insertSuper
	 Input: String market_name, String market_web, String market_image
	 Output: none
	 Description: insert new market to web
	 ********************************************************************************************/
	public static void insertSuper(String market_name, String market_web, String market_image) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name, market_web, market_image);
		JdbcCommon.openConnection();
		/*create user for market*/
		JdbcUser.insertUser(market);
		/*create market*/
		JdbcSupermarket.insertMarket(market);
		/*create dynamic table for market*/
		NewTable(market.getSuper_name());
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: deleteMarket
	 Input: String market_name
	 Output: ResultSet result 
	 Description: delete current market from web
	 ********************************************************************************************/
	public static void deleteMarket(String market_name) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name);
		JdbcCommon.openConnection();
		/*delete market and dynamic table of the market*/
		JdbcSupermarket.deleteMarket(market);
		/*delete user*/
		JdbcUser.deleteUser(market);		
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: getAllMarkets
	 Input: none
	 Output: Vector<Supermarket> 
	 Description: return all markets in web
	 ********************************************************************************************/
	public static Vector<Supermarket> getAllMarkets() throws IllegalAccessException, ClassNotFoundException, SQLException {
		Vector<Supermarket> markets = new Vector<Supermarket>();
		JdbcCommon.openConnection();
		ResultSet result = JdbcSupermarket.SelectAllMarkets();	
		while(result.next()) {	
			Supermarket new_market = new Supermarket();
			new_market.setSuper_name(result.getString("MARKET_NAME"));
			new_market.setQuality(result.getInt("MARKET_QUALITY"));
			new_market.setWebsite(result.getString("MARKET_WEB"));	
			new_market.setImage_link(result.getString("MARKET_IMAGE"));	
			new_market.setReviewers_no(Integer.valueOf(result.getString("MARKET_REVNO")));
			markets.addElement(new_market);
		}
		
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return markets;
	}
	
	/*********************************************************************************************
	 Function Name: getAllProducts
	 Input: String market_name
	 Output: Vector<Product>
	 Description: return all products in supermarket
	 ********************************************************************************************/
	public static Vector<Product> getAllProducts(String market_name) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name);
		Vector<Product> products = new Vector<Product>();
		JdbcCommon.openConnection();
		ResultSet result = JdbcSupermarket.SelectAllProducts(market);	
		while(result.next()) {	
			Product new_product = new Product();
			new_product.setProduct_name(result.getString("PRODUCT_NAME"));
			new_product.setProduct_company(result.getString("PRODUCT_COMPANY"));
			new_product.setProduct_category(result.getString("PRODUCT_CATEGORY"));
			new_product.setProduct_exist(result.getBoolean("PRODUCT_EXIST"));
			new_product.setProduct_price(result.getDouble("PRODUCT_PRICE"));
			products.addElement(new_product);
		}	
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return products;
	}
	
	/*********************************************************************************************
	 Function Name: NewTable
	 Input: String market_name
	 Output: none 
	 Description: create new table for market
	 ********************************************************************************************/
	public static void NewTable(String market_name) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name);
		JdbcCommon.openConnection();
		JdbcSupermarket.CreateTable(market);
		Vector<Product> products = ProductInterface.getAllProducts();
		JdbcCommon.openConnection();
		JdbcSupermarket.InsertTable(market, products);
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: UpdateProduct
	 Input: String market_name, String product_name, String product_company, String product_category, double product_price, String action
	 Output: none 
	 Description: update product status in dynamic table of market according to action
	 ********************************************************************************************/
	public static void updateProduct(String market_name, String product_name, String product_company, String product_category, double product_price, String action) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Supermarket market = new Supermarket(market_name);
		Product product = new Product(product_name, product_company, product_category, product_price);
		JdbcCommon.openConnection();
		JdbcSupermarket.updateProduct(market, product, action);
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: getProduct
	 Input: String market_name, String product_name, String product_company
	 Output: Product
	 Description: return product exist in market
	 ********************************************************************************************/
	public static Product getProduct(String market_name, String product_name, String product_company) throws SQLException, IllegalAccessException, ClassNotFoundException {
		Supermarket market = new Supermarket(market_name);
		Product product = new Product(product_name, product_company);
		JdbcCommon.openConnection();
		ResultSet result = JdbcSupermarket.getProduct(market, product);
		result.next();
		product.setProduct_price(result.getInt("PRODUCT_PRICE"));
		product.setProduct_exist(result.getBoolean("PRODUCT_EXIST"));
			
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		
		return product;
	}
	
	/*********************************************************************************************
	 Function Name: rateMarket
	 Input: String market_name, int rating_value
	 Output: Product
	 Description: update quality of the current market and number of reviews
	 ********************************************************************************************/
	public static void rateMarket(String market_name, int rating_value) throws SQLException, IllegalAccessException, ClassNotFoundException {
		JdbcCommon.openConnection();
		Supermarket market = new Supermarket(market_name);
		ResultSet result = JdbcSupermarket.getMarket(market);
		double new_quality;
		double ratio;
		if(result.next()) {
			market.setQuality(result.getDouble("MARKET_QUALITY"));
			market.setReviewers_no(result.getInt("MARKET_REVNO"));
			int rating_no = market.getReviewers_no() + 1;
			if(rating_no == 1)
				new_quality = rating_value;
			else {
				ratio = ((double)(rating_no - 1))/rating_no;
				double old_review = (ratio*market.getQuality());
				ratio = ((double)1)/rating_no;
				double current_review = (ratio*rating_value);
				new_quality = (old_review + current_review);
			}
			JdbcSupermarket.rateMarket(market, rating_no, new_quality);			
		}
		/*close at end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
	}
}
