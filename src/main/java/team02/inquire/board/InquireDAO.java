package team02.inquire.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import team02.db.land.OracleDB;

public class InquireDAO extends OracleDB {

	private static InquireDAO instance = new InquireDAO();

	public static InquireDAO getInstance() {
		return instance;
	}

	private InquireDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int getInquireCount() {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = "select count(*) from askboard where boardnum=0 ";
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

	public ArrayList<InquireDTO> findInquireList(int start, int end) {
		ArrayList<InquireDTO> inquireList = new ArrayList<InquireDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select inquire.* , rownum r from "
					+ " (select * from askboard order by reg_date desc ) inquire) where r >=? and r <=? and boardnum=0 ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquireDTO dto = new InquireDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setBoardnum(rs.getInt("boardnum"));
				inquireList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return inquireList;
	}

	public void insertInquireBoard(InquireDTO dto) {
		conn = getConnection();
		try {
			String sql = "insert into askboard(num, id, writer, title, content, reg_date, ref, boardnum) "
					+ "values(askboard_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?, ?)";
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

	public InquireDTO findInquireContent(int num) {
		String sql = "";
		InquireDTO dto = new InquireDTO();
		conn = getConnection();
		try {
			sql = " update askboard set readcount=readcount+1 where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			sql = " select * from askboard where num = ? ";
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
				dto.setBoardnum(rs.getInt("boardnum"));
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
			if (rs.next()) {
				grade = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return grade;
	}

	public int inquireReCnt(int boardnum) {
		int reCnt = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from askboard where boardnum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				reCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return reCnt;
	}

	public ArrayList<InquireDTO> findInquireReList(int num) {
		ArrayList<InquireDTO> inquireList = new ArrayList<InquireDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select inquire.* , rownum r from "
					+ " (select * from askboard order by reg_date desc ) inquire) where boardnum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquireDTO dto = new InquireDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef(rs.getInt("boardnum"));
				inquireList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return inquireList;
	}

	public int getMyInquireCount(String id) {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = "select count(*) from askboard where boardnum=0 and id = ? ";
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

	public ArrayList<InquireDTO> findMyInquireList(String id, int start, int end) {
		ArrayList<InquireDTO> inquireList = new ArrayList<InquireDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select inquire.* , rownum r from "
					+ " (select * from askboard order by reg_date desc ) inquire) where r >=? and r <=? and boardnum=0 and id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquireDTO dto = new InquireDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef(rs.getInt("boardnum"));
				inquireList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return inquireList;
	}

	public InquireDTO findPostToNum(int num) {
		InquireDTO dto = new InquireDTO();
		conn = getConnection();
		try {
			String sql = " select * from askboard where num=? ";
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
				dto.setRef(rs.getInt("boardnum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}

	public void updateInquirePost(InquireDTO dto) {
		conn = getConnection();
		try {
			String sql = "update askboard set writer=?,title=?,content=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getNum());
			pstmt.executeUpdate();
			rs = pstmt.executeQuery();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public void deleteInquirePost(int num) {
		conn = getConnection();
		String sql = "";
		try {
			sql = " select num from askboard where boardnum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			sql = " delete from askboard where num = ? ";
			while (rs.next()) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("num"));
				pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

}
