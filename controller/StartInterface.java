package controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import DB.JdbcCommon;
import DB.JdbcStart;


public class StartInterface {
	
	/*********************************************************************************************
	 Function Name: firstUse
	 Input: none
	 Output: none
	 Description: create basis database
	 ********************************************************************************************/
	public static void firstUse() throws IllegalAccessException, ClassNotFoundException, SQLException {
		JdbcCommon.openConnection();
		JdbcStart.UserTable();
		JdbcStart.MarketsTable();
		JdbcStart.ProductsTable();
		UserInterface.insertUser("comparesall@gmail.com", "comparesall", 3);
		JdbcCommon.closeConnection();
	}
	
	/*********************************************************************************************
	 Function Name: checkFirstUse
	 Input: none
	 Output: none
	 Description: check if there is a basis database
	 ********************************************************************************************/
	public static void checkDatabase() throws IllegalAccessException, ClassNotFoundException, SQLException {
		JdbcStart.openConnection();
		String database_name = "comparesall";
		boolean isExist = false;
		ResultSet result = JdbcStart.connection.getMetaData().getCatalogs();
		while (result.next()) {
			String current_database = result.getString(1);
			if(database_name.equals(current_database))
				isExist = true;
		}

		if (isExist == false) {
			JdbcStart.CreateDB();
			System.out.println("--> New database established");
			JdbcStart.closeConnection();
			firstUse();

		}
		else
			System.out.println("--> The database already exist");
		JdbcStart.closeConnection();
		
	}
}
