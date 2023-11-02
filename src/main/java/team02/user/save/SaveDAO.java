package team02.user.save;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;

public class SaveDAO extends OracleDB {

	private static SaveDAO instance = new SaveDAO();

	public static SaveDAO getInstance() {
		return instance;
	}

	private SaveDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int isSave(String contentid, String id) {
		int count = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from landsave where contentid=? and id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return count;
	}

	public void insertSave(String contentid, String id) {
		conn = getConnection();
		try {
			String sql = " insert into landsave values(?, ?, sysdate) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public void deleteSave(String contentid, String id) {
		conn = getConnection();
		try {
			String sql = " delete from landsave where contentid=? and id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 컨텐트아이디를 리스트화한것
	public ArrayList<String> getMyPickContentIdList(String user) {

		conn = getConnection();
		ArrayList<String> contentIdList = new ArrayList<String>();
		String sql = "select contentid from landsave where id =?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				contentIdList.add(rs.getString("contentid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return contentIdList;
	}
	
	// 어드민이 선택한거 리스트화하기 (메거진)
	public ArrayList<String> getAdminContentIdList(String id) {

		conn = getConnection();
		ArrayList<String> contentIdList = new ArrayList<String>();
		String sql = "select contentid from landsave where id ='admin'";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				contentIdList.add(rs.getString("contentid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return contentIdList;
	}
	

	// 리스트된 컨텐트 아이디로 필요한 값들을 불러오는것
	// stars, landinfo, totalstar table 3개에서 정보 받아와서 dto에 담아서 리턴
	public HashMap<String, String> myPick(String contentid) {
		HashMap<String, String> myPickMap = new HashMap<String, String>();
		conn = getConnection();
		String sql = "";
		try {
			sql = "select * from landinfo where contentid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				myPickMap.put("areacodename", rs.getString("areacodename"));
				myPickMap.put("sigungucodename", rs.getString("sigungucodename"));
				myPickMap.put("title", rs.getString("title"));
				myPickMap.put("addr1", rs.getString("addr1"));
				myPickMap.put("firstimage", rs.getString("firstimage"));
				myPickMap.put("category", rs.getString("category"));
			}

			sql = "select round(avg(stars), 1) from landreview where contentid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				myPickMap.put("stars", rs.getString("round(avg(stars),1)"));
			}

			sql = "select * from landreadcount where contentid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				myPickMap.put("readcount", rs.getString("readcount"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return myPickMap;
	}

	// 찜목록 카운트 만들기

	public int getmypickpoint(String user) throws Exception {
		int x = 0;

		try {
			conn = getConnection();
			String sql = "select count(*) from landsave WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}
	
	// 어드민으로 메거진 찜목록 카운트 만들기

		public int getAdminCount() throws Exception {
			int x = 0;

			try {
				conn = getConnection();
				String sql = "select count(*) from landsave WHERE id = 'admin'";
				pstmt = conn.prepareStatement(sql);
			
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			return x;
		}
	
	

	// 리뷰쓴사람 컨텐츠아이디갑을 리스트화
	public ArrayList<String> getMyreviewContentIdList(String rid) {
		conn = getConnection();
		ArrayList<String> RcontentIdList = new ArrayList<String>();
		String sql = "select * from landreview where id =?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				RcontentIdList.add(rs.getString("contentid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return RcontentIdList;
	}

	// 리스트로된 컨텐트 아이디 만들어 리뷰 불러오기

	public ArrayList<HashMap<String, String>> myReviewList(String user) {
		ArrayList<HashMap<String, String>> myReviewList = new ArrayList<HashMap<String, String>>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from landreview where id=? order by  reg_date desc");
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> myReviewMap = new HashMap<String, String>();
				myReviewMap.put("stars", rs.getString("stars"));
				myReviewMap.put("review", rs.getString("review"));
				myReviewMap.put("img1", rs.getString("img1"));
				myReviewMap.put("img2", rs.getString("img2"));
				myReviewMap.put("img3", rs.getString("img3"));
				myReviewMap.put("img4", rs.getString("img4"));
				myReviewMap.put("img5", rs.getString("img5"));
				myReviewMap.put("reg_date", rs.getString("reg_date"));
				myReviewMap.put("contentid", rs.getString("contentid"));
				myReviewList.add(myReviewMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return myReviewList;
	}

	// 리뷰갯수
	public int getReviewCount(String rid) throws Exception {
		int x = 0;

		try {
			conn = getConnection();
			String sql = "select count(*) from landreview WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}

	public HashMap<String, String> selectReviewTitle(String contentid) {
		HashMap<String, String> myReviewTitleMap = new HashMap<String, String>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select title,firstimage from landinfo where contentid = ? ");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				myReviewTitleMap.put("title", rs.getString("title"));
				myReviewTitleMap.put("firstimage", rs.getString("firstimage"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return myReviewTitleMap;
	}

	public int getSaveCount(String contentid) {
		int x = 0;

		try {
			conn = getConnection();
			String sql = " select count(*) from landsave WHERE contentid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return x;
	}

}
