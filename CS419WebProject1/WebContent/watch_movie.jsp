<%@page import="team3.MovieDao"%>
<%@page import="team3.Movie"%>
<%@page import="team3.Account" %>
<%@page import="team3.AccountDao" %>
<%@include file='WEB-INF/modules/beans_common.jspf'%>

<%-- Include the user bean for this page since we don't have the standard header in this page. --%>
<jsp:useBean id="userBean" scope="session" class="team3.User">
  </jsp:useBean>


<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Watch Movie</title>
</head>

<body>

<%
String movieIdStr = request.getParameter("movieID");
Movie movie = null;
if (movieIdStr != null) {
	int movieId = Integer.parseInt(movieIdStr);
	System.out.println(movieId);
	movie =  MovieDao.getMovieById(movieId);
}

boolean movieValid = (movieIdStr != null && movie != null);

%>


<div class="content-wrapper-watch-movie">
    <div class="top-bar-movie-watching l-box is-center">
    	<div class="pure-u-1-5">
	    	<% if (movieValid) {
		    	out.println("Now watching: " + movie.getTitle());	// display the title
		    } %>
    	</div>
    	<div class="pure-u-1-5" id="show_minutes_left">

    	</div>
    	<div class="pure-u-1-5">
    		<a href="browse.jsp">Back to browse</a>
    	</div>
	</div>
	<%
		if (movieValid) {
			// verify that a user is logged in
			if (userBean != null && userBean.isLoggedIn()) {
				Account acc = AccountDao.getAccountById(userBean.getAccountId());
				if (acc != null && acc.getMinutesRemaining() > 0) {
					%>
						<!-- <iframe class="fullscreen-watch-movie" src="<%= movie.getTrailerURL() %>" 
							frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>  -->
					<video class="fullscreen-watch-movie" src="img/fishvideo.webm" autoplay loop muted></video> 
					<%
				} else {
					//session.setAttribute("error_message", "You don't have enough hours left on your account to watch.");
					//request.getRequestDispatcher("browse.jsp").forward(request, response);
					response.sendRedirect("browse.jsp");
				}
			} else {
				//session.setAttribute("error_message", "You must be logged in to watch.");
				//request.getRequestDispatcher("browse.jsp").forward(request, response);
				response.sendRedirect("browse.jsp");
			}
		} else {
			//session.setAttribute("error_message", "You don't have enough hours left on your account to watch.");
			//request.getRequestDispatcher("browse.jsp").forward(request, response);
			response.sendRedirect("browse.jsp");
		}		
	%>
	

</div>


<script src="js/jquery.min.js"></script> 
<script src="js/toastr.min.js"></script>
<script src="js/common.js"></script>
<script>
$(function() { 
	<%-- Output any notifcations that are needed. --%>
	<%  if (session.getAttribute("notification_message") != null) {  %>
			toastr["success"]("<%= session.getAttribute("notification_message") %>");
	<% 
			session.setAttribute("notification_message", null);
		} %>
	<%-- Output any error messages --%>
	<%  if (session.getAttribute("error_message") != null) {  %>
			toastr["error"]("<%= session.getAttribute("error_message") %>");
	<% 
		session.setAttribute("error_message", null);
	} %>
	
	function checkMinutesLeft() {
		var URL_GET_HOURS = "AjaxInterface?action=get_minutes_left&userID=" + <%= userBean.getId() %>;
		console.log(URL_GET_HOURS);
		$.getJSON(URL_GET_HOURS).done(function(data) {
			if (data.success) {
				console.log(data);
				// TODO: format better
				$("#show_minutes_left").text("Hours remaining: " + (parseInt(data.minutes_left) / 60));
			} else {
				console.error("Failed getting minutes left");
			}
		});
	}
	
	function reduceNumMinutesLeft(_amount) {
		var URL_REDUCE_HOURS = "AjaxInterface?action=reduce_minutes_left&userID=" + <%= userBean.getId() %> + "&minutes=" + _amount;
		console.log(URL_REDUCE_HOURS);
		$.getJSON(URL_REDUCE_HOURS).done(function(data) {
			if (data.success) {
				console.log(data);
				// TODO: Format better
				$("#show_minutes_left").text("Hours remaining: " + (parseInt(data.minutes_left) / 60));
			} else {
				console.error(data);
				console.error("Failed reducing the minutes left");
			}
		});
	}
	
	// this function will check how many hours of viewing you have left
	checkMinutesLeft();
	
	var durationForUpdate = 60 * 1000; // how often to update the time in milliseconds
	
    function updateTimeWhileWatching() {
    	console.log("start 10 second timer...");
       setTimeout(updateTimeWhileWatching,durationForUpdate);  // call every minute
       console.log("updating the hours left...");
       reduceNumMinutesLeft(1);  // One update per minute
    }
    
	updateTimeWhileWatching();	// start the timer.	
});

</script>

</body>
</html>
