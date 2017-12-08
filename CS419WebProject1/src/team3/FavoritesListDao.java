package team3;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FavoritesListDao {

	/*
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/sakila?useSSL=false", "root", "sesame");
		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
	*/

	public static int create(FavoritesList fl) {
		int status = 0;
		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into favoriteteam3(movieId, userId, position) values (?,?,?)");
			List<Integer> favoritesList = fl.getMovieIdList();
			for (int position = 0; position < favoritesList.size(); position++) {
				ps.setInt(1, favoritesList.get(position));
				ps.setInt(2, fl.getUserId());
				ps.setInt(3, position);

				status = (ps.executeUpdate() == 1 || status == 1) ? 1 : 0;
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return status;
	}

	public static int update(FavoritesList fl) {
		int status = 0;
		try {
			Connection con = DBLink.getConnection();
			
			PreparedStatement ifExists = con.prepareStatement("select * from favoriteteam3 where movieId = ? and userId = ?");
			PreparedStatement update = con.prepareStatement("update favoriteteam3 set position=? where movieId=? and userId=?");
			PreparedStatement insert = con.prepareStatement("insert into favoriteteam3(movieId, userId, position) values (?,?,?)");
			
			ResultSet rs;
			
			List<Integer> favoritesList = fl.getMovieIdList();
			
			for (int i = 0; i < favoritesList.size(); i++) {
				ifExists.setInt(1, favoritesList.get(i));
				ifExists.setInt(2, fl.getUserId());
				rs = ifExists.executeQuery();
				if (rs.next()) {
					//System.out.println("UPDATING FL");
					update.setInt(1, i);
					update.setInt(2, favoritesList.get(i));
					update.setInt(3, fl.getUserId());
					status = (update.executeUpdate() == 1 || status == 1) ? 1 : 0;
				}
				else {
					//System.out.println("INSERTING INTO FL");
					insert.setInt(1, favoritesList.get(i));
					insert.setInt(2, fl.getUserId());
					insert.setInt(3, i);
					insert.executeUpdate();
				}
			}

			
			/*PreparedStatement psCleanUp = con.prepareStatement("delete from favoriteteam3 where userId=? and position > ?");
			if (favoritesList.size() > 0) {
				psCleanUp.setInt(1, fl.getUserId());
				psCleanUp.setInt(2, favoritesList.size()-1);
				psCleanUp.executeUpdate();
			}
			
			con.close();
			*/
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return status;
	}

	public static int delete(FavoritesList fl) {
		int status = 0;

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("delete from favoriteteam3 where userId=?");
			ps.setInt(1, fl.getUserId());

			status = ps.executeUpdate();

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}

	public static FavoritesList getFavoritesListByUserId(int id) {
		FavoritesList fl = new FavoritesList();
		fl.setUserId(id);
		List<Integer> favoritesList = new ArrayList<Integer>();

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("select movieId from favoriteteam3 where userId=? order by position asc");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				favoritesList.add(rs.getInt(1));
			}
			fl.setMovieIdList(favoritesList);
			//con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return fl;
	}

}
