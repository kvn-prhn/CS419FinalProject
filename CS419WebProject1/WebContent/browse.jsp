<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%-- Bean for getting data from the server for the browse page. --%>
<jsp:useBean id="browseListBean" scope="session" class="team3.BrowseListBean"></jsp:useBean>
<%@ page import = "team3.Movie" %>
<%@ page import = "team3.MovieRatingDao" %>
<%@ page import = "team3.FavoritesListDao" %>
<%@ page import = "team3.QueueDao" %>
<%@ page import = "java.util.List" %>


<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Browse</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>

<% int userId = userBean.getId(); %>

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
				<h2>
					<span class="fav-style-marker">*</span>
					<span id="modal-label-movie-title">Movie Title</span>
					<span class="fav-style-marker">*</span>
					<span class="queue-position-marker"></span>
				</h2>
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
	        <div class="pure-u-2-5"><a id="watchButton" class="pure-button pure-button-active">Watch</a></div>
	         
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
	            		<label for="sort_by">Sort by:</label>
	            		<select id="sort_by" name="sort_by">
	            			<option value="keyword">Keyword</option>
	            			<option value="genre">Genre</option>
	            			<option value="rating">Rating</option>
	            			<option value="releaseYear">Release Year</option>
	            		</select>
	            	</div>
	            	
	            	<%-- Genre Filter Dropdown --%>
	            	<div class="pure-u-1-4">
	            		<label for="filter_by">Filter by:</label>
	            		<select id="filter_by" name="sort_by">
	            			<option value="drama">Drama</option>
	            			<option value="action">Action</option>
	            			<option value="comedy">Comedy</option>
	            			<option value="horror">Horror</option>
	            			<option value="sciFi">Sci-Fi</option>
	            		</select>
	            	</div>
	            	
	            	<div class="pure-u-1-4">
	            		<label for="search_bar">Search:</label>
	            		<input id="search_bar" name="search" input="text" value="<%= browseListBean.getSearchString() %>" placehold="Search">
	            	</div>
	            	
	            	<div class="pure-u-3-24">
	            		<input type="submit" class="pure-button">Update</input>
	            	</div>
            	</form>
            </div>
         	<% int movieOn = 0; %>
         	<% List<Integer> userFavList = FavoritesListDao.getFavoritesListByUserId(userId).getMovieIdList(); %>
         	<% List<Integer> userQueue = QueueDao.getQueueByUserId(userId).getMovieIdList(); %>
			<% for (Movie movie : browseListBean.getMovies()) { %>
				<div class="pure-u-sm-1 pure-u-lg-1-2">
					<div class="movie-display-block-<%= movieOn %>">
						<div class="pure-u-1">
							<%-- Meta-data for the movie for the modal. --%>
							<div style="display: none;" class="movie-full-description"> <%= movie.getDescription() %> </div>
							<div style="display: none;" class="movie-id-num"><%= movie.getId() %></div>
							<div style="display: none;" class="fav-marker"><%  
								System.out.println(userFavList);  // debugging
								String fav_marker_initial_style = "";   // initial styling of the movies for favorite marker.
								if (userFavList.contains(movie.getId())) {
									out.print("1");   // have a 1 here if this is in the users favorites
								} else { 
									out.print("0");   // have a 0 here if it is NOT in the users favorites.
									fav_marker_initial_style = "style=\"display: none;\"";  // show a display tag to be invisible.
								} %></div>
								<%-- If the queue position is less than 0, it means its not in the queue --%>
							<div style="display: none;" class="queue-position"><%
								if (userQueue != null && userQueue.contains(movie.getId())) {
									out.println("1"); // TODO: add in code to get the position of the movie in the queue for this user.
								} else {
									out.println("-1"); // not in queue
								}
								%></div>
							
							<h2 for="modal-trigger-center">
								<span <%= fav_marker_initial_style %> class="fav-style-marker">*</span>
								<span class="modal-open movie-title"><%= movie.getTitle() %></span>
								<span <%= fav_marker_initial_style %> class="fav-style-marker">*</span>
								<span class="queue-position-marker"><%
									if (userQueue != null && userQueue.contains(movie.getId())) {
										out.println("[1]");  // TODO: style as the position in the queue.
									}
								%></span>
							</h2>
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
									 <%= MovieRatingDao.getMovieRatingByUserId(movie.getId(), userBean.getId()).getRating() %>
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
		
		// iterate for each movie.
		for (var i = 0; i < <%= movieOn %>; i++) {
			var currentMovieId = ".movie-display-block-" + i;		// class of the block of this movie.
			var currentMovieTitle = $(currentMovieId).find(".movie-title").text().trim();
			// set adding all the data and button listeners when clicking on the movie.
			$(currentMovieId).click(
				{	// these are the parameters given when the modal is opened.
					classToReferenceMovieBlock : currentMovieId,
					movieId: $(currentMovieId).find(".movie-id-num").text(),	// a string that is the ID number of the movie.
					movieTitle: currentMovieTitle,								// a string of the title of the movie.
					movieDescription: $(currentMovieId).find(".movie-full-description").text(), // the full description of the movie
					movieImgSrc : $(currentMovieId).find("#movie-display-img").attr("src")		// the source of the image for the movie.
				}, 
				function(e) {	// what happens when the modal opens up...
					console.log(e.data);
					// set all of the attributes on the modal 
					$("#movie-id-current").html(e.data.movieId);
					$("#modal-label-movie-title").html(e.data.movieTitle);
					$("#modal-label-movie-description").html(e.data.movieDescription);
					$("#modal-movie-image").attr("src", e.data.movieImgSrc);
					// class to reference the movie block we're on
					var classToReferenceMovieBlock = e.data.classToReferenceMovieBlock;
					// BOOLEAN to see if this movie is in favorites list
					var currMovieInFavorites = $(classToReferenceMovieBlock).find(".fav-marker").text() === "1";
					// Number to see what position the queue is in, if anything.
					var currQueuePosition = parseInt( $(classToReferenceMovieBlock).find(".queue-position").text() );
					console.log(currQueuePosition);
					
					// change the favorites button based on if its in the favorites list or not.
					if (currMovieInFavorites) {
						$(".modal").find(".fav-style-marker").show();
						$("#favoritesButton").text("Remove from Favorites");
					} else {
						$(".modal").find(".fav-style-marker").hide();
						$("#favoritesButton").text("Add to Favorites");
					}
					
					// change the queue styling based on if it is in the queue or not.
					// TODO: Change modal styling based on the queue.
					
					console.log(currMovieInFavorites);
					
					// If you are logged into the user, show the buttons
					if (<%= userBean.isLoggedIn() ? "true" : "false" %>) {
						//$("#favoritesButton").show();
						//$("#queueButton").show();
						var paramsToAjax = {ajaxParams : "userID=" + (<%= userBean.getId() %>) + "&movieID=" + (e.data.movieId) };
						// TODO: Event listeners for the modal.
						$("#favoritesButton").off("click");  // remove the old event handler.
						$("#favoritesButton").click(paramsToAjax, function(e) {
							console.log("favorites button");
							var actionToDo = "";
							if (currMovieInFavorites) {		// different message depending on if its in favorites or not.
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
									if (actionToDo == "add_favorite") {  // add the favorite markers to it.
										console.log("ADDED TO THE FAVORITES");
										currMovieInFavorites = true;
										$(".modal").find(".fav-style-marker").show();
										$(classToReferenceMovieBlock).find(".fav-marker").text("1");   // mark as favorite
										$(classToReferenceMovieBlock).find(".fav-style-marker").show();	// show favorite markers
										$("#favoritesButton").text("Remove from Favorites");
									} else { // remove_favorites
										currMovieInFavorites = false;
										$(".modal").find(".fav-style-marker").hide();
										$(classToReferenceMovieBlock).find(".fav-marker").text("0");  // mark as not favorite
										$(classToReferenceMovieBlock).find(".fav-style-marker").hide();
										$("#favoritesButton").text("Add to Favorites");
									}
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
						
						$("#watchButton").attr("href", "watch_movie.jsp?movieID=" +  (e.data.movieId));
					} else {
						// The favorites and queue buttons should hide when the user is not logged in.
						$("#favoritesButton").attr("disabled", "");
						$("#queueButton").attr("disabled", "");
						$("#watchButton").attr("disabled", "");
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
