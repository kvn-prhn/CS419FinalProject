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
    	<div class="pure-u-1-5" id="show_hours_left">
    		<%-- This value is updated in javascript --%>
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
				if (acc != null && acc.getHoursRemaining() > 0) {
					%>
						<!-- <iframe class="fullscreen-watch-movie" src="<%= movie.getTrailerURL() %>" 
							frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>  -->
					<video class="fullscreen-watch-movie" src="img/fishvideo.webm" autoplay loop muted></video> 
					<%
				} else {
					session.setAttribute("error_message", "You don't have enough hours left on your account to watch.");
					request.getRequestDispatcher("browse.jsp").forward(request, response);
				}
			} else {
				session.setAttribute("error_message", "You must be logged in to watch.");
				request.getRequestDispatcher("browse.jsp").forward(request, response);
			}
		} else {
			session.setAttribute("error_message", "You don't have enough hours left on your account to watch.");
			request.getRequestDispatcher("browse.jsp").forward(request, response);
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
	
	var localHoursLeft = -1; // we have no idea what this value is yet.
	
	function debugShowHoursLeft() {
		console.log("localHoursLeft: " + localHoursLeft);
	}
	
	function checkHoursLeft() {
		var URL_GET_HOURS = "AjaxInterface?action=get_hours_left&userID=" + <%= userBean.getId() %>;
		console.log(URL_GET_HOURS);
		$.getJSON(URL_GET_HOURS).done(function(data) {
			if (data.success) {
				console.log(data);
				localHoursLeft =  data.hours_left;
				debugShowHoursLeft();  // temp
				$("#show_hours_left").text("Hours remaining: " + data.hours_left);
			} else {
				console.error("Failed getting hours left");
			}
		});
	}
	
	function reduceNumHoursLeft(_amount) {
		var URL_REDUCE_HOURS = "AjaxInterface?action=get_hours_left&userID=" + <%= userBean.getId() %>;
		console.log(URL_GET_HOURS);
		$.getJSON(URL_GET_HOURS).done(function(data) {
			if (data.success) {
				console.log(data);
				localHoursLeft =  data.hours_left;
				debugShowHoursLeft();  // temp
			} else {
				console.error("Failed getting hours left");
			}
		});
	}
	
	// this function will check how many hours of viewing you have left
	checkHoursLeft();
	
	
	
});

</script>

</body>
</html>
