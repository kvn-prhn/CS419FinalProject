package team3;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class User {

	private int id;
	private int accountId;
	private String username;
	private List<Integer> favoritesList = new ArrayList<Integer>();
	private List<Integer> queue = new ArrayList<Integer>();
	private boolean isLoggedIn;
	
	public User() {
		id = -1;
		accountId = -1;
		isLoggedIn = false;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public List<Integer> getFavoritesList() {
		return favoritesList;
	}
	public void setFavoritesList(List<Integer> favoritesList) {
		this.favoritesList = favoritesList;
	}
	public boolean isLoggedIn() {
		return isLoggedIn;
	}
	public void setLoggedIn(boolean isLoggedIn) {
		this.isLoggedIn = isLoggedIn;
	}
	
	public int addToFavorites(int movieId) {
		if (favoritesList != null && !favoritesList.contains(movieId))
			favoritesList.add(movieId);
		else
			return 1;
		FavoritesList fl = new FavoritesList();
		fl.setUserId(id);
		fl.setMovieIdList(favoritesList);
		return FavoritesListDao.update(fl);
	}
	
	public int removeFromFavorites(int movieId) {
		if (favoritesList != null && favoritesList.contains(movieId)) {
			favoritesList.remove(favoritesList.indexOf(movieId));
			Connection con = DBLink.getConnection();
			try {
				PreparedStatement ps = con.prepareStatement("delete from favoriteteam3 where movieId = " + movieId + " and userId = " + id);
				int status = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		else
			return 1;
		FavoritesList fl = new FavoritesList();
		fl.setUserId(id);
		fl.setMovieIdList(favoritesList);
		FavoritesListDao.update(fl);
		return 0;
	}
	
	public int addToQueue(int movieId) {
		if (!queue.contains(movieId)) {
			System.out.println("Added this movie: " + movieId);
			queue.add(movieId);
		} else {
			System.err.println("Error adding tot he queue");
			return 1;	// return 1 on failure.
		}
		Queue q = new Queue();
		q.setUserId(id);
		q.setMovieIdList(queue);
		return QueueDao.update(q);
	}
	
	public int removeFromQueue(int movieId) {
		if (queue != null && queue.contains(movieId)) {
			queue.remove(queue.indexOf(movieId));
			Connection con = DBLink.getConnection();
			try {
				PreparedStatement ps = con.prepareStatement("delete from queueteam3 where movieId = " + movieId + " and userId = " + id);
				int status = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		else
			return 1;
		Queue q = new Queue();
		q.setUserId(id);
		q.setMovieIdList(queue);
		QueueDao.update(q);
		return 0;
	}

	public List<Integer> getQueue() {
		if (queue == null || queue.isEmpty()) {	// try to update the queue if there is nothing in there.
			System.out.println("updated queue");
			List<Integer> movieIdList = QueueDao.getQueueByUserId(id).getMovieIdList();
			if (movieIdList != null) {
				queue = movieIdList;
			} 
		}
		return queue;
	}

	public void setQueue(List<Integer> queue) {
		this.queue = queue;
	}
	
	
}
