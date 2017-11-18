import java.sql.Date;

public class Account {

	private int id;
	private String firstName;
	private String lastName;
	private String password;
	private String email;
	private String address;
	
	private int subscriptionTier;
	private Date hoursResetDate;
	private float hoursRemaining;
	
	public int getId() {
		return id;
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
	public int getSubscriptionTier() {
		return subscriptionTier;
	}
	public void setSubscriptionTier(int subscriptionTier) {
		this.subscriptionTier = subscriptionTier;
	}
	public Date getHoursResetDate() {
		return hoursResetDate;
	}
	public void setHoursResetDate(Date hoursResetDate) {
		this.hoursResetDate = hoursResetDate;
	}
	public float getHoursRemaining() {
		return hoursRemaining;
	}
	public void setHoursRemaining(float hoursRemaining) {
		this.hoursRemaining = hoursRemaining;
	}
	
	
	
}
