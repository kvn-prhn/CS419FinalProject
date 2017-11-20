package team3;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountDao {
	
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
	
	public static int create(Account a) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "insert into account(firstName,lastName,password,email,address,subscriptionTier,hoursResetDate) values (?,?,?,?,?,?,?,?)");  
            ps.setString(1, a.getFirstName()); 
            ps.setString(2, a.getLastName());  
            ps.setString(3, a.getPassword());   
            ps.setString(4, a.getEmail());
            ps.setString(5, a.getAddress());
            ps.setInt(6, a.getSubscriptionTier());
            ps.setDate(7, a.getHoursResetDate());
              
            status = ps.executeUpdate();  
              
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static int update(Account a) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "update account set "
                         + "firstName=?, lastName=?, password=?, email=?, address=?, subscriptionTier=? "
                         + "where id=?");  
            ps.setString(1, a.getFirstName()); 
            ps.setString(2, a.getLastName());  
            ps.setString(3, a.getPassword());   
            ps.setString(4, a.getEmail());
            ps.setString(5, a.getAddress());
            ps.setInt(6, a.getSubscriptionTier());
            
            ps.setInt(7, a.getId());
              
            status = ps.executeUpdate();  
              
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static int delete(Account a) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "delete from account where id=?");  
            ps.setInt(1, a.getId());
              
            status = ps.executeUpdate();  
              
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static Account getAccountById(int accountId) {
		Account a = new Account();  
        
        try{  
            Connection con=DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement("select * from account where id=?");  
            ps.setInt(1, accountId);  
            
            ResultSet rs = ps.executeQuery();  
            
            if(rs.next()){  
                a.setId(rs.getInt(1));  
                a.setFirstName(rs.getString(2)); 
                a.setLastName(rs.getString(3));  
                a.setPassword(rs.getString(4));  
                a.setEmail(rs.getString(5));  
                a.setAddress(rs.getString(6));  
                a.setSubscriptionTier(rs.getInt(7));
                a.setHoursResetDate(rs.getDate(8));
                a.setHoursRemaining(rs.getFloat(9));
            }  
            con.close();  
        }
        catch(Exception ex){
        	ex.printStackTrace();
    	}  
          
        return a;  
	}
	
}