<%@include file='WEB-INF/modules/beans_common.jspf'%>
<%@page import = "java.util.Date" %>
<!doctype html>
<html lang="en">
<head>
    <%@include file='WEB-INF/modules/head_common.jspf'%>
    <title>Account settings</title>
</head>
<body>

<%@include file='WEB-INF/modules/header_common.jspf'%>


<div class="content-wrapper">
    <div class="content">
        <h2 class="content-head is-center">Account Settings</h2>

        <div class="pure-g">
            <div class="l-box pure-u-1">
            <% Account account = null;
            	if (userBean.isLoggedIn()) {
            		account = AccountDao.getAccountById(userBean.getAccountId()); 
           		}
            	if (account != null) { %>
				<form class="pure-form" action="UpdateAccount" method="POST">
				 	<fieldset>
				 		<div class="pure-u-1">
				 			<legend>Account Information</legend>
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8"> Name:</div>
				 				<div class="pure-u-1-3"><%= account.getLastName()  %>, <%= account.getFirstName()  %></div>
				 			</div>
				 			<hr style="border-top: dotted 2px;">
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8">Email:</div>
				 				<div class="pure-u-1-3"><%= account.getEmail() %></div>
				 			</div> 
				 			<hr style="border-top: dotted 2px;">
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8">Reset date:</div>
				 				<% Date d1 = account.getMinutesResetDate(); %>
				 				<div class="pure-u-1-3"><% out.print( (d1.getMonth() + 1) + "/" + d1.getDay() + "/" + (d1.getYear() + 1900)); %></div>
				 			</div> 
				 			<hr>
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8">Hours Left:</div>
				 				<div class="pure-u-1-3"><%= account.getMinutesRemaining() %></div>
				 			</div>
				 			<hr style="border-top: dotted 2px;">
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8">Current Address:</div>
				 				<div class="pure-u-1-3"><%= account.getAddress() %></div>
				 			</div>
				 			<hr style="border-top: dotted 2px;">
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-8">Subscription Tier:</div>
				 				<div class="pure-u-1-3"><img src="img/<%= account.getSubscriptionTierString() %>.png"></div>
				 				
				 			</div> 
				 			<hr style="border-top: dotted 2px;">
				 		</div>
				 		<div class="pure-control-group pure-u-1">
				            <div class="pure-u-1">
				            	<legend>Update password</legend>

				   				<div class="pure-u-3-5">
				            		<input id="password" type="password" name="update_password" placeholder="New password">
				            	</div>
				            	
				            	<div class="pure-u-3-5">
				            		<input id="update_password" class="pure-button pure-button-active" type="submit" 
				            			name="update_submit" value="Update Password" style="border: 1px solid black;">
				            	</div>
				            </div>

				        </div>
				        <div class="pure-control-group pure-u-1">
				            <div class="pure-u-1">
				            	<legend>Update Address</legend>
				            	<% Account acc = AccountDao.getAccountById(userBean.getAccountId()); %>
				            	<div class="pure-u-3-5">
				            		<label for="streetAddress">Street Address</label>
									<input id="streetAddress" type="text" name="streetAddress" value="" placeholder="Street Address" >
								</div>
								
								
								<div class="pure-u-3-5">
									<label for="city">City</label>
									<input id="city" type="text" name="city" value="" placeholder="City" >
								</div>
								
								<div class="pure-u-3-5">
									<label for="state">State</label>
									<input id="state" type="text" name="state" value="" placeholder="State" >
								</div>
								
								<div class="pure-u-3-5">
									<label for="zipCode">ZIP Code</label>
									<input id="zipCode" type="text" name="zipcode" value="" placeholder="ZIP Code" >
								</div>
								
								<div style="padding-bottom:45px" class="pure-u-3-5">
									<input id="update_address" class="pure-button pure-button-active" type="submit" 
				            				name="update_submit" value="Update Address" style="border: 1px solid black;">
								</div>
				        </div>
				        <div class="pure-control-group">
			            	<legend>Update Subscription change</legend>
			            	<div class="pure-u-1-5" style="background-color:#B87333">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Bronze.png" >
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice1" name="subscriptionTier" value="1">
							</div>
							<div class="pure-u-1-5" style="background-color:silver">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Silver.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice2" name="subscriptionTier" value="2">
								
							</div>
							<div class="pure-u-1-5" style="background-color:gold">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Gold.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice3" name="subscriptionTier" value="3">
								
							</div>
							<div class="pure-u-1-5" style="background-color:#e5e4e2">
								<div class="pure-u-2-5"></div>
								<div class="pure-u-1-5">
									<img src="img/Plat.png">
								</div>
								<div class="pure-u-2-5"></div>
								<input type="radio" id="subChoice4" name="subscriptionTier" value="4">
							</div>
							
							<div style="padding-bottom:45px" class="pure-u-3-5">
								<input id="update_address" class="pure-button pure-button-active" type="submit" 
				            			name="update_submit" value="Update Subscription" style="border: 1px solid black;"></div>
				        </div>
				 	</fieldset>
				</form>
				
			<% } else { // end the form
 				out.println("No account logged in");
 			}
 			%>
            </div>
            
        </div>
    </div>

	<div class="ribbon l-box-lrg pure-g " style = "padding-bottom:60px" >
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
		
		var current_page_id = "account-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
