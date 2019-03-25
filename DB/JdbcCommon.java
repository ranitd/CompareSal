package DB;

import java.sql.DriverManager;
import java.sql.SQLException;

public class JdbcCommon {
	static java.sql.Connection connection = null;
	
	/*********************************************************************************************
	 Function Name: openConnection
	 Input: none
	 Output: void
	 Description: open connection to the other classes
	 ********************************************************************************************/
	public static void openConnection() throws IllegalAccessException, ClassNotFoundException, SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String dbUrl = "jdbc:mysql://localhost/comparesall";
			connection = DriverManager.getConnection(dbUrl, "root", "");			
		} 
		catch (IllegalAccessException | ClassNotFoundException | SQLException | InstantiationException e){e.printStackTrace();}
	}
	
	/*********************************************************************************************
	 Function Name: closeConnection
	 Input: none
	 Output: void
	 Description: close connection to the other classes
	 ********************************************************************************************/
	public static void closeConnection() throws SQLException {
		connection.close();
	}
	
}

