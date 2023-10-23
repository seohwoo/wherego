package team02.content.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import team02.db.land.OracleDB;

public class LandDAO extends OracleDB {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	private static LandDAO instance = new LandDAO();

	public static LandDAO getInstance() {
		return instance;
	}

	private LandDAO() {
	}

	public void insertStar(LandDTO land) throws Exception {
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into landreview values (?,?,?,?,?,?,?,?,?,sysdate,?)");
			pstmt.setString(1, land.getContentid());
			pstmt.setString(2, land.getId());
			pstmt.setInt(3, land.getStars());
			pstmt.setString(4, land.getReview());
			pstmt.setString(5, land.getImg1());
			pstmt.setString(6, land.getImg2());
			pstmt.setString(7, land.getImg3());
			pstmt.setString(8, land.getImg4());
			pstmt.setString(9, land.getImg5());
			pstmt.setString(10, land.getLikes());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public double avgStar(String contentid) {
		double avg = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select round(avg(stars),1) from landreview where contentid =?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				avg = rs.getDouble(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return avg;
	}

}
