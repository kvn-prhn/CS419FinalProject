package team3;
import java.util.List;

public class User {

	private int id;
	private int accountId;
	private String username;
	private List<Integer> favoritesList;
	private List<Integer> queue;
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
		if (!favoritesList.contains(movieId))
			favoritesList.add(movieId);
		else
			return 1;
		FavoritesList fl = new FavoritesList();
		fl.setUserId(id);
		fl.setMovieIdList(favoritesList);
		return FavoritesListDao.update(fl);
	}
	
	public int removeFromFavorites(int movieId) {
		if (!favoritesList.contains(movieId))
			favoritesList.remove(movieId);
		else
			return 1;
		FavoritesList fl = new FavoritesList();
		fl.setUserId(id);
		fl.setMovieIdList(favoritesList);
		return FavoritesListDao.update(fl);
	}
	
	public int addToQueue(int movieId) {
		if (!queue.contains(movieId))
			queue.add(movieId);
		else
			return 1;
		Queue q = new Queue();
		q.setUserId(id);
		q.setMovieIdList(queue);
		return QueueDao.update(q);
	}
	
	public int removeFromQueue(int movieId) {
		if (!queue.contains(movieId))
			queue.remove(movieId);
		else
			return 1;
		Queue q = new Queue();
		q.setUserId(id);
		q.setMovieIdList(queue);
		return QueueDao.update(q);
	}

	public List<Integer> getQueue() {
		return queue;
	}

	public void setQueue(List<Integer> queue) {
		this.queue = queue;
	}
	
	
}
