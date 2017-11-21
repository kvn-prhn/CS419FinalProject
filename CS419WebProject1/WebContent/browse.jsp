<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%-- Bean for getting data from the server for the browse page. --%>
<jsp:useBean id="browseListBean" scope="request" class="team3.BrowseListBean"></jsp:useBean>
<%@ page import = "team3.Movie" %>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Browse</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>

<!-- Copied from: https://github.com/jorgechavz/pure-css-modal/blob/master/index.html -->
 <!-- Center modal for showing information about a movie after clicking on it. -->
 <div class="modal">
   <input id="modal-trigger-center" class="checkbox" type="checkbox">
   <div class="modal-overlay">
     <label for="modal-trigger-center" class="o-close"></label>
     <div class="modal-wrap a-center">
       <label for="modal-trigger-small" class="close">&#10006;</label>
       <h2 id="modal-label-movie-title">Movie Title</h2>
       <p id="modal-label-movie-description">
         Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique cum sequi maxime officia provident voluptatibus aut! Non autem asperiores repellat architecto laboriosam officiis ab libero enim illo animi, error alias.
       </p>
     </div>
   </div>
 </div>
<!-- End Modal -->

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
				<p>
					<label for="modal-trigger-center" class="open-modal">OPEN THAT MODAL</label>
				</p>
            </div>
            <div class="l-box pure-u-1">
            	<div class="pure-g">
            		<% int movieOn = 0; %>
					<% for (Movie movie : browseListBean.getMovies()) { %>
						<div class="pure-u-1-3">
							<div class="movie-display-block-<%= movieOn %>">
								<label for="modal-trigger-center" class="modal-open">
									<% out.println(movie.getTitle()); %>
								</label>
							</div>
						</div>
					<% movieOn++; // track which block we're iterating on. 
					} %>
				</div>
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
		
		function modalDisplayForMovie(cName) {
			$("#modal-label-movie-title").html(cName);
		}
		
		
		var current_page_id = "browse-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
		
		for (var i = 0; i <= <%= movieOn %>; i++) {
			var currentMovieId = ".movie-display-block-" + i;
			$(currentMovieId).click(function(e) {
				console.log(e.target['className']); 
				modalDisplayForMovie(e.target['className']);
			});
		}
	});
	
</script>

</body>
</html>
