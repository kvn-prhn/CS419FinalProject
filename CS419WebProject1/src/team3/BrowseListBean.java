package team3;

import java.util.ArrayList;
import java.util.List;

public class BrowseListBean {
	
	public List<Movie> getMovies() {
		ArrayList<Movie> list = new ArrayList<>();
		for (int i = 0; i < 19; i++) {
			Movie movieI = new Movie();
			movieI.setTitle("Cool movie " + (i+1));
			list.add(movieI);
		}
		return list;
	}
}
