<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Browse</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>


<div class="content-wrapper">
    <div class="content">
        <h2 class="content-head is-center">Browse</h2>

        <div class="pure-g">
            <div class="l-box pure-u-1">
				<p>
					We are browsing all of the movies on this page.
				</p>
				<p>
					<a href="watch_movie.jsp">Watch a movie</a>
				</p>
            </div>
            
        </div>
    </div>

	<div class="ribbon l-box-lrg pure-g">
        <div class="l-box-lrg is-center pure-u-1 pure-u-md-1-2 pure-u-lg-2-5">
            <img width="300" alt="File Icons" class="pure-img-responsive" src="img/common/movie-theater-auditorium.jpg">
        </div>
        <div class="pure-u-1 pure-u-md-1-2 pure-u-lg-3-5">

            <h2 class="content-head content-head-ribbon">Blah Blah</h2>

            <p>
                Placeholder stuff 
            </p>
        </div>
    </div>
</div>
<script src="js/jquery.min.js"></script>
<script>
	$(function() {
		var current_page_id = "browse-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
