package team3;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Logout")
public class LogoutServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get the current session
		HttpSession session = request.getSession(true);
		if (session != null) {
			// try to get the bean from the session
		    			
			User userBean = (User) session.getAttribute("userBean");
			System.out.println(userBean);
			
			// if the bean exists -- the user is logged in
			if (userBean != null) {
				// remove the bean from the session
				System.out.println("Logging out user with id: " + userBean.getAccountId());
				session.setAttribute("notification_message", "Logged out Successfully");		// display a notification
				userBean.setId(-1);
				userBean.setLoggedIn(false);
				//session.removeAttribute("userBean");
				
				// move back to the home page
				response.sendRedirect("index.jsp");
				
			} else {
				session.setAttribute("error_message", "Error logging out.");		// display an error 
				///response.getWriter().println("ERROR WITH LOGGING OUT");
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

}
