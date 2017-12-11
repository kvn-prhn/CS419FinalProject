package team3;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet to handle the forms submission of changing data on the home page.
 * @author Kevin Prehn
 *
 */
@WebServlet("/UpdateAccount")
public class UpdateAccountServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5480141322530081219L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		if (session != null) {
			User userBean = (User) session.getAttribute("userBean");
			if (userBean != null) {
				Account acc = AccountDao.getAccountById(userBean.getAccountId());
				// change the accounts and then update it.
				String updateSubmitStr = req.getParameter("update_submit");
				if (updateSubmitStr.equalsIgnoreCase("Update Password")) {	// Update Password
					acc.setPassword(req.getParameter("update_password")); 
				} else if (updateSubmitStr.equalsIgnoreCase("Update Address")) {	// Update street Address
					acc.setAddress(req.getParameter("update_street"), req.getParameter("update_city"),
							req.getParameter("update_state"), req.getParameter("update_zipcode"));
				} else if (updateSubmitStr.equalsIgnoreCase("Update Subscription")) {	// Update subscription
					acc.setSubscriptionTier(Integer.parseInt(req.getParameter("update_sub_tier")));
				} else {
					System.err.println("Invalid name for a submit button for updating the account");
				}
				
				// make the changes
				AccountDao.update(acc);
			}
		}
	}
}
