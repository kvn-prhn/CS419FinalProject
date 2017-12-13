package team3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieDao {

	public static Movie getMovieById(int id) {
		Movie m = null;
		try{  
            Connection con = DBLink.getConnection();
            /*PreparedStatement ps=con.prepareStatement("select " +
            		"movieID, movieGenre, movieTitle, movieDescription, movieYearReleased," +
            		"movieImage, movieTrailer, movieMPAARating, movieLength  "
            		+ "from movie where movieID = " + id);*/
            PreparedStatement ps = con.prepareStatement("select * from movie where movieID = ?");
            ps.setInt(1, id);
            //System.out.println(ps.toString());      
            
            ResultSet rs = ps.executeQuery(); 
            
            if (rs.next()) {
            	m = new Movie();
            	m.setId(rs.getInt(1));
                m.setGenre(rs.getString(2));
                m.setTitle(rs.getString(3));
                m.setDescription(rs.getString(4));
                m.setReleaseYear(rs.getInt(5));
                m.setImageURL(rs.getString(6));
                m.setTrailerURL(rs.getString(7));
                m.setReleaseDate(rs.getDate(8));
                m.setMPAARating(rs.getString(9));
                m.setDirector(rs.getString(10));
                m.setActor1(rs.getString(11));
                m.setActor2(rs.getString(12));
                m.setLength(rs.getInt(13));
            }
            con.close();  
        }catch(Exception e){
        	e.printStackTrace(); 
    	} 
		
		return m;
	}
	
	public static List<Movie> getMoviesByIdList(List<Integer> movieIdList) {
		List<Movie> movieList = new ArrayList<Movie>();
		Movie m = null;
		try{  
            Connection con = DBLink.getConnection();
            /*PreparedStatement ps=con.prepareStatement("select " +
            		"movieID, movieGenre, movieTitle, movieDescription, movieYearReleased," +
            		"movieImage, movieTrailer, movieMPAARating, movieLength  "
            		+ "from movie where movieID = " + id);*/
           
            PreparedStatement ps = con.prepareStatement("select * from movie where movieID = ?");
            for (int i = 0; i < movieIdList.size(); i++) {
	            ps.setInt(1, movieIdList.get(i));
	            
	            ResultSet rs = ps.executeQuery(); 
	            
	            if (rs.next()) {
	            	m = new Movie();
	            	m.setId(rs.getInt(1));
	                m.setGenre(rs.getString(2));
	                m.setTitle(rs.getString(3));
	                m.setDescription(rs.getString(4));
	                m.setReleaseYear(rs.getInt(5));
	                m.setImageURL(rs.getString(6));
	                m.setTrailerURL(rs.getString(7));
	                m.setReleaseDate(rs.getDate(8));
	                m.setMPAARating(rs.getString(9));
	                m.setDirector(rs.getString(10));
	                m.setActor1(rs.getString(11));
	                m.setActor2(rs.getString(12));
	                m.setLength(rs.getInt(13));
	                
	                movieList.add(m);
	            }
            }
            con.close();  
        }catch(Exception e){
        	e.printStackTrace(); 
    	} 
		
		return movieList;
	}
	
	public static List<Movie> searchMovies(String searchString, MovieFilter filter){
		List<Movie> list = new ArrayList<Movie>();  
		
		String[] searchTerms = searchString.split(" ");
		
		// return an empty list if there was no filter given.
		if (filter == null)
			return list;
		
        try{  
            Connection con = DBLink.getConnection();
            PreparedStatement ps=con.prepareStatement("select * from movie where (movieTitle like ? or movieDescription like ? or actor1 like ? or actor2 like ? or director like ?)" 
            			+ filter.filterClause() + " " + filter.orderByClause());  
            
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
                m.setReleaseYear(rs.getInt(5));
                m.setImageURL(rs.getString(6));
                m.setTrailerURL(rs.getString(7));
                m.setReleaseDate(rs.getDate(8));
                m.setMPAARating(rs.getString(9));
                m.setDirector(rs.getString(10));
                m.setActor1(rs.getString(11));
                m.setActor2(rs.getString(12));
                m.setLength(rs.getInt(13));
                
                //m.setLanguage(rs.getString(5));
                //m.setLength(rs.getInt(6));
                //m.setRating(rs.getInt(7));
                //m.setUserRating(rs.getInt(8));
                
                if (!list.stream().filter(o -> o.getTitle().equals(m.getTitle())).findFirst().isPresent())
                	list.add(m);
            }
            System.out.println(list);
            
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
	                m.setReleaseYear(rs.getInt(5));
	                m.setImageURL(rs.getString(6));
	                m.setTrailerURL(rs.getString(7));
	                m.setReleaseDate(rs.getDate(8));
	                m.setMPAARating(rs.getString(9));
	                m.setDirector(rs.getString(10));
	                m.setActor1(rs.getString(11));
	                m.setActor2(rs.getString(12));
	                m.setLength(rs.getInt(13));
	                
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
                m.setReleaseYear(rs.getInt(5));
                m.setImageURL(rs.getString(6));
                m.setTrailerURL(rs.getString(7));
                m.setReleaseDate(rs.getDate(8));
                m.setMPAARating(rs.getString(9));
                m.setDirector(rs.getString(10));
                m.setActor1(rs.getString(11));
                m.setActor2(rs.getString(12));
                m.setLength(rs.getInt(13));
                
                list.add(m);  
            }  
            con.close();  
        }catch(Exception e){
        	e.printStackTrace();
    	}  
          
        return list;  
    }  
	
}
