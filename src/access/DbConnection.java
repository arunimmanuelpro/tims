package access;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

	private static Connection conn;
	public static String [] monthname = {"Jan","Feb","March","April","May","June","July","August","Sept","Oct","Nov","Dec"};

	public static Connection getConnection() throws Exception {		
		
		String url = "jdbc:mysql://localhost:3306/tims";
		//String dbName = "tims";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "root";
		String password = "";



		Class.forName(driver).newInstance();

			conn = DriverManager.getConnection(url, userName, password);
		

		return conn;
	}

	public static void close() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
