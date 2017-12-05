package team3;
import java.util.List;

public class Queue {

	private int userId;
	private List<Integer> movieIdList;
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public List<Integer> getMovieIdList() {
		return movieIdList;
	}
	public void setMovieIdList(List<Integer> movieIdList) {
		this.movieIdList = movieIdList;
	}
	
}
