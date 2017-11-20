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
					.prepareStatement("insert into FavoritesList(movieId, userId, position) values (?,?,?)");
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
			PreparedStatement ps = con.prepareStatement("update favorites set movieId=? where userId=? and position=?");
			List<Integer> favoritesList = fl.getMovieIdList();
			for (int position = 0; position < favoritesList.size(); position++) {
				ps.setInt(1, favoritesList.get(position));
				ps.setInt(2, fl.getUserId());
				ps.setInt(3, position);
				status = (ps.executeUpdate() == 1 || status == 1) ? 1 : 0;
			}

			PreparedStatement psCleanUp = con.prepareStatement("delete from favorites where userId=? and position > ?");
			psCleanUp.setInt(fl.getUserId(), favoritesList.size() - 1);

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return status;
	}

	public static int delete(FavoritesList fl) {
		int status = 0;

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("delete from favorites where userId=?");
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
			PreparedStatement ps = con.prepareStatement("select * from favorites where userId=? order by position asc");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				favoritesList.add(rs.getInt(1));
			}
			fl.setMovieIdList(favoritesList);
			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return fl;
	}

}
