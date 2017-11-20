<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Watch Movie</title>
</head>
<body>



<div class="content-wrapper-watch-movie">
    <div class="top-bar-movie-watching l-box is-center">
		We are watching a movie on this page. <a href="browse.jsp">Back to browse</a>
	</div>
	
	<video class="fullscreen-watch-movie" src="img/fishvideo.webm" autoplay loop muted></video>
    


    <div class="footer l-box is-center">
        Bottom Bar
    </div>

</div>


<script src="js/jquery.min.js"></script>


</body>
</html>
