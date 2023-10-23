package team02.db.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

	public void insertSave(String contentid, String id, int save) {
		conn = getConnection();
		try {
			String sql = " insert into landsave values(?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.setInt(3, save);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public int selectSave(String contentid, String id) {
		int save = 0;
		conn = getConnection();

		try {
			String sql = " select issave from landsave where contentid=? and id=? ";
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				save = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return save;
	}

	public int isSave(String contentid, String id) {
		int count = 0;
		conn = getConnection();

		try {
			String sql = " select count(*) from landsave where contentid=? and id=? ";
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return count;
	}

	public void updateSave(String contentid, String id, int save) {
		conn = getConnection();
		try {
			String sql = " update landsave set save=? where contentid=? and id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, save);
			pstmt.setString(2, contentid);
			pstmt.setString(3, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

}
