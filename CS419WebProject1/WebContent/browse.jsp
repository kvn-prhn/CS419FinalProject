<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%-- Bean for getting data from the server for the browse page. --%>
<jsp:useBean id="browseListBean" scope="session" class="team3.BrowseListBean"></jsp:useBean>
<%@ page import = "team3.Movie" %>
<%@ page import = "team3.MovieRatingDao" %>
<%@ page import = "team3.FavoritesListDao" %>
<%@ page import = "team3.QueueDao" %>
<%@ page import = "java.util.List" %>

<% 
	// ensure that the browse bean is populated if there is no search term
	if (browseListBean.getSearchString().length() == 0 && browseListBean.getMovies().isEmpty()) {
		browseListBean.getMovies();  // set the internal movies list.
	}
%>

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
       		<!-- Row 1 of modal -->
			<div class="pure-u-1-2">
				<h2>
					<span class="fav-style-marker">*</span>
					<span id="modal-label-movie-title">Movie Title</span>
					<span class="fav-style-marker">*</span>
					<span class="queue-position-marker"></span>
				</h2>
			</div>
			<div class="pure-u-1-4"><a id="favoritesButton" class="pure-button pure-button-active" style="border: 2px solid black;">Add to Favorites</a></div>
			<div class="pure-u-1-4"><a id="queueButton" class="pure-button pure-button-active" style="border: 2px solid black;">Add to Queue</a></div>
			
			<!-- Row 2, which is the rest. -->
	       <div class="pure-u-1-4">
	       	<img class="pure-img" id="modal-movie-image" alt="movie image" src=""></img>
	       </div>
	       <div class="pure-u-3-4"><!-- Content section to right of movie. -->
	       		<div class="pure-u-1">
		       		<div id="modal-label-movie-description"  class="l-box">Description.</div>
	       		</div>
	       		<div class="pure-u-1-3">
	       			<div class="l-box">Genre: <span id="modal-label-genre">Genre.</span></div>
	       		</div>
	       		<div class="pure-u-1-3">
	       			<div class="l-box">Rated: <span id="modal-label-mpaa">MPAA Rating.</span></div>
	       		</div>
	       		<div class="pure-u-1">
	       			<div class="l-box">Length: <span id="modal-label-length">Length.</span></div>
	       		</div>
	       		<div class="pure-u-1">
	       			<div class="l-box">Directed by: <span id="modal-label-director">Director.</span></div>
	       		</div>
	       		<div class="pure-u-1">
	       			<div class="l-box">Actors: <span id="modal-label-actors">Actors.</span></div>
	       		</div>
	       		
	       		<% if (userBean.isLoggedIn()) {   %>
	       		<div class="pure-u-1">
	       			<div class="l-box" >Your Rating: <span id="modal-label-rating">Rating.</span></div>
	       		</div>
	       		<% }  %>
	       		<div class="pure-u-1">
	       			<div class="l-box">Average Rating: <span id="modal-label-rating-average">Rating.</span></div>
	       		</div>
	       		<div class="pure-u-1">
	       			<div class="l-box"><% if (userBean.isLoggedIn()) { %>
	       				<a id="watchButton" class="pure-button pure-button-active" style="border: 2px solid black;">Watch Now!</a>
	       			<% } %></div>
	       		</div>
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
	            		<label for="sort_by">Order by:</label>
	            		<select id="sort_by" name="sort_by">
	            			<% String curr_sby = request.getParameter("sort_by"); %>
	            			[<%= curr_sby %>]
	            			<option value="keyword" <%= curr_sby != null && curr_sby.equals("keyword") ? "selected" : "" %>>Keyword</option>
	            			<option value="genre" <%= curr_sby != null && curr_sby.equals("genre") ? "selected" : "" %>>Genre</option>
	            			<option value="rating" <%= curr_sby != null && curr_sby.equals("rating") ? "selected" : "" %>>Rating</option>
	            			<option value="releaseYear" <%= curr_sby != null && curr_sby.equals("releaseYear") ? "selected" : "" %>>Release Year</option>
	            		</select>
	            	</div>
	            	
	            	<%-- Genre Filter Dropdown --%>
	            	<div class="pure-u-1-4">
	            		<label for="filter_by">Filter by:</label>
	            		<select id="filter_by" name="filter_by">
	            			<% String curr_f_opt = request.getParameter("filter_by"); %>
	            			[<%= curr_f_opt %>]
	            			<option value="any" <%= curr_f_opt != null && curr_f_opt.equals("any") ? "selected" : "" %>>Any</option>
	            			<option value="drama" <%= curr_f_opt != null && curr_f_opt.equals("drama") ? "selected" : "" %>>Drama</option>
	            			<option value="action" <%= curr_f_opt != null && curr_f_opt.equals("action") ? "selected" : "" %>>Action</option>
	            			<option value="comedy" <%= curr_f_opt != null && curr_f_opt.equals("comedy") ? "selected" : "" %>>Comedy</option>
	            			<option value="horror" <%= curr_f_opt != null && curr_f_opt.equals("horror") ? "selected" : "" %>>Horror</option>
	            			<option value="sciFi" <%= curr_f_opt != null && curr_f_opt.equals("sciFi") ? "selected" : "" %>>Sci-Fi</option>
	            		</select>
	            	</div>
	            	
	            	<div class="pure-u-1-4">
	            		<label for="search_bar">Search:</label>
	            		<input id="search_bar" name="search" input="text" value="<%= browseListBean.getSearchString() %>" placehold="Search">
	            	</div>
	            	
	            	<div class="pure-u-3-24">
	            		<input type="submit" value="Update" class="pure-button" style="border: 2px solid black;"></input>
	            	</div>
            	</form>
            </div>
         	<% int movieOn = 0; %>
         	<% List<Integer> userFavList = FavoritesListDao.getFavoritesListByUserId(userId).getMovieIdList(); %>
			<% for (Movie movie : browseListBean.getMovieList()) { %>
				<div class="pure-u-sm-1-2  pure-u-md-1-4  pure-u-lg-1-5  pure-u-xl-1-6  movie-display-block-<%= movieOn %> "> 						
						<div class="pure-u-1  movie-display-upper">
							<%-- Meta-data for the movie for the modal. 
								Meta data lives inside of <div> tags that have the display: none; style
								and are identified bytheir class. The content of the <div> tag is 
								the content of the meta data.
								 movie-full-description: The full description of this film
								 movie-id-num: a STRING of the id number of this movie.
								 fav-marker: A String that will be either "1" if this movie is
									in the favorites list of the user. "0" if this movie is
									not in the favorites list of the user. If no user is logged in
									this value will be 0.
								 queue-position: A STRING that is what position this movie is
									in the logged in user's queue. If there is no user logged
									in or the movie is not in the users queue, this value is -1. 
								actors: The actors of the movie
								genre: the movie genre
								mpaa: the mpaa rating of the movie
								director: the director of the movie.
								movie_rating: The rating of the movie
							--%>
							<div style="display: none;" class="movie-full-description"> <%= movie.getDescription() %> </div>
							<div style="display: none;" class="movie-id-num"><%= movie.getId() %></div>
							<div style="display: none;" class="fav-marker"><%  
								String fav_marker_initial_style = "";   // initial styling of the movies for favorite marker.
								if (userFavList.contains(movie.getId())) {
									out.print("1");   // have a 1 here if this is in the users favorites
								} else { 
									out.print("0");   // have a 0 here if it is NOT in the users favorites.
									fav_marker_initial_style = "style=\"display: none;\"";  // show a display tag to be invisible.
								} %></div>
								<%-- If the queue position is less than 0, it means its not in the queue --%>
							<div style="display: none;" class="queue-position"><%
								if ( userBean.getQueue() != null &&  userBean.getQueue().contains(movie.getId())) {
									System.out.println( userBean.getQueue());
									out.println(1 +  userBean.getQueue().indexOf( movie.getId() ));
								} else {
									out.println("-1"); // not in queue
								}
								%></div>
							<div style="display: none;" class="actors">
								<%= movie.getActor1() + ", " + movie.getActor2() %>
							</div>
							<div style="display: none;" class="genre">
								<%= movie.getGenre() %>
							</div>
							<div style="display: none;" class="mpaa">
								<%= movie.getMPAARating() %>
							</div>
							<div style="display: none;" class="length">
								<%= movie.getLength() %> minutes
							</div>
							<div style="display: none;" class="director">
								<%= movie.getDirector() %>
							</div>
							<div style="display: none;" class="movie_rating"><!-- USERS rating -->
								<%= movie.getUserRating() %>
							</div>
							<div style="display: none;" class="movie_rating_average">
								<%= MovieRatingDao.getAverageMovieRating(movie.getId()).getRating() %>
							</div>
							<div class="pure-u-1">
								<div 
								<% 	if (userBean.getQueue() == null || !userBean.getQueue().contains(movie.getId())) { 
											out.print("style=\"display: none;\""); 
										} %> class="queue-position-marker queue-position-marker-block"><%
									if ( userBean.getQueue() != null &&  userBean.getQueue().contains(movie.getId())) {
										out.print("[" + (1 +  userBean.getQueue().indexOf( movie.getId() )) + "]");  // TODO: style as the position in the queue.
									}
								%></div>
								<img class="pure-img" id="movie-display-img" alt="loading..." src="<%= movie.getImageURL() %>">
							</div>
						</div>
						<div class="pure-u-1 movie-display-lower">  
							<label class="modal-trigger-center-lbl modal-open" for="modal-trigger-center">
								<h2>
								<span <%= fav_marker_initial_style %> class="fav-style-marker">*</span>
								<span class="movie-title"><%= movie.getTitle() %></span>
								<span <%= fav_marker_initial_style %> class="fav-style-marker">*</span>

								</h2>
							</label>
							<div class="pure-u-1  movie-shorter-desc">
								<%= movie.getTruncatedDescription() %>
							</div> 
						</div>
				</div>
			<% movieOn++; // track which block we're iterating on. 
			} %>
        </div>
    </div>

	<div class="ribbon l-box-lrg pure-g " >
        <div class="pure-u-1 pure-u-md-1-2 pure-u-lg-3-5">
			<div class = "pure-u-4-10">
				<p>This website and its contents are all part of Team_Three_Entertainment(); 2017 - 2018 Ltd. <br /> 190 S Prospect Ave, Elmhurst, IL 60126, United States <br/> 
				Use of this website is subject to our <a class="home-links-page" href="term_and_conditions.jsp">Terms & Conditions</a> and <a class="home-links-page" href="privacy_policy.jsp">Privacy Policy</a>. </p>
			</div>
			<div class = "pure-u-4-10">
				<p class="content-head content-head-ribbon">Contact us at getflixmovie@gmail.com</p>
				<a class="pure-menu-heading" href="https://www.facebook.com/Unofficial-Getflix-1878537172174603/"><img src="img/common/facebook.png"  style="width:30px;height:30px;border:0"></a>
			</div>
        </div>
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
					// class to reference the movie block we're on
					var classToReferenceMovieBlock = e.data.classToReferenceMovieBlock;
				
					// set all of the attributes on the modal 
					$("#movie-id-current").html(e.data.movieId);
					$("#modal-label-movie-title").html(e.data.movieTitle);
					$("#modal-label-movie-description").html(e.data.movieDescription);
					$("#modal-movie-image").attr("src", e.data.movieImgSrc);

					// add more information about the movie to the modal
					$("#modal-label-genre").html( $(classToReferenceMovieBlock).find(".genre").text() );
					$("#modal-label-mpaa").html( $(classToReferenceMovieBlock).find(".mpaa").text() );
					$("#modal-label-length").html( $(classToReferenceMovieBlock).find(".length").text() );
					$("#modal-label-director").html( $(classToReferenceMovieBlock).find(".director").text() );
					$("#modal-label-actors").html( $(classToReferenceMovieBlock).find(".actors").text() );

					var avgRatingNum = parseInt( $(classToReferenceMovieBlock).find(".movie_rating_average").text() );

					// set stars for the average rating.
					$("#modal-label-rating-average").text("");
					var avgRatingHtmlImg = "";
					for (var i = 0; i < avgRatingNum; i++) {
						avgRatingHtmlImg += "<img src=\"img/star_gold.png\" height=\"16\">";
					}
					for (var i = 0; i < 5 - avgRatingNum; i++) {
						avgRatingHtmlImg += "<img src=\"img/star_gray.png\" height=\"16\">";  
					}
					$("#modal-label-rating-average").html(avgRatingHtmlImg);
					
					// user rating
					var ratingNum = parseInt( $(classToReferenceMovieBlock).find(".movie_rating").text() );
					function setModalRating(_ratingNum) {
						$("#modal-label-rating").text("");
						var ratingHtmlImg = "";
						var totalNumOn = 1;
						for (var i = 0; i < _ratingNum; i++) {
							
							var titleToHave = "<%= userBean.isLoggedIn() ? "Rate \" + (totalNumOn) + \" Stars" : "Log in to rate" %>";
							ratingHtmlImg += "<img title=\"" + titleToHave + "\" id=\"rating-star-" + (totalNumOn) + "\" src=\"img/star_gold.png\" height=\"16\">";
							totalNumOn++;
						}
						for (var i = 0; i < 5 - _ratingNum; i++) {
							ratingHtmlImg += "<img title=\"Rate " + (totalNumOn) + " Stars\" id=\"rating-star-" + (totalNumOn) + "\" src=\"img/star_gray.png\" height=\"16\">";  
							totalNumOn++;
						}
						$("#modal-label-rating").html(ratingHtmlImg);
						
						// conditional ratings events being put on rating stars based on the user being logged in.
						if (<%= userBean.isLoggedIn() ? "true" : "false" %>) {
							// function to leave a rating for this movie. Between 1 and 5.
							function leaveMovieRating(_rating) {
								var URL_RATING = "AjaxInterface?action=leave_rating&userID=" + (<%= userBean.getId() %>) +
										"&movieID=" + (e.data.movieId) + "&rating=" + _rating;
								$.getJSON(URL_RATING).done(function(data) {
									if (data.success) {
										toastr["success"]("Movie rated!");
									} else {
										console.error("Error with leaving the rating");
									}
								});
							}
							
							for (var i = 1; i <= 5; i++) {
								(function(thisI) { 
									$("#rating-star-" + thisI).addClass("rating-star-active");   // make it style to act activated
									$("#rating-star-" + thisI).click(function(e) {
										(function(_r) { 
											var ratingToHave = _r;
											setModalRating(ratingToHave);		// set the styling for the rating
											$(classToReferenceMovieBlock).find(".movie_rating").text(ratingToHave);	// set the meta data rating
											// update the server's rating
											leaveMovieRating(ratingToHave);
										})(thisI);  // set the rating for this button to be i + 1
									});
								})( i );  // pass in this i
							}
						} // end conditional event listeners
					}
					setModalRating(ratingNum);
					
					// BOOLEAN to see if this movie is in favorites list
					var currMovieInFavorites = $(classToReferenceMovieBlock).find(".fav-marker").text() === "1";
					// Number to see what position the queue is in, if anything.
					var currQueuePosition = parseInt( $(classToReferenceMovieBlock).find(".queue-position").text() );
										
					// change the favorites button based on if its in the favorites list or not.
					if (currMovieInFavorites) {
						$(".modal").find(".fav-style-marker").show();
						$(".modal").find(".queue-position-marker").show();
						$(".modal").find(".queue-position-marker").text("[" + currQueuePosition + "]");
						$("#favoritesButton").text("Remove from Favorites");
					} else {
						$(".modal").find(".queue-position-marker").hide();
						$(".modal").find(".fav-style-marker").hide();
						$("#favoritesButton").text("Add to Favorites");
					}
					
					if (currQueuePosition >= 0) {
						$("#queueButton").text("Remove from Queue");
					} else {
						$("#queueButton").text("Add to Queue");
					}

					// If you are logged into the user, show the buttons
					if (<%= userBean.isLoggedIn() ? "true" : "false" %>) {
						var paramsToAjax = {ajaxParams : "userID=" + (<%= userBean.getId() %>) + "&movieID=" + (e.data.movieId) };
						
						$("#favoritesButton").off("click");  // remove the old event handler.
						$("#favoritesButton").click(paramsToAjax, function(e) {
							var actionToDo = "";
							if (currMovieInFavorites) {		// different message depending on if its in favorites or not.
								// remove from the queue
								actionToDo = "remove_favorite";
							} else {
								// add to the queue
								actionToDo = "add_favorite";
							}
							var URL = "AjaxInterface?action=" + actionToDo + "&" + e.data.ajaxParams;
							$.getJSON(URL).done(function(data) {
								if (data.success) {
									if (actionToDo == "add_favorite") {  // add the favorite markers to it.
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
								} else {
									console.error("Error with updating favorites");
								}
							});
						});
						$("#queueButton").off("click");  // remove the old event handler.
						$("#queueButton").click(paramsToAjax, function(e) {
							// if the movie is NOT in the queue...
							var actionToDo = "";
							if (currQueuePosition >= 0) {  // item is already in queue, and can be removed.
								actionToDo = "remove_queue";
							} else { // queue value is less than 0, and can be added
								// add to the queue
								actionToDo = "add_queue";
							}
							var URL = "AjaxInterface?action=" + actionToDo + "&" + e.data.ajaxParams;
							$.getJSON(URL).done(function(data) {
								if (data.success) {
									if (actionToDo == "add_queue") {
										// if we have just added to the queue, then set
										// it as removing from the queue.
										$(classToReferenceMovieBlock).find(".queue-position").text(e.data.new_pos);  // set to current position
										$("#queueButton").text("Remove from Queue");
										location.reload(true);   // refresh the page for the queue.
									} else {
										$(classToReferenceMovieBlock).find(".queue-position").text("-1"); // not in queue
										$("#queueButton").text("Add to Queue");
										location.reload(true);   // refresh the page for the queue.
									}
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
			
		}
	});
	
</script>

</body>
</html>
