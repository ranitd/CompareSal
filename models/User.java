package models;

public class User {
	
	public String user_email;
	public String user_password;
	public int user_type;
	/*0=user 1=SuperAdmin 2=WebAdmin*/
	
	/*********************************getters and setters***************************/
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public int getUser_type() {
		return user_type;
	}
	public void setUser_type(int user_type) {
		this.user_type = user_type;
	}
	/*******************************************************************************/
}
