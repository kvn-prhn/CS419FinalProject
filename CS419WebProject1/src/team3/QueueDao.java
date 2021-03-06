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
					.prepareStatement("insert into queueteam3(movieID, userID, position) values (?,?,?)");
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
			
			PreparedStatement ifExists = con.prepareStatement("select * from queueteam3 where movieId = ? and userId = ?");
			PreparedStatement update = con.prepareStatement("update queueteam3 set position=? where movieId=? and userId=?");
			PreparedStatement insert = con.prepareStatement("insert into queueteam3(movieId, userId, position) values (?,?,?)");
			
			ResultSet rs;
			
			List<Integer> queue = q.getMovieIdList();
			
			for (int i = 0; i < queue.size(); i++) {
				ifExists.setInt(1, queue.get(i));
				ifExists.setInt(2, q.getUserId());
				rs = ifExists.executeQuery();
				if (rs.next()) {
					update.setInt(1, i);
					update.setInt(2, queue.get(i));
					update.setInt(3, q.getUserId());
					status = (update.executeUpdate() > 0) ? 0 : 1;
				}
				else {
					insert.setInt(1, queue.get(i));
					insert.setInt(2, q.getUserId());
					insert.setInt(3, i);
					status = (insert.executeUpdate() > 0) ? 0 : 1;
				}
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		System.out.println("QUEUE ADD: " + status);
		return status;
	}

	public static int delete(Queue q) {
		int status = 0;

		try {
			Connection con = DBLink.getConnection();
			PreparedStatement ps = con.prepareStatement("delete from queueteam3 where userID=?");
			ps.setInt(1, q.getUserId());

			status = (ps.executeUpdate() > 0) ? 0 : 1;

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
			PreparedStatement ps = con.prepareStatement("select * from queueteam3 where userID=? order by position asc");
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Queue.add(rs.getInt(1));
			}
			q.setMovieIdList(Queue);
			//con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return q;
	}

}