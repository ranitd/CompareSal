package models;

public class Client extends User {
	
	/*********************************constructors*********************************/	
	public Client(String user_email, String user_password) {
		this.setUser_email(user_email);
		this.setUser_password(user_password);	
		this.setUser_type(0);
	}
	public Client(String user_email) {
		this.setUser_email(user_email);
	}
	/*******************************************************************************/
}
