<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Login</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>


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
							<button type="submit" class="pure-button" style="border: 2px solid black;">Log in</button>
						</div>
                    </fieldset>
                </form>
				<p>
					No Account? <a href="sign_up.jsp" class="pure-link">Sign up now!</a>
				</p>
            </div>
            
        </div>
    </div>
    
    
	<div class="ribbon l-box-lrg pure-g " style = "padding-bottom:185px" >
        <div class="pure-u-1 pure-u-md-1-2 pure-u-lg-3-5">
			<div class = "pure-u-4-10">
				<p>This website and its contents are all part of Team_Three_Entertainment(); 2017 - 2018 Ltd. <br /> 190 S Prospect Ave, Elmhurst, IL 60126, United States <br/> Use of this website is subject to our <a href="term_and_conditions.jsp">Terms & Conditions</a> and <a href="privacy_policy.jsp">Privacy Policy</a>. </p>
			</div>
			<div class = "pure-u-4-10">
				<p class="content-head content-head-ribbon">Contact us at getflixmovie@gmail.com</p>
				<a class="pure-menu-heading" href="https://www.facebook.com/Unofficial-Getflix-1878537172174603/"><img src="img/common/facebook.png"  style="width:30px;height:30px;border:0"></a>
			</div>
        </div>
    </div>

    <div class="footer l-box is-center" >
            <img width="300" alt="File Icons" class="pure-img-responsive" src="img/common/CLogo.png">
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
