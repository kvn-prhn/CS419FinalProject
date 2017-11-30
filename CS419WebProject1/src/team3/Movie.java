package team3;

public class Movie {
	
	private int id;
	private String title;
	private String description;
	private int releaseYear;
	private String language;
	private int length;
	private int rating;
	private int userRating;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
		while (i < words.length && lessDescription.length() < 30) {  // keep adding until its longer than 30
			lessDescription += words[i] + " ";
			i++;
		}
		return lessDescription;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getUserRating() {
		return userRating;
	}
	public void setUserRating(int userRating) {
		this.userRating = userRating;
	}
	
	
	
}
