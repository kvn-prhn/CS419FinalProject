package team3;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QueueDao {

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

	public static int create(Queue q) {
		int status = 0;
		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con
					.prepareStatement("insert into queue(movieID, userID, position) values (?,?,?)");
			List<Integer> Queue = q.getMovieIdList();
			for (int position = 0; position < Queue.size(); position++) {
				ps.setInt(1, Queue.get(position));
				ps.setInt(2, q.getUserId());
				ps.setInt(3, position);

				status = (ps.executeUpdate() == 1 || status == 1) ? 1 : 0;
			}

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return status;
	}

	public static int update(Queue q) {
		int status = 0;
		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("update queue set movieID=? where userID=? and position=?");
			List<Integer> Queue = q.getMovieIdList();
			for (int position = 0; position < Queue.size(); position++) {
				ps.setInt(1, Queue.get(position));
				ps.setInt(2, q.getUserId());
				ps.setInt(3, position);
				status = (ps.executeUpdate() == 1 || status == 1) ? 1 : 0;
			}

			PreparedStatement psCleanUp = con.prepareStatement("delete from queue where userID=? and position > ?");
			psCleanUp.setInt(q.getUserId(), Queue.size() - 1);

			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return status;
	}

	public static int delete(Queue q) {
		int status = 0;

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("delete from queue where userID=?");
			ps.setInt(1, q.getUserId());

			status = ps.executeUpdate();

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}

	public static Queue getQueueByUserId(int id) {
		Queue q = new Queue();
		q.setUserId(id);
		List<Integer> Queue = new ArrayList<Integer>();

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from queue where userID=? order by position asc");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Queue.add(rs.getInt(1));
			}
			q.setMovieIdList(Queue);
			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return q;
	}

}
