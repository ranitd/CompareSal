package DB;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class JdbcStart {
	public static java.sql.Connection connection = null;
	
	/*********************************************************************************************
	 Function Name: openConnection
	 Input: none
	 Output: void
	 Description: open connection to the other classes
	 ********************************************************************************************/
	public static void openConnection() throws IllegalAccessException, ClassNotFoundException, SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String dbUrl = "jdbc:mysql://localhost";
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

	/*********************************************************************************************
	 Function Name: CreateDB
	 Input: none
	 Output: none 
	 Description: create new database
	 ********************************************************************************************/
	public static void CreateDB() throws SQLException {
		PreparedStatement statement = null;
		try {
			String query = "CREATE DATABASE comparesall";
			statement = JdbcStart.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}
	
	/*********************************************************************************************
	 Function Name: InsertUserTable
	 Input: none
	 Output: none 
	 Description: insert new table - cs_users
	 ********************************************************************************************/
	public static void UserTable() throws SQLException {
		PreparedStatement statement = null;
		try {
			String query = "CREATE TABLE CS_USERS("
					+ "USER_TYPE INT DEFAULT 1,"
					+ "USER_EMAIL VARCHAR(30) NOT NULL,"
					+ "USER_PASSWORD VARCHAR(30) NOT NULL"
					+ ");";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}
	
	/*********************************************************************************************
	 Function Name: InsertMarketsTable
	 Input: none
	 Output: none 
	 Description: insert new table - cs_markets
	 ********************************************************************************************/
	public static void MarketsTable() throws SQLException {
		PreparedStatement statement = null;
		try {
			String query = "CREATE TABLE CS_MARKETS("
					+ "MARKET_NAME VARCHAR(30) NOT NULL,"
					+ "MARKET_WEB VARCHAR(30) NOT NULL,"
					+ "MARKET_IMAGE VARCHAR(300) NOT NULL,"
					+ "MARKET_QUALITY DOUBLE DEFAULT 1,"
					+ "MARKET_REVNO INT DEFAULT 0"
					+ ");";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}

	/*********************************************************************************************
	Function Name: InsertProductsTable
	Input: none
	Output: none 
	Description: insert new table - cs_products
	 ********************************************************************************************/
	public static void ProductsTable() throws SQLException {
		PreparedStatement statement = null;
		try {
			String query = "CREATE TABLE CS_PRODUCTS("
					+ "PRODUCT_NAME VARCHAR(100) NOT NULL,"
					+ "PRODUCT_COMPANY VARCHAR(100) NOT NULL,"
					+ "PRODUCT_CATEGORY VARCHAR(100) NOT NULL,"
					+ "PRODUCT_IMAGE VARCHAR(300) NOT NULL"
					+ ");";
			statement = JdbcCommon.connection.prepareStatement(query);
			statement.executeUpdate();
		} catch (SQLException e) {e.printStackTrace();}
		statement.close();
	}
}
