package team02.askboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import team02.member.Connect;

public class AskboardDAO extends Connect {
	private static AskboardDAO instance = new AskboardDAO();

	public static AskboardDAO getInstance() {
		return instance;

	}

	public void insertAsk(AskboardDTO dto) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = dto.getNum();
		int ref = dto.getRef();
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		int number = 0;
		// String id = null;
		// String pw = null;
		String sql = "";
		/*
		 * try { conn = getConnection(); pstmt =
		 * conn.prepareStatement("select id, pw from member; "); rs =
		 * pstmt.executeQuery(); if (rs.next()) { id = rs.getString("id"); pw =
		 * rs.getString("pw"); } if (id !=null && pw !=null) {
		 */
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from askboard");
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1) + 1; // max(최대값)에 +1해줌
			else
				number = 1; // 글이 하나도 없을 때에는 1번
			if (num != 0) {
				sql = "update askboard set re_step=re_step+1 where ref= ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			sql = "insert into askboard values(askboard_seq.NEXTVAL, ?, ?, ?, sysdate, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getReadcount());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public String select(String nic) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String writer = null; // writer 값을 저장할 변수

		try {
			conn = getConnection();
			String sql = "select nic FROM member2 WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nic);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				writer = rs.getString("nic");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return writer;
	}

	public List getAsk(int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List askList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from " + " (select b.* , rownum r from "
					+ " (select * from askboard order by ref desc, re_step asc ) b) " + " where r >= ? and r <= ? ");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				askList = new ArrayList(end);
				do {
					AskboardDTO dto = new AskboardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					askList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return askList;
	}

	public List getMyAsk(String writer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List myaskList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from askboard where writer =?");
			pstmt.setString(1, writer);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				myaskList = new ArrayList();
				do {
					AskboardDTO dto = new AskboardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					myaskList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return myaskList;
	}

	public List getNotice(String writer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice where writer ='admin'");
			pstmt.setString(1, writer);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeList = new ArrayList();
				do {
					AskboardDTO dto = new AskboardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
					noticeList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return noticeList;
	}

	public int getAskCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from askboard");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}

	public int getMyAskCount(String writer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from askboard where writer=?");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}

	public int getNoticeCount(String writer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice where writer='admin'");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}

	public AskboardDTO getAsking(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AskboardDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement( // 조회수
					"update askboard set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from askboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new AskboardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return dto;
	}

	public String getWriter(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from askboard where ref=(select ref from askboard where num=?)and re_step = 0");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return result;

	}
}
