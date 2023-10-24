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
		String sql = "";
		conn = getConnection();
		try {
			sql = " select count(*) from landsave where contentid=? and id=? ";
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
		SaveDTO dto = new SaveDTO();
		String sql = "";
		conn = getConnection();
		try {
			sql = " select title, firstimage, areacodename, sigungucodename, category "
					+ " from landinfo where contentid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setTitle(rs.getString("title"));
				dto.setFirstimage(rs.getString("firstimage"));
				dto.setAreacodename(rs.getString("areacodename"));
				dto.setSigungucodename(rs.getString("sigungucodename"));
				dto.setCategory(rs.getString("category"));
			}
			sql = " select round(avg(stars), 1) from star where contentid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setStars(rs.getInt(1));
			}
			sql = " select totalstars from landtotal where contentid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setTotalstars(rs.getInt("totalstars"));
			}
			sql = " insert into landsave values(?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getFirstimage());
			pstmt.setString(5, dto.getAreacodename());
			pstmt.setString(6, dto.getSigungucodename());
			pstmt.setString(7, dto.getCategory());
			pstmt.setDouble(8, dto.getStars());
			pstmt.setInt(9, dto.getTotalstars());
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
