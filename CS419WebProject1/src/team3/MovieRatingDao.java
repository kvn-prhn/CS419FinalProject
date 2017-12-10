package team3;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MovieRatingDao {

	/*
	private static Connection getConnection(){  
        Connection con = null;  
        try{  
            Class.forName("com.mysql.jdbc.Driver");  
            con=DriverManager.getConnection("jdbc:mysql://localhost/sakila?useSSL=false", "root", "sesame");  
        }
        catch(Exception e){
        	System.out.println(e);
    	}  
        return con;  
    }
    */ 
	
	public static int create(MovieRating mr) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "insert into movieRating(movieId, userId, rating) values (?,?,?)");  
            ps.setInt(1, mr.getMovieId());
            ps.setInt(2, mr.getUserId());
            ps.setInt(3, mr.getRating());
              
            status = ps.executeUpdate();  
            
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static int update(MovieRating mr) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "update movieRating set rating=? where movieID=? and userID=?");  
            ps.setInt(1, mr.getRating());
            ps.setInt(2, mr.getMovieId());
            ps.setInt(3, mr.getUserId());
              
            status = ps.executeUpdate();  
            
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static int delete(MovieRating mr) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "delete from movieRating where movieID=? and userID=?");  
            ps.setInt(1, mr.getMovieId());
            ps.setInt(2, mr.getUserId());
              
            status = ps.executeUpdate();  
            
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
         
        return status;  
	}
	
	public static MovieRating getAverageMovieRating(int movieId) {
		MovieRating mr = new MovieRating();
		mr.setUserId(-1); 			// rating not tied to a single user
		
		try {
			Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement("SELECT AVG(rating) as avgRating FROM movieratingteam3 WHERE movieId = ?;");  
            ps.setInt(1, movieId);  
            
            ResultSet rs = ps.executeQuery();  
            
            if(rs.next()){  
                mr.setMovieId(movieId);  	// rating for the selected movieId
                mr.setRating(rs.getInt(1)); // average user rating fetched from DB 
            }  
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return mr;
	}
	
	public static MovieRating getMovieRatingByUserId(int movieId, int userId) {
		MovieRating mr = new MovieRating();  
        
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement("SELECT * FROM movieratingteam3 "
            										  + "WHERE movieId = ? AND userId = ? ");  
            ps.setInt(1, movieId);  
            ps.setInt(2, userId);
            
            //System.out.println(ps.toString());
            
            ResultSet rs = ps.executeQuery();  
            
            if(rs.next()){  
                mr.setMovieId(rs.getInt(1));  
                mr.setUserId(rs.getInt(2)); 
                mr.setRating(rs.getInt(3));  
            }  
            con.close();  
        }
        catch(Exception ex){
        	ex.printStackTrace();
    	}  
          
        return mr;  
	}
	
}
