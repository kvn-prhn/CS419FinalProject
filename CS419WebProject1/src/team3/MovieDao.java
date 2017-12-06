package team3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieDao {

	public static Movie getMovieById(int id) {
		Movie movie = null;
		try{  
            Connection con = DBLink.getConnection();
            PreparedStatement ps=con.prepareStatement("select " +
            		"movieID, movieGenre, movieTitle, movieDescription, movieYearReleased," +
            		"movieImage, movieTrailer, movieMPAARating, movieLength  "
            		+ "from movie where movieID = " + id);  
            
            System.out.println(ps.toString());      
            
            ResultSet rs = ps.executeQuery(); 
            
            if (rs.next()) {
            	movie = new Movie();
            	movie.setId(rs.getInt(1));
            	movie.setGenre(rs.getString(2));
            	movie.setTitle(rs.getString(3));
            	movie.setDescription(rs.getString(4));
            	movie.setReleaseYear(rs.getInt(5));
            	movie.setImageURL(rs.getString(6));
            	movie.setTrailerURL(rs.getString(7));
            	movie.setRating(rs.getInt(8));
            	movie.setLength(rs.getInt(9));
            }
            con.close();  
        }catch(Exception e){
        	e.printStackTrace(); 
    	} 
		
		return movie;
	}
	
	public static List<Movie> searchMovies(String searchString, MovieFilter filter){
		List<Movie> list = new ArrayList<Movie>();  
		
		String[] searchTerms = searchString.split(" ");
		
        try{  
            Connection con = DBLink.getConnection();
            PreparedStatement ps=con.prepareStatement("select * from movie where movieTitle like ? or movieDescription like ? " + filter.filterClause());  
            
            for (int i = 1; i <= ps.getParameterMetaData().getParameterCount(); i++) {
            	ps.setString(i, "%".concat(searchString.concat("%")));
            }
            System.out.println(ps.toString());      
            
            ResultSet rs = ps.executeQuery(); 
            
            while(rs.next()) {  
                Movie m = new Movie(); 
                
                m.setId(rs.getInt(1));
                m.setGenre(rs.getString(2));
                m.setTitle(rs.getString(3));
                m.setDescription(rs.getString(4));
                //m.setReleaseYear(rs.getInt(5));
                m.setImageURL(rs.getString(6));
                //m.setLanguage(rs.getString(5));
                //m.setLength(rs.getInt(6));
                //m.setRating(rs.getInt(7));
                //m.setUserRating(rs.getInt(8));
                
                if (!list.stream().filter(o -> o.getTitle().equals(m.getTitle())).findFirst().isPresent())
                	list.add(m);
            }
            
            for (int i = 0; i < searchTerms.length; i++) {
	            ps.setString(1, "%".concat(searchTerms[i].concat("%")));
	            ps.setString(2, "%".concat(searchTerms[i].concat("%")));
	            System.out.println(ps.toString());      
	            
	            rs = ps.executeQuery(); 
	            
	            while(rs.next()) {  
	                Movie m = new Movie(); 
	                
	                m.setId(rs.getInt(1));
	                m.setGenre(rs.getString(2));
	                m.setTitle(rs.getString(3));
	                m.setDescription(rs.getString(4));
	                //m.setReleaseYear(rs.getInt(5));
	                m.setImageURL(rs.getString(6));
	                //m.setLanguage(rs.getString(5));
	                //m.setLength(rs.getInt(6));
	                //m.setRating(rs.getInt(7));
	                //m.setUserRating(rs.getInt(8));
	                
	                if (!list.stream().filter(o -> o.getTitle().equals(m.getTitle())).findFirst().isPresent())
	                	list.add(m);
	            }  
            }
            con.close();  
        }catch(Exception e){
        	e.printStackTrace(); 
    	} 
          
        return list;  
	}
	
    public static List<Movie> getAllMovies(){  
        List<Movie> list = new ArrayList<Movie>();  
          
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps=con.prepareStatement("select * from movie");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){  
                Movie m = new Movie(); 
                
                m.setId(rs.getInt(1));
                m.setGenre(rs.getString(2));
                m.setTitle(rs.getString(3));
                m.setDescription(rs.getString(4));
                //m.setReleaseYear(rs.getInt(5));
                m.setImageURL(rs.getString(6));
                //m.setLanguage(rs.getString(5));
                //m.setLength(rs.getInt(6));
                //m.setRating(rs.getInt(7));
                //m.setUserRating(rs.getInt(8));
                
                list.add(m);  
            }  
            con.close();  
        }catch(Exception e){
        	e.printStackTrace();
    	}  
          
        return list;  
    }  
	
}
