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
	    // if the bean does not exist...
	    if (userBean == null)
	    {
	    	// search for user that matches login info in database
			try {
				Connection con = DBLink.getConnection();
				PreparedStatement ps = con
						.prepareStatement("select id from user where email=? and password=?");
				ps.setString(1, (String)request.getAttribute("email"));
				ps.setString(2, (String)request.getAttribute("password"));

				ResultSet rs = ps.executeQuery();

				// if a user is found, set the user bean to that user
				if (rs.next()) {
					userBean = UserDao.getUserById(rs.getInt(1));
				}

				con.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
	        
	    }
	    // update the session with the new user bean
	    session.setAttribute("userBean", userBean);
	}
	
}
