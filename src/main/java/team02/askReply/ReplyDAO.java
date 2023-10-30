package team02.askReply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import team02.db.land.OracleDB;
import team02.notice.NoticeDTO;

public class ReplyDAO extends OracleDB{
	private static ReplyDAO instance = new ReplyDAO();
	public static ReplyDAO getInstance() {
		return instance;
	}
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//댓글 작성
	public void insertReply(ReplyDTO dto){
		String sql = "";
		try {
			conn = getConnection();			//num boardnum id	writer	content	reg_date ref
			sql = "insert into askreply values(askreply_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBoardnum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getRef());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	//writer에 nic가져오기
	public String selectRe(String nic){
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
	
	//id grade 받아오기
		public int getGradeById(String memId) {
	        int grade = 0;
	        try {
	        	conn = getConnection();
	            String sql = "select grade from member where id = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, memId);
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                grade = rs.getInt("grade");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	close(rs, pstmt, conn);
	        }

	        return grade;
	    }
		
	//댓글리스트
	public ArrayList<ReplyDTO> getReply(int boardnum){
		String sql = "";
		ArrayList<ReplyDTO> replyList = null;
		try {
			conn = getConnection();
			sql = "select * from askreply where boardnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				replyList = new ArrayList();
				do {
					ReplyDTO dto = new ReplyDTO();
					dto.setNum(rs.getInt("num"));
					dto.setBoardnum(rs.getInt("boardnum"));
					dto.setId(rs.getString("id"));
					dto.setWriter(rs.getString("writer"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setRef(rs.getInt("ref"));
					replyList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return replyList;
	}
	
	public int getReplyCount(){
		String sql = "";
	    int x = 0;
	    try {
	        conn = getConnection();
	        sql = "select count(*) from askreply";
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
	
	public ReplyDTO getReContent(int num){
		String sql = "";
		ReplyDTO dto = null;
		try {
			conn = getConnection();
			sql = "select * from askreply where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ReplyDTO();
				dto.setNum(rs.getInt("num"));
				dto.setBoardnum(rs.getInt("boardnum"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setRef(rs.getInt("ref"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return dto;
	}
	//답변 삭제
		public int deleteReply(int num){
			String sql = "";
			int x=-1;
			try {
				conn = getConnection();
				sql = "delete from askreply where num=?";
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
	//답변 삭제
			public int UpdateReply(int num){
				String sql = "";
				int x=-1;
				try {
					conn = getConnection();
					sql = "update from askreply where num=?";
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
}