package team3;
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

@WebServlet("/Login")  
public class LoginServlet extends HttpServlet {

	/**
	 * The serial version.
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// get the current session
	    HttpSession session = request.getSession(true);
	    // try to get the bean from the session
	    User userBean = (User)session.getAttribute("userBean");

	    // if the bean is not logged in.
	    if (userBean != null && !userBean.isLoggedIn()) 
	    { 
	    	// search for user that matches login info in database
			try {
				Connection con = DBLink.getConnection();
				PreparedStatement ps = con.prepareStatement("select id from accountteam3 where email=? and password=?");
				ps.setString(1, (String)request.getParameter("email"));
				ps.setString(2, (String)request.getParameter("password"));
				
				ResultSet rs = ps.executeQuery();
				// if a user is found, set the user bean to that user
				if (rs.next()) {
					userBean = (User) UserDao.getUsersForAccount(rs.getInt(1)).get(0);	// get default user for account
					// TEMP: fake log in
					//int indexOfId = rs.findColumn("id");
					//userBean.setAccountId(rs.getInt(indexOfId));
					userBean.setLoggedIn(true);   // let them know the user is logged in
					response.sendRedirect("browse.jsp");  // browse after successful login.
				} else {
					response.getWriter().println("No user found.");
				}
				session.setAttribute("notification_message", "Logged in Successfully");		// display a notification

				con.close();
			} catch (Exception ex) {
				ex.printStackTrace();
				response.getWriter().println("Error logging in: " + ex);
				session.setAttribute("error_message", "Log in Failed. Please Try Again.");		// display a notification
			}
	        
	    } else {
	    	// if you're not logged in already, go to home page.
	    	response.sendRedirect("index.jsp");
	    }
	    // update the session with the new user bean
	    session.setAttribute("userBean", userBean);
	}
	
}
