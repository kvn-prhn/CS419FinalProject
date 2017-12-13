package team3;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Search")
public class MovieSearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)   
            throws ServletException, IOException {  
		
		// get the current session
	    HttpSession session = request.getSession(true);
	    BrowseListBean browseList = (BrowseListBean)session.getAttribute("browseListBean");
	    if (browseList == null)
	    	browseList = new BrowseListBean(); 
		
        try{ 
        	
            MovieFilter filter = new MovieFilter();
            filter.setUserRating(false);
            filter.setTitle(false);
            
            browseList.setSearchString((String)request.getParameter("search"));
            
            if (browseList.getSearchString().equals(":queue")) {
            	User user = (User)session.getAttribute("userBean");
            	if (user != null && user.isLoggedIn())
            		browseList.setMovieList(MovieDao.getMoviesByIdList(user.getQueue()));
            
            } else if (browseList.getSearchString().equals(":favorites")) {
            	User user = (User)session.getAttribute("userBean");
            	if (user != null && user.isLoggedIn())
            		browseList.setMovieList(MovieDao.getMoviesByIdList(user.getFavoritesList()));
            } else {
            	
            	String filterString = (String)request.getParameter("filter_by").toLowerCase();
            	System.out.println("FilterSearchString: " + filterString);
            	if (filterString == null)
            		filterString = "any";
           		filter.setGenreFilter(filterString);
            
           		//System.out.println("ORDERBY: " + (String)request.getParameter("sort_by").toLowerCase());
            	switch ((String)request.getParameter("sort_by").toLowerCase()) {
            	case "keyword":
            		filter.setTitle(true);
            		break;
            	case "userrating":
            		filter.setUserRating(true);
            		break;
            	case "rating":
            		filter.setRating(true);
            		break;
            	case "length":
            		filter.setLength(true);
            		break;
            	case "releaseyear":
            		filter.setYear(true);
            		break;
            	case "genre":
            		filter.setGenre(true);
            		break;
        		default:
        			filter.setTitle(true);
        			//filter.setUserRating(true);
        			break;
            	}
	            
	            browseList.setFilter(filter);
	            browseList.getMovies();
            }
            
            session.setAttribute("browseListBean", browseList);
            response.sendRedirect("browse.jsp");
            
        }catch(Exception e){
        	e.printStackTrace();
    	} 
		
	}
	
}
