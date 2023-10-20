package team02.askreply;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import team02.db.land.OracleDB;

public class AskreplyDAO extends OracleDB{
	private static AskreplyDAO instance = new AskreplyDAO();
	public static AskreplyDAO getInstance() {
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//댓글 작성
	public void insertReply(AskreplyDTO dto) {
		
		int num = dto.getNum();
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select max(num) from askreply";
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1) + 1; // max(최대값)에 +1해줌
			else
				number = 1; // 댓글이 하나도 없을 때에는 1번
			sql = "insert into askreply values(askreply_seq.NEXTVAL, ?, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getBoardnum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getContent());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	//write에 관리자명(nic) 가져오기
	public String selectRe(String nic){
		String sql = "";
		String writer = null; // writer 값을 저장할 변수
		String id = null;
		try {
			conn = getConnection();
			sql = "select nic FROM member2 WHERE id = ?";
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
	
	//boardnum에 ask번호 가져오기
	public String selectNum(String num){
		String sql = "";
		String boardnum = null; // boardnum 값을 저장할 변수
		try {
			conn = getConnection();
			sql = "select num from askboard where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				boardnum = String.valueOf(rs.getInt("num"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return boardnum;
	}
	public ArrayList<AskreplyDTO> getReply(int start, int end){
		String sql = "";
		ArrayList<AskreplyDTO> replyList = null;
		try {
			conn = getConnection();
			sql = "select * from " + " (select b.*, rownum r from"
					 +"(select * from askreply order by num desc)b)"+" where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				replyList = new ArrayList(end);
				do {
					AskreplyDTO dto = new AskreplyDTO();
					dto.setNum(rs.getInt("num"));
					dto.setBoardnum("boardnum");
					dto.setId(rs.getString("id"));
					dto.setWriter(rs.getString("writer"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
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
	
	public int getReplyCount() {
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
	

	
		
		/*공지삭제
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
		}*/
}
