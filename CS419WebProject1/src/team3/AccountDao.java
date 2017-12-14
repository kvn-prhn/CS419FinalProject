package team3;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountDao {
	
	public static int create(Account a) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "insert into accountteam3 (firstName,lastName,password,email,address,subscription,resetDate,minutesRemaining,creditCardNum,cvv,CCEDate) " + 
                        		 "values (?,?,?,?,?,?,NOW(),?,?,?,?)");    // NOW() is temporary - set the date to today
            ps.setString(1, a.getFirstName()); 
            ps.setString(2, a.getLastName()); 
            ps.setString(3, a.getPassword());   
            ps.setString(4, a.getEmail());
            ps.setString(5, a.getAddress());
            ps.setInt(6, a.getSubscriptionTier());
            //ps.setDate(7, a.getHoursResetDate());
            ps.setInt(7, a.getMinutesRemaining());
            ps.setString(8, a.getCreditCardNum());
            ps.setString(9, a.getCVV());
            ps.setString(10, a.getCCEDate());
            status = ps.executeUpdate();  
            System.out.println("********Execution complete!!!");
            con.close();  
        }catch(Exception ex){ex.printStackTrace();}  
          
        return status;  
	}
	
	public static int update(Account a) {
		int status = 0;  
        try{  
            Connection con = DBLink.getConnection();  
            PreparedStatement ps = con.prepareStatement(  
                         "update accountteam3 set "
                         + "firstName=?, lastName=?, password=?, email=?, address=?, subscription=?,  "
                         + "resetDate=?, minutesRemaining=?, creditCardNum=?, cvv=?, CCEDate=? "  
                         + "where id=?");  
            ps.setString(1, a.getFirstName()); 
            ps.setString(2, a.getLastName());  
            ps.setString(3, a.getPassword());   
            ps.setString(4, a.getEmail());
            ps.setString(5, a.getAddress());
            ps.setInt(6, a.getSubscriptionTier());
            ps.setDate(7, a.getMinutesResetDate());
            ps.setInt(8, a.getMinutesRemaining());
            ps.setString(9, a.getCreditCardNum());
            ps.setString(10, a.getCVV());
            ps.setString(11, a.getCCEDate());
            ps.setInt(12, a.getId());
            System.out.println(ps);
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
                         "delete from accountteam3 where id=?");  
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
            PreparedStatement ps = con.prepareStatement("select * from accountteam3 where id=?");  
            ps.setInt(1, accountId);  
            
            ResultSet rs = ps.executeQuery();  
            
            if(rs.next()){  
                a.setId(rs.getInt(1));  
                a.setFirstName(rs.getString(2)); 
                a.setLastName(rs.getString(3));  
                a.setPassword(rs.getString(4));  
                a.setEmail(rs.getString(5));  
                a.setAddress(rs.getString(6));  
                a.setMinutesResetDate(rs.getDate(7));
                a.setMinutesRemaining(rs.getInt(8));
                a.setSubscriptionTier(rs.getInt(9));
                a.setCreditCardNum(rs.getString(10));
                a.setCVV(rs.getString(11));
                a.setCCEDate(rs.getString(12));
            }  
            con.close();  
        }
        catch(Exception ex){
        	ex.printStackTrace();
    	}  
          
        return a;  
	}
	
}
