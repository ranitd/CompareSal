package models;

public class Product {
	
	private String product_name;
	private String product_company;
	private String product_category;
	private String product_image;
	private int product_quantity;
	private double product_price;
	private boolean product_exist;
	
	/*********************************getters and setters***************************/	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_company() {
		return product_company;
	}
	public void setProduct_company(String product_company) {
		this.product_company = product_company;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	public int getProduct_quantity() {
		return product_quantity;
	}
	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}	
	public double getProduct_price() {
		return product_price;
	}
	public void setProduct_price(double product_price) {
		this.product_price = product_price;
	}
	public boolean isProduct_exist() {
		return product_exist;
	}
	public void setProduct_exist(boolean product_exist) {
		this.product_exist = product_exist;
	}
	/*******************************************************************************/
	
	/*********************************constructors*********************************/
	public Product() {
		this.setProduct_category("");
		this.setProduct_company("");
		this.setProduct_image("");
		this.setProduct_name("");
		this.setProduct_quantity(0);
	}	
	public Product(String product_name, String product_company, String product_category, double product_price) {
		this.setProduct_category(product_category);
		this.setProduct_company(product_company);
		this.setProduct_name(product_name);
		this.setProduct_price(product_price);
	}
	public Product(String product_name, String product_company) {
		this.setProduct_company(product_company);
		this.setProduct_name(product_name);
	}	
	public Product(String product_name, String product_company, String product_category, String product_image) {
		this.setProduct_name(product_name);
		this.setProduct_company(product_company);
		this.setProduct_category(product_category);
		this.setProduct_image(product_image);
	}	
	public Product(String product_name, String product_company, int product_quantity) {
		this.setProduct_name(product_name);
		this.setProduct_company(product_company);
		this.setProduct_quantity(product_quantity);
	}
	/*******************************************************************************/
}
