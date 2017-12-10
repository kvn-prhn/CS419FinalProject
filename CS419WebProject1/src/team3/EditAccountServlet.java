package team3;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditAccount")
public class EditAccountServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// get the current session
	    HttpSession session = request.getSession(false);
	    User userBean = (User)session.getAttribute("userBean");
		
		Account a = AccountDao.getAccountById(userBean.getAccountId());	// Grab all info from user bean
		a.setId(userBean.getAccountId());
		//a.setFirstName(request.getParameter("firstName"));
		//a.setLastName(request.getParameter("lastName"));
		//a.setEmail(request.getParameter("email"));
		a.setPassword(request.getParameter("password"));
		a.setAddress(request.getParameter("streetAddress") + " " + request.getParameter("city") + " " + request.getParameter("state") + " " + request.getParameter("zipCode"));
		a.setSubscriptionTier(Integer.parseInt(request.getParameter("subscriptionTier")));
		
		AccountDao.update(a);
		
		response.sendRedirect("account_settings.jsp");
		
	}
	
}
