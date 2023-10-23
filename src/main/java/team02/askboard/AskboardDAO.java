package team02.askboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import team02.db.land.OracleDB;



public class AskboardDAO extends OracleDB {
	private static AskboardDAO instance = new AskboardDAO();

	public static AskboardDAO getInstance() {
		return instance;
	}
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//문의 삽입
	public void insertAsk(AskboardDTO dto){
		int num = dto.getNum();
		int ref = dto.getRef();
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select max(num) from askboard";
			pstmt = conn.prepareStatement(sql);
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
			sql = "insert into askboard values(askboard_seq.NEXTVAL,?, ?, ?, ?, sysdate, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getReadcount());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	//member2 DB에서 nic받아오기
	public String select(String nic) {
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

	//문의 리스트 askList
	public ArrayList<AskboardDTO>getAsk(int start, int end){
		String sql = "";
		ArrayList<AskboardDTO> askList = null;
		try {
			conn = getConnection();
			sql = "select * from " + " (select b.* , rownum r from "
					+ " (select * from askboard order by ref desc, re_step asc ) b) " + " where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				askList = new ArrayList(end);
				do {
					AskboardDTO dto = new AskboardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
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

	public int getAskCount(){
		String sql ="";
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from askboard";
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
	
	//나의 문의 리스트 askMyList.jsp
	public ArrayList<AskboardDTO> getMyAsk(String id, int start, int end) {
		String sql = "";
		ArrayList<AskboardDTO> myaskList = null;
		try {
			conn = getConnection();
			sql = "select * from " + " (select b.* , rownum r from "
					+ " (select * from askboard order by ref desc, re_step asc ) b) " + " where id = ? and r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				myaskList = new ArrayList();
				do {
					AskboardDTO dto = new AskboardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
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


	public int getMyAskCount(String writer) throws Exception {
		String sql ="";
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from askboard where id=?";
			pstmt = conn.prepareStatement(sql);
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

	//content.jsp (내용 보기)
	public AskboardDTO getAsking(int num){
		String sql ="";
		AskboardDTO dto = null;
		try {
			conn = getConnection();
			sql =  "update askboard set readcount=readcount+1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			sql = "select * from askboard where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new AskboardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
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

	public String getWriter(int num){
		String sql = "";
		String result = null;
		try {
			conn = getConnection();
			sql = "select count(*) from askboard where ref=(select ref from askboard where num=?)and re_step = 0";
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
	
	public AskboardDTO updateGetAsk(int num) {
		String sql = "";
		AskboardDTO dto=null;
		try {
			conn = getConnection();
			sql = "select * from askboard where num = ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new AskboardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}

	public int updateAsk(AskboardDTO dto) {
		String sql = "";
		int x=-1;
		try {
			conn = getConnection();
			sql = "update askboard set writer=?,title=?,content=? where num=?";
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
	
	public int deleteAsk(int num){
		String sql = "";
		int x=-1;
		try {
			conn = getConnection();
			sql = "delete from askboard where num=?";
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
