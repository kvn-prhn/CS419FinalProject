import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Signup")
public class SignupServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// search for user that matches login info in database
		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from account where email=?");
			ps.setString(1, (String) request.getAttribute("email"));

			ResultSet rs = ps.executeQuery();

			// if a user is found, set the user bean to that user
			if (rs.next()) {
				// ERROR: There is already an account with this email address
			} else { // Create new account
				Account a = new Account();
				a.setFirstName((String)request.getAttribute("firstName"));
				a.setLastName((String)request.getAttribute("lastName"));
				a.setEmail((String)request.getAttribute("email"));
				a.setAddress((String)request.getAttribute("streetAddress") + " " + (String)request.getAttribute("city") + " " + (String)request.getAttribute("zipcode"));
				a.setSubscriptionTier((int)request.getAttribute("subscriptionTier"));
				
				AccountDao.create(a);
				
				rs = ps.executeQuery();
				
				if (rs.next()) { // Create a new default user for account
					User u = new User();
					u.setAccountId(rs.getInt(1));
					u.setUsername(rs.getString(2)); // username is by default first name
					u.setLoggedIn(false);
					
					UserDao.create(u);
				}
				
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

}
