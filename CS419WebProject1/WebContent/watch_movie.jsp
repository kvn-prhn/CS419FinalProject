<%@page import="team3.MovieDao"%>
<%@page import="team3.Movie"%>
<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Watch Movie</title>
</head>
<body>

<%
String movieId = request.getParameter("movieID");
Movie movie = null;
if (movieId != null) {
	movie =  MovieDao.getMovieById(Integer.parseInt(movieId));
}
%>


<div class="content-wrapper-watch-movie">
    <div class="top-bar-movie-watching l-box is-center">
    <% if (movieId != null && movie != null) {
    	out.println(movie.getTitle());
    } %>
		<a href="browse.jsp">Back to browse</a>
	</div>
	<%
		if (movieId != null && movie != null) {
			%>
				<!-- <iframe class="fullscreen-watch-movie" src="<%= movie.getTrailerURL() %>" 
					frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>  -->
			<video class="fullscreen-watch-movie" src="img/fishvideo.webm" autoplay loop muted></video> 
			<%
		} else {
			out.println("MOVIE ID IS NOT VALID");
		}		
	%>
	
    <div class="footer l-box is-center">
        Bottom Bar
    </div>

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
	
});

</script>

</body>
</html>
