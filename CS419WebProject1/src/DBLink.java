import java.sql.Connection;
import java.sql.DriverManager;

public class DBLink {
	public static Connection getConnection() {  
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/sakila?useSSL=false", "root", "sesame");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
}
