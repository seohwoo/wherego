package team02.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import team02.notice.NoticeDTO;
import team02.askboard.AskboardDTO;
import team02.db.land.OracleDB;

public class NoticeDAO extends OracleDB{
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	
	//공지 삽입
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
			sql = "insert into notice values(notice_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getReadcount());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	//write에 관리자명(nic) 가져오기
	public String selectNo(String nic) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String writer = null; // writer 값을 저장할 변수
		String id = null;
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
	public List getNotice(int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List noticeList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from " + " (select b.*, rownum r from"
					 +"(select * from notice order by num desc)b)"+" where r >= ? and r <= ? ");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeList = new ArrayList(end);
				do {
					NoticeDTO dto = new NoticeDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
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
	        pstmt = conn.prepareStatement("select count(*) from notice");
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
	
	//content.jsp (내용 보기)
		public NoticeDTO getNoContent(int num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			NoticeDTO dto = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement( // 조회수
						"update notice set readcount=readcount+1 where num = ?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement("select * from notice where num = ?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					dto = new NoticeDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setWriter(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}

			return dto;
		}

		public String getAdmin(int num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String result = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select * from notice where num=?");
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
		
		//공지삭제
		public int deleteNotice(int num) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs= null;
			int x=-1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("delete from notice where num=?");
				pstmt.setInt(1, num);
				x = pstmt.executeUpdate();
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			return x;
		}
		
		//공지 수정
		public int updateNotice(NoticeDTO dto) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs= null;
			int x=-1;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("update notice set writer=?,title=?,content=? where num=?");
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
			return x;
		}
}
