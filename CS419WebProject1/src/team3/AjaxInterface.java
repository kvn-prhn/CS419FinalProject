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
			String userIdStr = req.getParameter("userID");
			if (userIdStr == null) {	// check that there is an account id
				pw.write("{\"success\":false,\"msg\":\"No userID parameter\"}");
			} else {
				HttpSession session = req.getSession(true);
				User user = (User)session.getAttribute("userBean");
				System.out.print("User: ");
				System.out.println(user);
				if (user == null) {	// check that there is an account matching that
					pw.write("{\"success\":false,\"msg\":\"Invalid user userID\"}");
				} else {

					if (actionToDo.equals("get_hours_left")) {		// get how much time is left for a user.
						Account acc = AccountDao.getAccountById(user.getAccountId());
						if (acc != null) {
							pw.write("{\"success\":true,\"hours_left\":\"" + acc.getHoursRemaining() + "\"}");
						} else {
							pw.write("{\"success\":false}");
						}
					} else if (actionToDo.equals("subtract_hours_left")) {		// get how much time is left for a user.
						Account acc = AccountDao.getAccountById(user.getAccountId());
						if (acc != null) {
							String hoursChangingStr = req.getParameter("hours");
							if (hoursChangingStr == null) {
								pw.write("{\"success\":false,\"msg\":\"No hours parameter\"}");
							} else {
								double hoursToChange = Double.parseDouble(hoursChangingStr);
								System.out.println("reducing the hours left by " + hoursToChange);
								
								pw.write("{\"success\":true,\"hours_left\":\"" + acc.getHoursRemaining() + "\"}");
							}
						} else {
							pw.write("{\"success\":false}");
						}
					} else {
						

						// begin actions that use a movieId
						// make sure that movie ID that was given is valid
						String movieIdStr = req.getParameter("movieID");
						if (movieIdStr == null) {
							pw.write("{\"success\":false,\"msg\":\"No movieID parameter\"}");
						} else {
							int movieId = Integer.parseInt(movieIdStr);
							// TODO: make sure the movieId given is valid?
							
							if (actionToDo.equals("add_favorite")) {	// add a movie to the favorites list
								System.out.println("add_favorite");
								int status = user.addToFavorites(movieId); 
								//pw.write("{\"success\":" +  (status == 0)  + "}");   // give the status.
								pw.write("{\"success\":true}");   // give the status.
							} else if (actionToDo.equals("remove_favorite")) {	// remove a movie from the favorites list
								System.out.println("remove_favorite");
								int status = user.removeFromFavorites(movieId);
								pw.write("{\"success\":" +  (status == 0)  + "}");   // give the status.
							} else if (actionToDo.equals("add_queue")) {	// add a movie to the queue
								int status = user.addToQueue(movieId); 
								int newPosition = user.getQueue().indexOf(new Integer(movieId));
								user.forceQueueUpdate();    // force the bean to update the queue
								if (status == 0) {
									pw.write("{\"success\":true,\"new_pos\":" + newPosition + "}");   // give the status.
								} else {
									pw.write("{\"success\":false}"); 	// unsuccessfull add to queue.
								}
								session.setAttribute("notification_message", "Updated the queue:");
							} else if (actionToDo.equals("remove_queue")) {	// remove a movie from the queue
								System.out.println("remove_queue");
								int status = user.removeFromQueue(movieId);
								pw.write("{\"success\":" +  (status == 0)  + "}");   // give the status.
								user.forceQueueUpdate();   // force the bean to update the queue
								System.out.println(user.getQueue());
								
								session.setAttribute("notification_message", "Updated the queue:");
							} else if (actionToDo.equals("leave_rating")) {		// TODO: Make it so you can leave a rating
								String ratingStr = req.getParameter("rating");
								if (ratingStr == null) {
									pw.write("{\"success\":false,\"msg\":\"No rating parameter\"}");
								} else {
									int ratingToLeave = Integer.parseInt(ratingStr);
									// TODO: Add the rating to the movie list
									
									pw.write("{\"success\":false,\"msg\":\"Not yet implemented\"}");
								}
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
