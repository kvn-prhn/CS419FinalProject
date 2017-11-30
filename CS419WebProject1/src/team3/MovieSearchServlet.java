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
            
            {
            	switch ((String)request.getParameter("sort_by").toLowerCase()) {
            	case "title":
            		filter.setTitle(true);
            		break;
            	case "userrating":
            		filter.setUserRating(true);
            		break;
            	case "length":
            		filter.setLength(true);
            		break;
            	case "year":
            		filter.setYear(true);
            		break;
        		default:
        			filter.setTitle(true);
        			filter.setUserRating(true);
            	}
            }
            
            browseList.setFilter(filter);
            browseList.getMovies();
            
            session.setAttribute("browseListBean", browseList);
            response.sendRedirect("browse.jsp");
            
        }catch(Exception e){
        	e.printStackTrace();
    	} 
		
	}
	
}
