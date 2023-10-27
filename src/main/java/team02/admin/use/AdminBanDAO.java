package team02.admin.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import team02.db.land.OracleDB;

public class AdminBanDAO extends OracleDB {
	private static AdminBanDAO instance = new AdminBanDAO();

	public static AdminBanDAO getInstance() {
		return instance;
	}

	private AdminBanDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int getBanCount() {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = "select count(*) from banboard";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return cnt;
	}

	public ArrayList<AdminBanDTO> findBanList(int Start, int end) {
		ArrayList<AdminBanDTO> banList = new ArrayList<AdminBanDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select ban.* , rownum r from "
					+ " (select * from banboard order by ref desc ) ban) where r >=? and r <=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminBanDTO dto = new AdminBanDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				banList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return banList;
	}

	public void insertBanBoard(AdminBanDTO dto) {
		conn = getConnection();
		try {
			String sql = "insert into banboard(num, id, writer, title, content, reg_date, ref) values(banboard_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getRef());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

}
