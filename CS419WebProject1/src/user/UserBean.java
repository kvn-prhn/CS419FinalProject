package user;
import java.sql.*;
import java.util.List;

public class UserBean {

	/** The primary key. */
	private int id;	
	/** The email(?) accountId. */
	private String accountId; 
	/** Username of the user. */
	private String username;  
	/** Whether this use is logged in or not.
	 * When this is false, all other variables 
	 * are set to null. */
	private boolean isLoggedIn;
	/** A list of all integers that are the keys
	 * To the users favorite movies */
	private List<Integer> favoritesList;

	public UserBean() {
		id = -1; // no logged in
		accountId = "";
		username = "";
		isLoggedIn = false; // initially not logged in
		favoritesList = null;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getAccountId() {
		return accountId;
	}
	
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public boolean isLoggedIn() {
		return isLoggedIn;
	}
	
	public void setLoggedIn(boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}
	
	public List<Integer> getFavoritesList() {
		return favoritesList;
	}
	
	public void setFavoritesList(List<Integer> favoritesList) {
		this.favoritesList = favoritesList;
	}
	
}
