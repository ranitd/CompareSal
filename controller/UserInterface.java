package controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import DB.JdbcUser;
import DB.JdbcCommon;
import models.Client;
import models.Supermarket;
import models.User;

public class UserInterface {
	
	/*********************************************************************************************
	 Function Name: getUser
	 Input: String user_email, String user_password
	 Output: void 
	 Description: check if the user exist in database - according to email and password
	 ********************************************************************************************/
	public static User getUser(String user_email, String user_password) throws IllegalAccessException, ClassNotFoundException, SQLException {
		User user = new User();
		user.setUser_email(user_email);
		user.setUser_password(user_password);
		JdbcCommon.openConnection();
		ResultSet result = JdbcUser.getUser(user);
		if(result.next()) {
			user.setUser_type(result.getInt("USER_TYPE"));
		}
		else
			user = null;
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return user;
	}
	
	/*********************************************************************************************
	 Function Name: insertUser
	 Input: String user_email, String user_password, int user_type
	 Output: void 
	 Description: add new user to database 
	 ********************************************************************************************/
	public static void insertUser(String user_email, String user_password, int user_type) throws IllegalAccessException, ClassNotFoundException, SQLException {
	
		JdbcCommon.openConnection();
		/*client*/
		if(user_type == 0) {
			Client client = new Client(user_email, user_password);
			JdbcUser.insertUser(client);
		}
		/*supermarket*/
		else if(user_type == 1) {
			Supermarket market = new Supermarket(user_email, user_password);
			JdbcUser.insertUser(market);
		}

		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: deleteUser
	 Input: String user_email
	 Output: void 
	 Description: delete user from database
	 ********************************************************************************************/
	public static void deleteUser(String user_email) throws IllegalAccessException, ClassNotFoundException, SQLException {
		User user = new User();
		user.setUser_email(user_email);
		JdbcCommon.openConnection();
		JdbcUser.deleteUser(user);
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: getAllUsers
	 Input: None
	 Output: Vector<User>
	 Description: return all users from database
	 ********************************************************************************************/
	public static Vector<User> getAllUsers() throws IllegalAccessException, ClassNotFoundException, SQLException {
		JdbcCommon.openConnection();
		Vector<User> users = new Vector<User>();
		ResultSet result = JdbcUser.getAllUsers();
		while(result.next()){
			User new_user = new User();
			new_user.setUser_email(result.getString("USER_EMAIL"));	
			new_user.setUser_password(result.getString("USER_PASSWORD"));
			new_user.setUser_type(Integer.valueOf(result.getString("USER_TYPE")));
			users.addElement(new_user);
		}
		/*close before end*/
		result.getStatement().close();
		result.close();
		JdbcCommon.closeConnection();
		return users;
	}
}
