package models;

public class Supermarket extends User {

	private String super_name;
	private String website;
	private String image_link;
	private double quality;
	private double cart_price;
	private double total_result;
	private boolean in_algorithm;
	private int reviewers_no;
	
	/*********************************getters and setters***************************/
	public String getSuper_name() {
		return super_name;
	}
	public void setSuper_name(String super_name) {
		String update_name = super_name;
		while(update_name.contains(" "))
			update_name = update_name.replace(" ", "");
		this.super_name = update_name;		
		this.setUser_email(update_name+"@gmail.com");
		this.setUser_password(update_name);
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public double getQuality() {
		return quality;
	}
	public void setQuality(double quality) {
		this.quality = quality;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String super_email) {
		this.user_email = super_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String super_password) {
		this.user_password = super_password;
	}
	public String getImage_link() {
		return image_link;
	}
	public void setImage_link(String image_link) {
		this.image_link = image_link;
	}
	public double getCart_price() {
		return cart_price;
	}
	public void setCart_price(double cart_price) {
		this.cart_price = cart_price;
	}
	public double getTotal_result() {
		return total_result;
	}
	public void setTotal_result(double total_result) {
		this.total_result = total_result;
	}
	public boolean isIn_algorithm() {
		return in_algorithm;
	}
	public void setIn_algorithm(boolean in_algorithm) {
		this.in_algorithm = in_algorithm;
	}
	public int getReviewers_no() {
		return reviewers_no;
	}
	public void setReviewers_no(int reviewers_no) {
		this.reviewers_no = reviewers_no;
	}
	/*******************************************************************************/	

	/*********************************constructors*********************************/
	public Supermarket(String super_name, String website, String image_link) {
		this.setSuper_name(super_name);
		this.setWebsite(website);
		this.setUser_type(1);
		this.setQuality(3);
		this.setImage_link(image_link);
	}
	public Supermarket() {
	}	
	public Supermarket(String super_name) {
		this.setSuper_name(super_name);
	}	
	public Supermarket(String user_email, String user_password) {
		this.setUser_email(user_email);
		this.setUser_password(user_password);	
		this.setUser_type(1);
	}
	/*******************************************************************************/	
}
	

