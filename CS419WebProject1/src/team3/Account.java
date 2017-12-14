package team3;
import java.sql.Date;

public class Account {

	private int id;
	private String firstName;
	private String lastName;
	private String password;
	private String email;
	private String address;
	private String creditCardNum;
	private String cvv;
	private String CCEDate;
	
	private int subscriptionTier;
	//private Date hoursResetDate;
	private Date minutesResetDate;
	//private float hoursRemaining;
	private int minutesRemaining;
	
	public int getId() {
		return id;
	}
	public String getCCEDate() {
		return CCEDate;
	}
	public void setCCEDate(String cCEDate) {
		CCEDate = cCEDate;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setAddress(String street, String city, String state, String zipCode) {
		this.address = street + ", " + city + 	", " + state + " " + zipCode;
	}
	public int getSubscriptionTier() {
		return subscriptionTier;
	}
	public void setSubscriptionTier(int subscriptionTier) {
		this.subscriptionTier = subscriptionTier;
	}
	public String getSubscriptionTierString() {
		switch(this.subscriptionTier) {
			case 1: 	return "Bronze"; 	
			case 2: 	return "Silver"; 	
			case 3: 	return "Gold"; 		
			case 4: 	return "Plat"; 	
		}
		return "INVALID_SUB_TIER";
	}
	public int getMinutesRemaining() {
		return minutesRemaining;
	}
	public String getTruncatedStringHours() {
		double minsD = (double)minutesRemaining;
		double hoursLeft = minsD / 60;
		String doubleStr = hoursLeft + "";
		String[] parts = doubleStr.split("\\.");
		if (parts.length >= 2) {
			int endOfSubStr = 2;	
			if (parts[1].length() < 2) {			// shorten the substring if its too large.
				endOfSubStr = parts[1].length();
			}
			return parts[0] + "." + parts[1].substring(0, endOfSubStr);	
		} else {
			return parts[0];
		}
	}
	public void setMinutesRemaining(int minutesRemaining) {
		this.minutesRemaining = minutesRemaining;
	}
	public Date getMinutesResetDate() {
		return minutesResetDate;
	}
	public void setMinutesResetDate(Date minutesResetDate) {
		this.minutesResetDate = minutesResetDate;
	}
	public String getCreditCardNum() {
		return creditCardNum;
	}
	public void setCreditCardNum(String creditCardNum) {
		this.creditCardNum = creditCardNum;
	}
	public String getCVV() {
		return cvv;
	}
	public void setCVV(String cvv) {
		this.cvv = cvv;
	}
	
}
