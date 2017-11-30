<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%-- Bean for getting data from the server for the browse page. --%>
<jsp:useBean id="browseListBean" scope="session" class="team3.BrowseListBean"></jsp:useBean>
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
       <label for="modal-trigger-center" class="close">&#10006;</label>
       <div class="pure-g">
	       <div class="pure-u-1">
				<h2 id="modal-label-movie-title">Movie Title</h2>
	       </div>
	       <div class="pure-u-1-5">
	       	<img class="pure-img" id="modal-movie-image" alt="movie image" src=""></img>
	       </div>
	       <div class="pure-u-4-5" id="modal-label-movie-description">
		       Description.
	       </div>
       </div>
     </div>
   </div>
 </div>
<!-- End Modal -->

<div class="content-wrapper">
    <div class="content">
        <h2 class="content-head is-center">Browse</h2>

        <div class="pure-g">
            <div class="pure-u-1">
				<p>
					We are browsing all of the movies on this page.
				</p>
				<p>
					<a href="watch_movie.jsp">Watch a movie</a>
				</p>
				<p>
					<label  class="open-modal">OPEN THAT MODAL</label>
				</p>
            </div>
            <div class="pure-u-1">
            	<form class="pure-form" method="get" action="Search">
	            	<div class="pure-u-1-4">
	            		<label for="search_bar">Search:</label>
	            		<input id="search_bar" name="search" input="text" placehold="Search">
	            	</div>
	            	<div class="pure-u-1-4">
	            		<label for="sort_by">Sort by:</label>
	            		<select id="sort_by" name="sort_by">
	            			<option value="nothing">Select an option</option>
	            		</select>
	            	</div>
	            	<div class="pure-u-3-24">
	            		<input type="submit" class="pure-button">Update</input>
	            	</div>
            	</form>
            </div>
         	<% int movieOn = 0; %>
			<% for (Movie movie : browseListBean.getMovies()) { %>
				<div class="pure-u-sm-1-2 pure-u-md-1-3 pure-u-lg-1-4">
					<div class="movie-display-block-<%= movieOn %>">
						<div class="pure-u-1">
							<h3 for="modal-trigger-center" class="modal-open movie-title">
								<% out.println(movie.getTitle()); %>
							</h3>
							<%-- Meta-data for the movie for the modal --%>
							<div style="display: none;" class="movie-full-description"> <%= movie.getDescription() %> </div>
						</div>
						<div class="pure-u-1">
							<img class="pure-img" id="movie-display-img" alt="loading..." src=""></img>
						</div>
						<div class="pure-u-1">			
							<p>
								Description for "<%= movie.getTitle() %>": <%= movie.getTruncatedDescription() %>
							</p>
							<p>
								Ratings are fun
								<div class="pure-u-1">
									<% int randomRating = (int)(Math.random() * 5.0);
										for (int i = 0; i < randomRating; i++) { %>
											<div class="pure-u-1-5">
												<img src="img/star.png" class="pure-img">
											</div>	
									<% 	}  %>
								</div>
							</p>
							<p>
							<label for="modal-trigger-center" class="pure-button pure-button-active open-modal">
								MORE INFO
							</label>
							</p>
						</div>
					</div>
				</div>
			<% movieOn++; // track which block we're iterating on. 
			} %>
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
		
		for (var i = 0; i < <%= movieOn %>; i++) {
			var currentMovieId = ".movie-display-block-" + i;
			var currentMovieTitle = $(currentMovieId).find(".movie-title").text().trim();
			console.log(currentMovieTitle );
			$(currentMovieId).click(
				{
					movieTitle: currentMovieTitle,
					movieDescription: $(currentMovieId).find(".movie-full-description").text(),
					movieImgSrc : $(currentMovieId).find("#movie-display-img").attr("src")
				}, 
				function(e) {
					console.log(e.data);
					$("#modal-label-movie-title").html(e.data.movieTitle);
					$("#modal-label-movie-description").html(e.data.movieDescription);
					$("#modal-movie-image").attr("src", e.data.movieImgSrc);
			});
			
			(function(movieId, movieTitle) {
				
				function getMovieImageFor(id, searchQuery) {
					var API_KEY = '7130256-0e83e707d7f0f3407d56ce8aa';
					var URL = "https://pixabay.com/api/?key="+API_KEY+"&q="+encodeURIComponent(searchQuery)+"&callback=?";
					$.getJSON(URL).done(function(data){
						if (data.totalHits > 0) {
							// set the source of the image to wherever this is. 
							
							// find the first image that is a good size...
							var bestImg = 0;
							var bestRatio = data.hits[0].imageWidth / data.hits[0].imageHeight; 
							for (var i = 1; i < data.hits.length; i++) {
								var testRatio = data.hits[i].imageWidth / data.hits[i].imageHeight;
								if (Math.abs(testRatio - 1) < Math.abs(bestRatio - 1)) {
									bestImg = i;
									bestRatio = testRatio;
								}
							}
							$(id).find(".movie-display-img").attr("src", data.hits[bestImg].webformatURL);
						} else {
							$(id).find(".movie-display-img").attr("alt", "No image found.");
							// do another search, chopping off the last word in the search query
							var searchTerms = searchQuery.split(" ");
							searchTerms.splice( searchTerms.length - 1, 1);
							var newSearchQuery = searchTerms.join(" ");
							console.log("Shorter term: " + newSearchQuery);
							if (newSearchQuery !== "") {
								getMovieImageFor(id, newSearchQuery);
							}
						}
					});
				}
				// update the movie image.
				getMovieImageFor(movieId, movieTitle);
				
			})(currentMovieId, currentMovieTitle);
			
		}
	});
	
</script>

</body>
</html>
