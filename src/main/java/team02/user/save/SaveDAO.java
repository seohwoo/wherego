package team02.user.save;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import team02.db.land.OracleDB;

public class SaveDAO extends OracleDB {

	private static SaveDAO instance = new SaveDAO();

	public static SaveDAO getInstance() {
		return instance;
	}

	private SaveDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int isSave(String contentid, String id) {
		int count = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from landsave where contentid=? and id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return count;
	}

	public void insertSave(String contentid, String id) {
		conn = getConnection();
		try {
			String sql = " insert into landsave values(?, ?, sysdate) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public void deleteSave(String contentid, String id) {
		conn = getConnection();
		try {
			String sql = " delete from landsave where contentid=? and id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
