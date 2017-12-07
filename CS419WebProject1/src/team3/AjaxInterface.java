package team3;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AjaxInterface")
public class AjaxInterface extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1415235173629358217L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");  // set returning json
		PrintWriter pw = resp.getWriter();
		String actionToDo = req.getParameter("action");
		if (actionToDo == null) {
			pw.write("{\"success\":false,\"msg\":\"No action parameter\"}");
		} else {
			String accIdStr = req.getParameter("accountID");
			if (accIdStr == null) {	// check that there is an account id
				pw.write("{\"success\":false,\"msg\":\"No accountID parameter\"}");
			} else {
				Account account = AccountDao.getAccountById(Integer.parseInt(accIdStr));
				if (account == null) {	// check that there is an account matching that
					pw.write("{\"success\":false,\"msg\":\"Invalid user accountID\"}");
				} else {
					// TODO: Add actions for changing the account properties.
					if (actionToDo.equals("update_address")) {		// update some account's address...
						// TODO: Street address, city, state, ZIP code.
					} else {
						HttpSession session = req.getSession(true);
					    User user = (User)session.getAttribute("userBean");
						
						// begin actions that use a movieId
						// make sure that movie ID that was given is valid
						String movieIdStr = req.getParameter("movieID");
						if (movieIdStr == null) {
							pw.write("{\"success\":false,\"msg\":\"No movieID parameter\"}");
						} else {
							int movieId = Integer.parseInt(movieIdStr);
							// TODO: make sure the movieId given is valid?
							
							if (actionToDo.equals("add_favorite")) {	// add a movie to the favorites list
								// TODO:
								System.out.println("add_favorite");
								user.addToFavorites(movieId);
								
								pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
								
							} else if (actionToDo.equals("remove_favorite")) {	// remove a movie from the favorites list
								// TODO:
								System.out.println("remove_favorite");
								//user.removeFromFavorites(movieId);
								pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
								
							} else if (actionToDo.equals("add_queue")) {	// add a movie to the queue
								// TODO:
								System.out.println("add_queue");
								pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
								
							} else if (actionToDo.equals("remove_queue")) {	// remove a movie from the queue
								// TODO:
								System.out.println("remove_queue");
								pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
								
							} else {
								pw.write("{\"success\":false,\"msg\":\"Invalid action\"}");
							}
						} // End actions that use a movie ID
					}
				}
			}
		}
	}
}
