<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Login</title>
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
        <h2 class="content-head is-center">Log in</h2>

        <div class="pure-g">
        	<div class="pure-u-sm-0 pure-u-md-1-5 pure-u-lg-1-4"></div>	
            <div class="l-box pure-u-sm-1 pure-u-md-3-5 pure-u-lg-1-2">

                <form action="Login" method="POST" class="pure-form pure-form-stacked">
                    <fieldset>
						<div class="pure-control-group">
							<label for="email">Your Email</label>
							<input id="email" type="email" name="email" placeholder="Your Email">
						</div>
						<div class="pure-control-group">
							<label for="password">Your Password</label>
							<input id="password" type="password" name="password" placeholder="Your Password">
						</div>
						<div class="pure-controls">
							<button type="submit" class="pure-button">Log in</button>
						</div>
                    </fieldset>
                </form>
				<p>
					No Account? <a href="sign_up.jsp" class="pure-link">Sign up now!</a>
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
		
		var current_page_id = "login-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
