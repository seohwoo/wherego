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
			String sql = "select count(*) from banboard where boardnum=0 ";
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
					+ " (select * from banboard order by reg_date desc ) ban) where r >=? and r <=? and boardnum=0 ";
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
				dto.setRef(rs.getInt("boardnum"));
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
			String sql = "insert into banboard(num, id, writer, title, content, reg_date, ref, boardnum) values(banboard_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getRef());
			pstmt.setInt(6, dto.getBoardnum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public String isBanId(String id) {
		String banId = "";
		conn = getConnection();
		try {
			String sql = " select id from banboard where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				banId = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return banId;
	}
	
	public AdminBanDTO findBanContent(int num){
		String sql ="";
		AdminBanDTO dto = new AdminBanDTO();
		try {
			conn = getConnection();
			sql =  "update banboard set readcount=readcount+1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			sql = "select * from banboard where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public int isAdmin(String id) {
		int grade = 0;
		conn = getConnection();
		try {
			String sql = " select grade from member where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			close(rs, pstmt, conn);
		}
		return grade;
	}
	
	
	public int banReCnt(int boardnum) {
		int reCnt = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from banboard where boardnum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		
		
		return reCnt;
	}
	
	public ArrayList<AdminBanDTO> findBanReList(int num) {
		ArrayList<AdminBanDTO> banList = new ArrayList<AdminBanDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select ban.* , rownum r from "
					+ " (select * from banboard order by reg_date desc ) ban) where boardnum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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
				dto.setRef(rs.getInt("boardnum"));
				banList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return banList;
	}
	
	public int getMyBanCount(String id) {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = "select count(*) from banboard where boardnum=0 and id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	public ArrayList<AdminBanDTO> findMyBanList(String id, int Start, int end) {
		ArrayList<AdminBanDTO> banList = new ArrayList<AdminBanDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select ban.* , rownum r from "
					+ " (select * from banboard order by reg_date desc ) ban) where r >=? and r <=? and boardnum=0 and id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Start);
			pstmt.setInt(2, end);
			pstmt.setString(3, id);
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
				dto.setRef(rs.getInt("boardnum"));
				banList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return banList;
	}
	
	public AdminBanDTO findPostToNum(int num) {
		AdminBanDTO dto = new AdminBanDTO();
		conn = getConnection();
		try {
			String sql = " select * from banboard where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef(rs.getInt("boardnum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public void updateBanPost(AdminBanDTO dto) {
		conn = getConnection();
		try {
			String sql = "update banboard set writer=?,title=?,content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getNum());
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public void deleteBanPost(int num) {
		conn = getConnection();
		String sql = "";
		try {
			sql = " select num from banboard where boardnum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			sql = " delete from banboard where num = ? ";
			while(rs.next()) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("num"));
				pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
}
