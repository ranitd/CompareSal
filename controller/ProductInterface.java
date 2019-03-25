package controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import DB.JdbcCommon;
import DB.JdbcProduct;
import DB.JdbcSupermarket;
import models.Product;
import models.Supermarket;

public class ProductInterface {	
	
	/*********************************************************************************************
	 Function Name: getProduct
	 Input: String product_name, String product_company
	 Output: Product product
	 Description: return a product from database according to name and company
	 ********************************************************************************************/
	public static Product getProduct(String product_name, String product_company) throws IllegalAccessException, ClassNotFoundException, SQLException {
		JdbcCommon.openConnection();
		Product product = new Product(product_name, product_company);
		ResultSet result = JdbcProduct.getProduct(product);
		if(result.next()) {
			product.setProduct_image(result.getString("PRODUCT_IMAGE"));
			product.setProduct_company(result.getString("PRODUCT_COMPANY"));
			product.setProduct_category(result.getString("PRODUCT_CATEGORY"));
			product.setProduct_name(result.getString("PRODUCT_NAME"));
		}
		else
			product = null;
		
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return product;
	}
	
	/*********************************************************************************************
	 Function Name: insertProduct
	 Input: String product_name, String product_company, String product_image, String product_category
	 Output: none
	 Description: insert a product in database
	 ********************************************************************************************/
	public static void insertProduct(String product_name, String product_company, String product_category, String product_image) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Product product = new Product(product_name, product_company, product_category, product_image);
		Vector<Supermarket> markets = SupermarketInterface.getAllMarkets();
		JdbcCommon.openConnection();
		JdbcProduct.insertProduct(product);
		/*insert to all dynamic tables of markets*/
		for(int i=0; i<markets.size(); i++) {
			Supermarket market = markets.elementAt(i);
			JdbcSupermarket.insertProductToMarket(market, product);
		}
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: deleteProduct
	 Input: String product_name, String product_company
	 Output: none
	 Description: delete product from database
	 ********************************************************************************************/
	public static void deleteProduct(String product_name, String product_company) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Product product = new Product(product_name, product_company);
		Vector<Supermarket> markets = SupermarketInterface.getAllMarkets();
		JdbcCommon.openConnection();
		JdbcProduct.deleteProduct(product);
		/*delete from all dynamic tables of markets*/
		for(int i=0; i<markets.size(); i++) {
			Supermarket market = markets.elementAt(i);
			JdbcSupermarket.deleteProductFromMarket(market, product);
		}
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: getAllProducts
	 Input: none
	 Output: Vector<Product>
	 Description: return all products in database
	 ********************************************************************************************/
	public static Vector<Product> getAllProducts() throws IllegalAccessException, ClassNotFoundException, SQLException {
		Vector<Product> products = new Vector<Product>();
		JdbcCommon.openConnection();
		ResultSet result = JdbcProduct.SelectAll();	
		/*check if the user input exist in database*/
		while(result.next()) {	
			Product new_product = new Product();
			new_product.setProduct_image(result.getString("PRODUCT_IMAGE"));
			new_product.setProduct_company(result.getString("PRODUCT_COMPANY"));
			new_product.setProduct_category(result.getString("PRODUCT_CATEGORY"));
			new_product.setProduct_name(result.getString("PRODUCT_NAME"));
			products.addElement(new_product);
		}
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return products;
	}
}

