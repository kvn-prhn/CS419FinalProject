<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Sign Up</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>


<!--
<div class="splash-container">

    <div class="splash">
		<video class="fullscreen" src="img/trafficbg.webm" autoplay loop muted></video>

        <h1 class="splash-head">Movies for you</h1>
        <p class="splash-subhead">
            Sign up for a great selection at a great price.
        </p>
        <p>
            <a href="#" class="pure-button pure-button-primary">Get Started</a>
        </p>
    </div>
</div>
-->

<div class="content-wrapper">
    <div class="content">
        <h2 class="content-head is-center">Sign Up</h2>

        <div class="pure-g">
            <div class="l-box pure-u-1">

                <form class="pure-form pure-form-stacked" method="POST" action="Signup">
                    <fieldset>
						<div class="pure-g">
							<div class="l-box pure-u-1-2">
								<label for="firstName">First Name</label>
								<input id="firstName" type="text" name="firstName" 
									value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>" placeholder="Your First Name">
							</div>
							<div class="l-box pure-u-1-2">
								<label for="lastName">Last Name</label>
								<input id="lastName" type="text" name="lastName" 
									value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>"placeholder="Your Last Name">
							</div>
							<div class="l-box pure-u-1">
								<label for="password">Your Password</label>
								<input id="password" type="password" name="password" placeholder="Your Password">
							</div>
							<div class="l-box pure-u-1">
								<label for="email">Your Email</label>
								<input id="email" type="email" name="email" 
									value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" placeholder="Your Email">
							</div>
							<div class="l-box pure-u-2-5">
								<label for="streetAddress">Street Address</label>
								<input id="streetAddress" type="text" name="streetAddress"
									value="<%= request.getParameter("streetAddress") != null ? request.getParameter("streetAddress") : "" %>" placeholder="Street Address">
							</div>
							<div class="l-box pure-u-1-5">
								<label for="city">City</label>
								<input id="city" type="text" name="city" 
									value="<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>" placeholder="City">
							</div>
							<div class="l-box pure-u-1-8">
								<label for="state">State</label>
								<input id="state" type="text" name="state"
									value="<%= request.getParameter("state") != null ? request.getParameter("state") : "" %>" placeholder="State">
							</div>
							<div class="l-box pure-u-1-5">
								<label for="zipCode">ZIP Code</label>
								<input id="zipCode" type="text" name="zipcode"
									value="<%= request.getParameter("zipcode") != null ? request.getParameter("zipcode") : "" %>" placeholder="ZIP Code">
							</div>
							<!--Radio buttons for choosing a plan-->
							<div class="l-box pure-u-1-4" style="background-color:#B87333">
								<label for="subChoice1">Bronze</label>
								<input type="radio" id="subChoice1" name="subscriptionTier" value="1">
								<p style="color:#6d4d35"><b> 10 hours of watch time per month
								<br><br>Ideal for those who watch a movie about every week</b></p>
							</div>
							<div class="l-box pure-u-1-4" style="background-color:silver">
								<label for="subChoice2">Silver</label>
								<input type="radio" id="subChoice2" name="subscriptionTier" value="2">
								<p style="color:#777676"><b> 30 hours of watch time per month
								<br><br>Ideal for those who watch a couple movies every week</b></p>
							</div>
							<div class="l-box pure-u-1-4" style="background-color:gold">
								<label for="subChoice3">Gold</label>
								<input type="radio" id="subChoice3" name="subscriptionTier" value="3">
								<p style="color:#a38b15"> <b>50 hours of watch time per month!
								<br><br>Ideal for an individual loves to watch movies</b></p>
								
							</div>
							<div class="l-box pure-u-1-4" style="background-color:#e5e4e2">
								<label for="subChoice4">Platinum</label>
								<input type="radio" id="subChoice4" name="subscriptionTier" value="4">
								<p> <b>100 hours of watch time per month!!!
								<br><br>Great for binge watching!</b></p>
							</div>
							
							<div class="l-box pure-u-1">
								<button type="submit" class="pure-button">Sign Up</button>
							</div>
						</div>
                    </fieldset>
                </form>
				
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
	
	<!--
    <div class="content">
        <h2 class="content-head is-center">Dolore magna aliqua. Uis aute irure.</h2>

        <div class="pure-g">
            <div class="l-box-lrg pure-u-1 pure-u-md-2-5">
                
            </div>

            <div class="l-box-lrg pure-u-1 pure-u-md-3-5">
                <h4>Contact Us</h4>
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                    consequat.
                </p>

                <h4>More Information</h4>
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                    tempor incididunt ut labore et dolore magna aliqua.
                </p>
            </div>
        </div>

    </div>
	-->

    <div class="footer l-box is-center">
        This is the footer.
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
		
		
		var current_page_id = "signup-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
