<%-- Import all of the needed servlets for this page and its fragments. --%>
<%@ page import="team3.LoginServlet" %> <%-- "/Login" --%>
<%@ page import="team3.LogoutServlet" %> <%-- "/Logout" --%>

<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>GetFlix</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>


    
<div class="splash-container">

    <div class="splash">
		<!-- fullscreen video background-->
		<video class="fullscreen" src="img/cambg.webm" autoplay loop muted></video>

        <h1 class="splash-head">Movies for you</h1>
        <p class="splash-subhead">
            Sign up for a great selection at a great price.
        </p>
        <p>
            <a href="sign_up.jsp" class="pure-button pure-button-primary">Get Started</a>
        </p>
    </div>
</div>

<div class="content-wrapper-home-page">
    <div class="content">

        <div class="pure-g">
            <div class="l-box pure-u-1 pure-u-md-1-2 pure-u-lg-1-4">

                <h3 class="content-subhead">
                    <i class="fa fa-rocket"></i>
                    Huge selection
                </h3>
                <p>
                    Our service offers one of the best movie selections 
					on the web.
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-md-1-2 pure-u-lg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-mobile"></i>
                    Affordable
                </h3>
                <p>
                    We offer our amazing selection of movies at 
					an equally amazing price.
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-md-1-2 pure-u-lg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-th-large"></i>
                    Powerful search options
                </h3>
                <p>
                    Easily browse though our endless selection of
					films with our amazing search options.
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-md-1-2 pure-u-lg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-check-square-o"></i>
                    Choose when you pay
                </h3>
                <p>
                    Subscribe for a monthly plan, risk free, and 
					choose when you pay.
                </p>
            </div>
        </div>
    </div>


    <div class="ribbon l-box-lrg pure-g " style = "padding-bottom:60px" >
        <div class="pure-u-1 pure-u-md-1-2 pure-u-lg-3-5">
			<div class = "pure-u-4-10">
				<p>This website and its contents are all part of Team_Three_Entertainment(); 2017 - 2018 Ltd. <br /> 190 S Prospect Ave, Elmhurst, IL 60126, United States <br/> Use of this website is subject to our <a href="term_and_conditions.jsp">Terms & Conditions</a> and <a href="privacy_policy.jsp">Privacy Policy</a>. </p>
			</div>
			<div class = "pure-u-3-10">
				<p class="content-head content-head-ribbon">Contact us at getflixmovie@gmail.com</p>
				<a class="pure-menu-heading" href="https://www.facebook.com/Unofficial-Getflix-1878537172174603/"><img src="img/common/facebook.png"  style="width:30px;height:30px;border:0"></a>
				<!--  getflixmovie@gmail.com PW: team3entertainment -->
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
		
		
		var current_page_id = "home-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
