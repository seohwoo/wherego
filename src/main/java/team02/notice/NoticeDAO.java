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
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//공지 삽입
	public void insertNotice(NoticeDTO dto){
		String sql = "";
		try {
			conn = getConnection();
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
	public String selectNo(String nic){
		String sql = "";
		String writer = null; // writer 값을 저장할 변수
		String id = null;
		try {
			conn = getConnection();
			sql = "select nic FROM member WHERE id = ?";
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
	public ArrayList<NoticeDTO> getNotice(int start, int end){
		String sql = "";
		ArrayList<NoticeDTO> noticeList = null;
		try {
			conn = getConnection();
			sql = "select * from " + " (select b.*, rownum r from"
					 +"(select * from notice order by num desc)b)"+" where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
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
	
	public int getNoticeCount(){
		String sql = "";
	    int x = 0;
	    try {
	        conn = getConnection();
	        sql = "select count(*) from notice";
	        pstmt = conn.prepareStatement(sql);
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
	
	//최신 공지 보기!
	public NoticeDTO getNewNotice(){
		String sql = "";
	    NoticeDTO latestNotice = null;
	    try {
	        conn = getConnection();
	        sql = "select * from notice order by num desc";
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            latestNotice = new NoticeDTO();
	            latestNotice.setNum(rs.getInt("num"));
	            latestNotice.setId(rs.getString("id"));
	            latestNotice.setWriter(rs.getString("writer"));
	            latestNotice.setTitle(rs.getString("title"));
	            latestNotice.setContent(rs.getString("content"));
	            latestNotice.setReg_date(rs.getTimestamp("reg_date"));
	            latestNotice.setReadcount(rs.getInt("readcount"));
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        close(rs, pstmt, conn);
	    }
	    return latestNotice;
	}

	
	//content.jsp (내용 보기)
		public NoticeDTO getNoContent(int num){
			String sql = "";
			NoticeDTO dto = null;
			try {
				conn = getConnection();
				sql = "update notice set readcount=readcount+1 where num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				sql = "select * from notice where num = ?";
				pstmt = conn.prepareStatement(sql);
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

		public String getAdmin(int num){
			String sql = "";
			String result = null;
			try {
				conn = getConnection();
				sql = "select * from notice where num=?";
				pstmt = conn.prepareStatement(sql);
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
		public int deleteNotice(int num){
			String sql = "";
			int x=-1;
			try {
				conn = getConnection();
				sql = "delete from notice where num=?";
				pstmt = conn.prepareStatement(sql);
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
		public int updateNotice(NoticeDTO dto){
			String sql ="";
			int x=-1;
			try {
				conn = getConnection();
				sql = "update notice set writer=?,title=?,content=? where num=?";
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
			return x;
		}
}
