package team02.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import team02.notice.NoticeDTO;
import team02.member.Connect;

public class NoticeDAO extends Connect{
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	public void insertNotice(NoticeDTO dto) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = dto.getNum();

		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from notice");
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1) + 1; // max(최대값)에 +1해줌
			else
				number = 1; // 글이 하나도 없을 때에는 1번
			sql = "insert into notice values(notice_seq.NEXTVAL, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getReadcount());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public String selectNo(String nic) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String writer = null; // writer 값을 저장할 변수

		try {
			conn = getConnection();
			String sql = "select nic FROM notice WHERE id = 'admin'";
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
	
	public List getNotice() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from notice  order by reg_date desc");

			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeList = new ArrayList();
				do {
					NoticeDTO dto = new NoticeDTO();
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
	public int getNoticeCount() throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int x = 0;
	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("select count(*) from notice where writer='admin'");
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

}
