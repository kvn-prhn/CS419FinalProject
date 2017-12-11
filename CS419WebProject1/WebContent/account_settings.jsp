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
				 				<div class="pure-u-1-4"> Name:</div>
				 				<div class="pure-u-2-3"><%= account.getLastName()  %>, <%= account.getFirstName()  %></div>
				 			</div>
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-4">Email:</div>
				 				<div class="pure-u-2-3"><%= account.getEmail() %></div>
				 			</div> 
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-4">Reset date:</div>
				 				<% Date d1 = account.getHoursResetDate(); %>
				 				<div class="pure-u-2-3"><% out.print( d1.getMonth() + "/" + d1.getDay() + "/" + d1.getYear()); %></div>
				 			</div> 
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-4">Hours Left:</div>
				 				<div class="pure-u-2-3"><%= account.getHoursRemaining() %></div>
				 			</div>
				 			<div class="pure-u-1">
				 				<div class="pure-u-1-4">Subscription Tier:</div>
				 				<div class="pure-u-2-3"><img src="img/<%= account.getSubscriptionTierString() %>.png"></div>
				 				
				 			</div> 
				 		</div>
				 		<div class="pure-control-group pure-u-1">
				            <div class="pure-u-1">
				            	<legend>Update password</legend>
				   				<div class="pure-u-1-3">
				            		<input id="password" type="password" name="update_password" placeholder="New password">
				            	</div>
				            	<div class="pure-u-1-3">
				            		<input id="update_password" class="pure-button pure-button-primary" type="submit" 
				            			name="update_submit" value="Update Password">
				            	</div>
				            	<div class="pure-u-1-3">
				            		<input id="update_password" class="pure-button pure-button-primary" type="submit" 
				            			name="update_submit" value="Testing Button">
				            	</div>
				            </div>
				        </div>
				        <div class="pure-control-group pure-u-1">
				            <div class="pure-u-1">
				            	<legend>Update Address</legend>
				            	<label for="streetAddress">Street Address</label>
								<input id="streetAddress" type="text" name="streetAddress" value="" placeholder="Street Address">
								<label for="city">City</label>
								<input id="city" type="text" name="city" value="" placeholder="City">
								<label for="state">State</label>
								<input id="state" type="text" name="state" value="" placeholder="State">
								<label for="zipCode">ZIP Code</label>
								<input id="zipCode" type="text" name="zipcode" value="" placeholder="ZIP Code">
							</div>
				        </div>
				        <div class="pure-control-group">
			            	<legend>Update Subscription change</legend>
			            	<div class="pure-u-1-5">
								<label for="subChoice1">Bronze</label>
								<input type="radio" id="subChoice1" name="subscriptionTier" value="1">
							</div>
							<div class="pure-u-1-5">
								<label for="subChoice2">Silver</label>
								<input type="radio" id="subChoice2" name="subscriptionTier" value="2">
								
							</div>
							<div class="pure-u-1-5">
								<label for="subChoice3">Gold</label>
								<input type="radio" id="subChoice3" name="subscriptionTier" value="3">
								
							</div>
							<div class="pure-u-1-5">
								<label for="subChoice4">Platinum</label>
								<input type="radio" id="subChoice4" name="subscriptionTier" value="4">
							</div>
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
	
    <div class="footer l-box is-center">
        This is the footer.
    </div>

</div>

<script src="js/jquery.min.js"></script>
<script>
	$(function() {
		var current_page_id = "account-link";
		$("#" + current_page_id).addClass("pure-menu-selected");
	});
	
</script>

</body>
</html>
