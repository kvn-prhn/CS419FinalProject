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
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// get the current session
	    HttpSession session = request.getSession(true);
	    // try to get the bean from the session
	    User userBean = (User)session.getAttribute("userBean");

	    // if the bean is not logged in.
	    if (userBean == null || !userBean.isLoggedIn()) 
	    { 
	    	// search for user that matches login info in database
			try {
				if (userBean == null) {
		    		userBean = new User();
		    		session.setAttribute("userBean", userBean);
		    	}
				
				Connection con = DBLink.getConnection();
				PreparedStatement ps = con
						.prepareStatement("select id from user where email=? and password=?");
				ps.setString(1, (String)request.getAttribute("email"));
				ps.setString(2, (String)request.getAttribute("password"));

				ResultSet rs = ps.executeQuery();
				
				// if a user is found, set the user bean to that user
				if (rs.next()) {
					// TEMP: fake log in
					userBean.setAccountId(22);
					//userBean = UserDao.getUserById(rs.getInt(1));
					
					userBean.setLoggedIn(true);   // let them know the user is logged in
					response.sendRedirect("browse.jsp");  // browse after successful login.
				} else {
					response.getWriter().println("No user found.");
				}

				con.close();
			} catch (Exception ex) {
				ex.printStackTrace();
				response.getWriter().println("Error logging in: " + ex);
			}
	        
	    } else {
	    	// if you're not logged in already, go to home page.
	    	response.sendRedirect("index.jsp");
	    }
	    // update the session with the new user bean
	    session.setAttribute("userBean", userBean);
	}
	
}
