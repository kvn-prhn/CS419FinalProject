<%@include file='WEB-INF/modules/beans_common.jspf'%>

<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Sign Up</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>

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
								<label for="streetAddress">Billing Street Address</label>
								<input id="streetAddress" type="text" name="streetAddress"
									value="<%= request.getParameter("streetAddress") != null ? request.getParameter("streetAddress") : "" %>" placeholder="Billing Street Address">
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
							<div class="l-box pure-u-4-5">		
								<label for="creditCardNum">Credit Card Number</label>
								<input id="creditCardNum" type="text" name="creditCardNum"
									value="<%= request.getParameter("creditCardNum") != null ? request.getParameter("creditCardNum") : "" %>" placeholder="Credit Card Number">
							</div>
							<div class="l-box pure-u-1-5">		
								<label for="cvv">CVV</label>
								<input id="cvv" type="text" name="cvv"
									value="<%= request.getParameter("cvv") != null ? request.getParameter("cvv") : "" %>" placeholder="CVV">
							</div>
							<!--Radio buttons for choosing a plan-->
							<div class="l-box pure-u-1-4" style="background-color:#B87333">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Bronze.png" >
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice1" name="subscriptionTier" value="1">
								<p style="color:#6d4d35"><b>$3/month
								<br><br>10 hours of watch time per month
								<br><br>Ideal for those who watch a movie about every week</b></p>
							</div>
							<div class="l-box pure-u-1-4" style="background-color:silver">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Silver.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice2" name="subscriptionTier" value="2">
								<p style="color:#777676"><b>$8/month
								<br><br>30 hours of watch time per month
								<br><br>Ideal for those who watch a couple movies every week</b></p>
							</div>
							<div class="l-box pure-u-1-4" style="background-color:gold">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Gold.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice3" name="subscriptionTier" value="3">
								<p style="color:#a38b15"> <b>$12/month
								<br><br>50 hours of watch time per month!
								<br><br>Ideal for an individual loves to watch movies</b></p>
								
							</div>
							<div class="l-box pure-u-1-4" style="background-color:#e5e4e2">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Plat.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice4" name="subscriptionTier" value="4">
								<p> <b>$20/month
								<br><br>100 hours of watch time per month!!!
								<br><br>Great for binge watching!</b></p>
							</div>
							
							<div class="l-box pure-u-1">
								<button type="submit" class="pure-button" style="border: 2px solid black;">Sign Up</button>
							</div>
						</div>
                    </fieldset>
                </form>
				
            </div>
            
        </div>
    </div>

	<div class="ribbon l-box-lrg pure-g " style = "padding-bottom:60px" >
        <div class="pure-u-1 pure-u-md-1-2 pure-u-lg-3-5">
			<div class = "pure-u-4-10">
				<p>This website and its contents are all part of Team_Three_Entertainment(); 2017 - 2018 Ltd. <br /> 190 S Prospect Ave, Elmhurst, IL 60126, United States <br/> 
				Use of this website is subject to our <a class="home-links-page" href="term_and_conditions.jsp">Terms & Conditions</a> and <a class="home-links-page" href="privacy_policy.jsp">Privacy Policy</a>. </p>
			</div>
			<div class = "pure-u-4-10">
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
		
		
		var current_page_id = "signup-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
