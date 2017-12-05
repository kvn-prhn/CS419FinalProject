package team3;

public class MovieFilter {

	private boolean descending = false;
	
	// order by
	
	private boolean title = true;			// title DEFAULT
	private boolean userRating = true;		// userRating DEFAULT
	private boolean description = false;	// description
	private boolean year = false;			// year
	private boolean language = false;		// language
	private boolean origLanguage = false;	// original language
	private boolean length = false;			// length
	private boolean rating = false;			// rating
	
	public String filterClause() {
		StringBuilder filter = new StringBuilder();
		
		if (title | year | language | origLanguage | length | rating | userRating) {
			filter.append("order by");
			
			if (year)
				filter.append(" year,");
			if (language)
				filter.append(" language,");
			if (origLanguage)
				filter.append(" originalLanguage,");
			if (length)
				filter.append(" length,");
			if (rating)
				filter.append(" rating,");
			if (title)
				filter.append(" title,");
			if (userRating)
				filter.append(" userRating,");
		}
		
		if (filter.charAt(filter.length()-1) == ',');
		filter.deleteCharAt(filter.length()-1);
		
		if (descending)
			filter.append(" desc");
		else 
			filter.append(" asc");
		
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
	
}
