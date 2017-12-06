<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%-- Bean for getting data from the server for the browse page. --%>
<jsp:useBean id="browseListBean" scope="session" class="team3.BrowseListBean"></jsp:useBean>
<%@ page import = "team3.Movie" %>
<%@ page import = "team3.MovieRatingDao" %>

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
	       <div class="pure-u-1">
	       	<div class="pure-u-2-5"><a id="favoritesButton" class="pure-button pure-button-active">Add to Favorites</a></div>
	       	<div class="pure-u-2-5"><a id="queueButton" class="pure-button pure-button-active">Add to Queue</a></div>
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
					<!-- <a href="watch_movie.jsp">Watch a movie</a> -->
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
				<div class="pure-u-sm-1 pure-u-lg-1-2">
					<div class="movie-display-block-<%= movieOn %>">
						<div class="pure-u-1">
							<h2 for="modal-trigger-center" class="modal-open movie-title">
								<% out.println(movie.getTitle()); %>
							</h2>
							<%-- Meta-data for the movie for the modal --%>
							<div style="display: none;" class="movie-full-description"> <%= movie.getDescription() %> </div>
							<div style="display: none;" class="movie-id-num"><%= movie.getId() %></div>
						</div>
						<div class="pure-u-1-24"></div><!-- spacing -->
						<div class="pure-u-5-24">
							<img class="pure-img" id="movie-display-img" alt="loading..." src="<%= movie.getImageURL() %>" ></img>
						</div>
						<div class="pure-u-2-24"></div><!-- spacing -->
						<div class="pure-u-2-5">  
							<p>
								<%= movie.getTruncatedDescription() %>
							</p>
							<p>
								Ratings are fun
								<div class="pure-u-1">							 
									 <%= MovieRatingDao.getMovieRatingByUserId(movie.getId(), userBean.getId()) %>
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
			$(currentMovieId).click(
				{	// these are the parameters given when the modal is opened
					movieId: $(currentMovieId).find(".movie-id-num").text(),	// a string
					movieTitle: currentMovieTitle,
					movieDescription: $(currentMovieId).find(".movie-full-description").text(),
					movieImgSrc : $(currentMovieId).find("#movie-display-img").attr("src")
				}, 
				function(e) {	// what happens when the modal opens up...
					//console.log(e.data);
					$("#movie-id-current").html(e.data.movieId);
					$("#modal-label-movie-title").html(e.data.movieTitle);
					$("#modal-label-movie-description").html(e.data.movieDescription);
					$("#modal-movie-image").attr("src", e.data.movieImgSrc);
					
					// If you are logged into the user, show the buttons
					if (<%= userBean.isLoggedIn() ? "true" : "false" %>) {
						//$("#favoritesButton").show();
						//$("#queueButton").show();
						var paramsToAjax = {ajaxParams : "accountID=" + (<%= userBean.getAccountId() %>) + "&movieID=" + (e.data.movieId) };
						// TODO: Event listeners for the modal.
						$("#favoritesButton").off("click");  // remove the old event handler.
						$("#favoritesButton").click(paramsToAjax, function(e) {
							console.log("favorites button");
							var isInFavorites = false;
							var actionToDo = "";
							if (isInFavorites) {
								// remove from the queue
								actionToDo = "remove_favorite";
							} else {
								// add to the queue
								actionToDo = "add_favorite";
							}
							var URL = "AjaxInterface?action=" + actionToDo + "&" + e.data.ajaxParams;
							console.log(URL);
							$.getJSON(URL).done(function(data) {
								console.log(data);
								if (data.success) {
									console.log("updated favorites");
									// TODO: change styling for queue
								} else {
									console.error("Error with updating favorites");
								}
							});
						});
						$("#queueButton").off("click");  // remove the old event handler.
						$("#queueButton").click(paramsToAjax, function(e) {
							console.log("queue button");
							// if the movie is NOT in the queue...
							var isInQueue = false;
							var actionToDo = "";
							if (isInQueue) {
								// remove from the queue
								actionToDo = "remove_queue";
							} else {
								// add to the queue
								actionToDo = "add_queue";
							}
							$.getJSON("AjaxInterface?action=" + actionToDo + "&" + e.data.ajaxParams).done(function(data) {
								console.log(data);
								if (data.success) {
									console.log("updated the queue");
									// TODO: change styling for queue
								} else {
									console.error("Error with updating queue");
								}
							});
						});
					} else {
						// The favorites and queue buttons should hide when the user is not logged in.
						$("#favoritesButton").attr("disabled", "");
						$("#queueButton").attr("disabled", "");
					}
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
				//getMovieImageFor(movieId, movieTitle);
				
				
				// TODO: Make all the event handlers for adding to favorites and stuff.
			})(currentMovieId, currentMovieTitle);
			
		}
	});
	
</script>

</body>
</html>
