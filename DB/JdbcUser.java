package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;

public class JdbcUser {
	
	/*********************************************************************************************
	 Function Name: getUser
	 Input: User user
	 Output: ResultSet result 
	 Description: return user (or null if the user does not exist)
	 ********************************************************************************************/
	public static ResultSet getUser(User user) throws SQLException {
		PreparedStatement statement = null;
		ResultSet result = null;
		String user_email = user.getUser_email();
		String user_password = user.getUser_password();		
		try {
			String query = "SELECT * FROM CS_USERS where USER_EMAIL=? and USER_PASSWORD=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,user_email);
			statement.setString(2,user_password);	
			result = statement.executeQuery();
		} catch (SQLException e) {e.printStackTrace();}
		return result;
	}
	
	/*********************************************************************************************
	 Function Name: insertUser
	 Input: User user
	 Output: void
	 Description: add new user to database
	 ********************************************************************************************/
	public static void insertUser(User user) throws SQLException {
		PreparedStatement statement = null;
		try {			
			String email = user.getUser_email();
			String password = user.getUser_password();
			int type = user.getUser_type();
			String query = "INSERT INTO CS_USERS (USER_EMAIL, USER_PASSWORD, USER_TYPE) VALUES (?, ?, ?)";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,email);		
			statement.setString(2,password);
			statement.setInt(3,type);	
			statement.executeUpdate();			
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();		
	}
	
	/*********************************************************************************************
	 Function Name: deleteUser
	 Input: User user
	 Output: void 
	 Description: remove exist user from database 
	 ********************************************************************************************/
	public static void deleteUser(User user) throws SQLException {
		PreparedStatement statement = null;
		try {
			String email = user.getUser_email();
			String query = "DELETE FROM CS_USERS WHERE USER_EMAIL=?";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.setString(1,email);
			statement.executeUpdate();	
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();			
	}
	
	/*********************************************************************************************
	 Function Name: getAllUsers
	 Input: None
	 Output: void 
	 Description: return all users
	 ********************************************************************************************/
	public static ResultSet getAllUsers() throws SQLException {
		PreparedStatement statement = null;
		ResultSet result = null;
		try {
			String query = "SELECT * FROM CS_USERS";
			statement = JdbcCommon.connection.prepareStatement(query);
			result = statement.executeQuery();
			return result;
		} catch (SQLException e) {e.printStackTrace();}
		return result;
	}
}
