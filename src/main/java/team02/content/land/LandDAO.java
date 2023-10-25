package team02.content.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;

public class LandDAO extends OracleDB {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	private static LandDAO instance = new LandDAO();

	public static LandDAO getInstance() {
		return instance;
	}

	private LandDAO() {
	}

	public void insertStar(LandDTO land) throws Exception {
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into landreview values (?,?,?,?,?,?,?,?,?,sysdate,?)");
			pstmt.setString(1, land.getContentid());
			pstmt.setString(2, land.getId());
			pstmt.setInt(3, land.getStars());
			pstmt.setString(4, land.getReview());
			pstmt.setString(5, land.getImg1());
			pstmt.setString(6, land.getImg2());
			pstmt.setString(7, land.getImg3());
			pstmt.setString(8, land.getImg4());
			pstmt.setString(9, land.getImg5());
			pstmt.setString(10, land.getLikes());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public double avgStar(String contentid) {
		double avg = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select round(avg(stars),1) from landreview where contentid =?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				avg = rs.getDouble(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return avg;
	}
	public HashMap<String, String> selectContentRandInfo(String contentId) {
		HashMap<String, String> contentRandInfoMap = new HashMap<String, String>();

		conn = getConnection();
		try {
			pstmt = conn.prepareStatement("select * from landinfo where contentid = ?");
			pstmt.setString(1, contentId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				contentRandInfoMap.put("title", rs.getString("title"));
				contentRandInfoMap.put("firstimage", rs.getString("firstimage"));
				contentRandInfoMap.put("homepage", rs.getString("homepage"));
				contentRandInfoMap.put("addr1", rs.getString("addr1"));
				contentRandInfoMap.put("overview", rs.getString("overview"));
				contentRandInfoMap.put("category", rs.getString("category"));
				contentRandInfoMap.put("infocenter", rs.getString("infocenter"));
				contentRandInfoMap.put("restdate", rs.getString("restdate"));
				contentRandInfoMap.put("usetime", rs.getString("usetime"));
				contentRandInfoMap.put("parking", rs.getString("parking"));
				contentRandInfoMap.put("chkbabycarriage", rs.getString("chkbabycarriage"));
				contentRandInfoMap.put("chkpet", rs.getString("chkpet"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return contentRandInfoMap;
	}
	
	public void insertReadCountNewContentId(String contentId){
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into landReadCount values (?,0)");
			pstmt.setString(1, contentId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public void updateReadCount(String contentId){
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update landreadcount set readcount=readcount+1 where contentid = ?");
			pstmt.setString(1, contentId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public int getReadCount(String contentid) {
		int readCount = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select readcount from landreadcount where contentid = ?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				readCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return readCount;
	}
	
	public int contentIdChk(String contentid) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from landReadCount where contentid = ?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
			else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	
}
