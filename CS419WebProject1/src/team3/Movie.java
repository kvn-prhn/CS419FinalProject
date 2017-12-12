package team3;

import java.util.Date;

public class Movie {
	
	private int id;
	private String genre;
	private String title;
	private String description;
	private int releaseYear;
	private String imageURL;
	private String trailerURL;
	private Date releaseDate;
	private String MPAARating;
	private String director;
	private String actor1;
	private String actor2;
	
	private String language; 	// UNUSED
	private int length;			// UNUSED
	private int userRating;		// External - from movieratingteam3 table 
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
		setUserRating(id);
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * Get a shorter version of the description for displaying on the browse page.
	 * @return A shorter description.
	 */
	public String getTruncatedDescription() {
		if (description == null)
			return "";
		
		String lessDescription = "";
		String[] words = description.split(" ");
		int i = 0;
		while (i < words.length && lessDescription.length() < 72) {  // keep adding until its longer than 30
			lessDescription += words[i] + " ";
			i++;
		}
		return lessDescription + "...";
	}
	public int getReleaseYear() {
		return releaseYear;
	}
	public void setReleaseYear(int releaseYear) {
		this.releaseYear = releaseYear;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public String getMPAARating() {
		return MPAARating;
	}
	public void setMPAARating(String MPAARating) {
		this.MPAARating = MPAARating;
	}
	public int getUserRating() {
		return userRating;
	}
	public void setUserRating(int userRating) {
		this.userRating = MovieRatingDao.getAverageMovieRating(id).getRating();
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public String getTrailerURL() {
		return trailerURL;
	}
	public void setTrailerURL(String trailerURL) {
		this.trailerURL = trailerURL;
	}
	public Date getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor1() {
		return actor1;
	}
	public void setActor1(String actor1) {
		this.actor1 = actor1;
	}
	public String getActor2() {
		return actor2;
	}
	public void setActor2(String actor2) {
		this.actor2 = actor2;
	}
	
	
	
}
