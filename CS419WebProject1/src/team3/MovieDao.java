package team3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieDao {

	public static List<Movie> searchMovies(String searchString, MovieFilter filter){
		List<Movie> list = new ArrayList<Movie>();  
		
		String[] searchTerms = searchString.split(" ");
		
        try{  
            Connection con = DBLink.getConnection();
            PreparedStatement ps=con.prepareStatement("select * from film where title like ? or description like ? " + filter.filterClause());  
            
            for (int i = 1; i <= ps.getParameterMetaData().getParameterCount(); i++) {
            	ps.setString(i, "%".concat(searchString.concat("%")));
            }
            System.out.println(ps.toString());      
            
            ResultSet rs = ps.executeQuery(); 
            
            while(rs.next()) {  
                Movie m = new Movie(); 
                
                m.setId(rs.getInt(1));
                m.setTitle(rs.getString(2));
                m.setDescription(rs.getString(3));
                m.setReleaseYear(rs.getInt(4));
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
	                m.setTitle(rs.getString(2));
	                m.setDescription(rs.getString(3));
	                //m.setReleaseYear(rs.getInt(4));
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
            PreparedStatement ps=con.prepareStatement("select * from film");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){  
                Movie m = new Movie(); 
                
                m.setId(rs.getInt(1));
                m.setTitle(rs.getString(2));
                m.setDescription(rs.getString(3));
                m.setReleaseYear(rs.getInt(4));
                m.setLanguage(rs.getString(5));
                m.setLength(rs.getInt(6));
                m.setRating(rs.getInt(7));
                m.setUserRating(rs.getInt(8));
                
                list.add(m);  
            }  
            con.close();  
        }catch(Exception e){
        	e.printStackTrace();
    	}  
          
        return list;  
    }  
	
}
