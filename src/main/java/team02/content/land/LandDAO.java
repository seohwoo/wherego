package team02.content.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import team02.db.land.OracleDB;

public class LandDAO extends OracleDB {
	private static LandDAO instance = new LandDAO();

	public static LandDAO getInstance() {
		return instance;
	}

	private LandDAO() {
	}

	public void insertStar(LandDTO land) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into star values (?,?,?,?)");
			pstmt.setString(1, land.getContentid());
			pstmt.setString(2, land.getId());
			pstmt.setInt(3, land.getStars());
			pstmt.setString(4, land.getComments());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}
	}

	public double avgStar(String contentid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		double avg = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select round(avg(stars),1) from star where contentid =?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				avg = rs.getDouble(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}
		return avg;
	}

}
