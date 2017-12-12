package team3;

public class MovieFilter {

	private boolean descending = false;
	
	// order by
	private boolean title = true;			// title DEFAULT
	private boolean userRating = false;		// userRating
	private boolean description = false;	// description
	private boolean year = false;			// year
	private boolean language = false;		// language
	private boolean origLanguage = false;	// original language
	private boolean length = false;			// length
	private boolean rating = false;			// rating
	private boolean genre = false;			// genre
	
	private enum Genre {any, drama, action, comedy, horror, scifi}
	private Genre filterGenre = Genre.any;
	
	public void setGenreFilter(String filterName) {
		switch (filterName) {
		case "any":
			filterGenre = Genre.any;
			break;
		case "drama":
			filterGenre = Genre.drama;
			break;
		case "action":
			filterGenre = Genre.action;
			break;
		case "comedy":
			filterGenre = Genre.comedy;
			break;
		case "scifi":
			filterGenre = Genre.scifi;
			break;
		case "horror":
			filterGenre = Genre.horror;
			break;
			default:
				break;
		}
	}
	
	public String orderByClause() {
		StringBuilder filter = new StringBuilder();
		
		if (title | year | language | origLanguage | length | rating | userRating | genre) {
			filter.append("order by");
			
			if (year)
				filter.append(" movieYearReleased,");
			if (language)
				filter.append(" language,");
			if (origLanguage)
				filter.append(" originalLanguage,");
			if (length)
				filter.append(" length,");
			if (rating)
				filter.append(" movieMPAARating,");
			if (title)
				filter.append(" movieTitle,");
			if (userRating)
				filter.append(" userRating,");
			if (genre)
				filter.append(" movieGenre,");
		
			if (filter.charAt(filter.length()-1) == ',');
				filter.deleteCharAt(filter.length()-1);
			
			if (descending)
				filter.append(" desc");
			else 
				filter.append(" asc");
			
		}
		
		return filter.toString();
	}
	
	public String filterClause() {
		StringBuilder filter = new StringBuilder();
		filter.append("AND ");
		switch (filterGenre) {
		case any:
			filter.append("true");
			break;
		case drama:
			filter.append("movieGenre = 'Drama'");
			break;
		case comedy:
			filter.append("movieGenre = 'Comedy'");
			break;
		case action:
			filter.append("movieGenre = 'Action'");
			break;
		case horror:
			filter.append("movieGenre = 'Horror'");
			break;
		case scifi:
			filter.append("movieGenre = 'Sci-Fi'");
			break;
		default:
			break;
		}
		
		
		return filter.toString();
	}
	
	public boolean isDescending() {
		return descending;
	}
	public void setDescending(boolean descending) {
		this.descending = descending;
	}
	public boolean isTitle() {
		return title;
	}
	public void setTitle(boolean title) {
		this.title = title;
	}
	public boolean isYear() {
		return year;
	}
	public void setYear(boolean year) {
		this.year = year;
	}
	public boolean isLanguage() {
		return language;
	}
	public void setLanguage(boolean language) {
		this.language = language;
	}
	public boolean isOrigLanguage() {
		return origLanguage;
	}
	public void setOrigLanguage(boolean origLanguage) {
		this.origLanguage = origLanguage;
	}
	public boolean isLength() {
		return length;
	}
	public void setLength(boolean length) {
		this.length = length;
	}
	public boolean isRating() {
		return rating;
	}
	public void setRating(boolean rating) {
		this.rating = rating;
	}
	public boolean isUserRating() {
		return userRating;
	}
	public void setUserRating(boolean userRating) {
		this.userRating = userRating;
	}

	public boolean isDescription() {
		return description;
	}

	public void setDescription(boolean description) {
		this.description = description;
	}

	public boolean isGenre() {
		return genre;
	}

	public void setGenre(boolean genre) {
		this.genre = genre;
	}
	
}
