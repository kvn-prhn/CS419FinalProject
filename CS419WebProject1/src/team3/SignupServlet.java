package team3;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Date;

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
			PreparedStatement ps = con.prepareStatement("select * from accountteam3 where email=?");
			ps.setString(1, (String) request.getParameter("email"));

			ResultSet rs = ps.executeQuery();

			// if a user is found, set the user bean to that user
			if (rs.next()) {
				// ERROR: There is already an account with this email address
				System.err.println("An account with this email already exists");
				request.getRequestDispatcher("sign_up.jsp").forward(request, response);
				con.close();
				return;
			} else { // Create new account
				if (request.getParameter("firstName") == null ||
						request.getParameter("lastName") == null ||
						request.getParameter("password") == null ||
						request.getParameter("email") == null ||
						request.getParameter("streetAddress") == null ||
						request.getParameter("state") == null ||
						request.getParameter("city") == null ||
						request.getParameter("zipcode") == null ||
						request.getParameter("subscriptionTier") == null) {
					// return to the sign up page if  everything is not in there yet.
					request.getRequestDispatcher("sign_up.jsp").forward(request, response);
					con.close();
					return;
				}
				
				Account a = new Account();
				a.setFirstName((String)request.getParameter("firstName"));
				a.setLastName((String)request.getParameter("lastName"));
				a.setPassword((String)request.getParameter("password"));
				a.setEmail((String)request.getParameter("email"));
				a.setAddress((String)request.getParameter("streetAddress"), (String)request.getParameter("city"),
							(String)request.getParameter("state"), (String)request.getParameter("zipcode"));
				a.setSubscriptionTier(Integer.parseInt(request.getParameter("subscriptionTier")));
				
				// TODO: Centralize all of this information somewhere.
				switch(a.getSubscriptionTier()) {
					case 1: a.setHoursRemaining(10); break; // bronze
					case 2: a.setHoursRemaining(30); break; // silver
					case 3: a.setHoursRemaining(50); break; // gold
					case 4: a.setHoursRemaining(100); break; // plat
				}
				
				// TODO: Set the first date.
				
				AccountDao.create(a);
				
				ps = DBLink.getConnection().prepareStatement("select id, firstName from accountteam3 where email=?");
				ps.setString(1, request.getParameter("email"));
				rs = ps.executeQuery();
				
				if (rs.next()) { // Create a new default user for account
					User u = new User();
					u.setAccountId(rs.getInt(1));
					u.setUsername(rs.getString(2)); // username is by default first name
					u.setLoggedIn(false);
					
					UserDao.create(u);
				}
				
				//request.getRequestDispatcher("sign_up.jsp").forward(request, response);
				response.sendRedirect("login.jsp");  // send to the login page after making an account.
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			response.getWriter().println("THERE WAS AN ERROR");
		}

	}

}
