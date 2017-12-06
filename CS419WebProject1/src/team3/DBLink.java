package team3;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBLink {
	/**
	 * Maintain one connection.
	 */
	private static Connection con = null;
	
	public static Connection getConnection() {  
		try {
			// only open the connection if it is null or closed to avoid creating multiple connections.
			if (con == null || con.isClosed()) { 
				Class.forName("com.mysql.jdbc.Driver");
				//con = DriverManager.getConnection("jdbc:mysql://localhost/sakila?useSSL=false", "root", "sesame");
				con = DriverManager.getConnection("jdbc:mysql://localhost/moviestoredb?useSSL=false", "root", "sesame");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return con;
	}
}
