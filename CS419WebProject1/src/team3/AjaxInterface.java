package team3;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			String userIdStr = req.getParameter("userId");
			if (userIdStr == null) {	// check that there is an account id
				pw.write("{\"success\":false,\"msg\":\"No userId parameter\"}");
			} else {
				User user = UserDao.getUserById(Integer.parseInt(userIdStr));
				if (user == null) {	// check that there is an account matching that
					pw.write("{\"success\":false,\"msg\":\"Invalid user userId\"}");
				} else {
					// if everything has not failed, then we can actually update the 
					// user at this point.
					
					// make sure that movie ID that was given is valid
					String movieIdStr = req.getParameter("movieId");
					if (movieIdStr == null) {
						pw.write("{\"success\":false,\"msg\":\"No movieId parameter\"}");
					} else {
						int movieId = Integer.parseInt(movieIdStr);
						// TODO: make sure the movieId given is valid?
						
						if (actionToDo.equals("add_favorite")) {	// add a movie to the favorites list
							// TODO:
							// user.addToFavorites(movieId);
							pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
							
						} else if (actionToDo.equals("remove_favorite")) {	// remove a movie from the favorites list
							// TODO:
							//user.removeFromFavorites(movieId);
							pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
							
						} else if (actionToDo.equals("add_queue")) {	// add a movie to the queue
							// TODO: 
							pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
							
						} else if (actionToDo.equals("remove_queue")) {	// remove a movie from the queue
							// TODO:
							pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
							
						} else {
							pw.write("{\"success\":false,\"msg\":\"Invalid action\"}");
						}
					}
				}
			}
		}
	}
}
