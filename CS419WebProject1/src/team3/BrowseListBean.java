package team3;

import java.util.ArrayList;
import java.util.List;

public class BrowseListBean {
	
	private List<Movie> movieList = new ArrayList<Movie>();
	private String searchString = "";
	private MovieFilter filter = new MovieFilter();
	
	public List<Movie> getMovies() {

        filter.setUserRating(false);
		movieList.clear();  
		
        try{ 
        	
            movieList = MovieDao.searchMovies(searchString, filter);
            
        }catch(Exception e){
        	e.printStackTrace();
    	}  
          
        return movieList;  
	}

	public List<Movie> getMovieList() {
		return movieList;
	}

	public void setMovieList(List<Movie> movieList) {
		this.movieList = movieList;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public MovieFilter getFilter() {
		return filter;
	}

	public void setFilter(MovieFilter filter) {
		this.filter = filter;
	}
}
