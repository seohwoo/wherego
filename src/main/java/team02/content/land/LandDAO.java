package team02.content.land;

import java.lang.reflect.Array;
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
			pstmt = conn.prepareStatement("insert into landreview values (landreview_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,sysdate,?)");
			pstmt.setString(1, land.getContentid());
			pstmt.setString(2, land.getId());
			pstmt.setInt(3, land.getStars());
			pstmt.setString(4, land.getReview());
			pstmt.setString(5, land.getImg1());
			pstmt.setString(6, land.getImg2());
			pstmt.setString(7, land.getImg3());
			pstmt.setString(8, land.getImg4());
			pstmt.setString(9, land.getImg5());
			pstmt.setString(10,"0");
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
		try {
			conn = getConnection();
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
	
	public int getReviewCount(String contentid) {
		int count = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(review) from landreview where contentid = ?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			
		
		return count;
	}
	
	public ArrayList<HashMap<String, String>> selectReviewInfo(String contentid){
		ArrayList<HashMap<String, String>> reviewInfo = new ArrayList<HashMap<String, String>>();
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from landreview where contentid = ? order by reg_date desc");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, String> reviewItem = new HashMap<String, String>();
				reviewItem.put("id", rs.getString("id"));
				reviewItem.put("stars", rs.getString("stars"));
				reviewItem.put("review", rs.getString("review"));
				reviewItem.put("img1", rs.getString("img1"));
				reviewItem.put("img2", rs.getString("img2"));
				reviewItem.put("img3", rs.getString("img3"));
				reviewItem.put("img4", rs.getString("img4"));
				reviewItem.put("img5", rs.getString("img5"));
				reviewItem.put("reg_date", rs.getString("reg_date"));
				reviewItem.put("reviewnum", rs.getString("reviewnum"));
				reviewInfo.add(reviewItem);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return reviewInfo;
	}
	
	public void insertReviewUp(String contentid, String id, int reviewnum){
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into reviewup values(?,?,?)");
			pstmt.setString(1, contentid);
			pstmt.setString(2, id);
			pstmt.setInt(3, reviewnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public ArrayList<String> selectReviewUpId (int reviewnum) {
		ArrayList<String> ReviewUpIdList = new ArrayList<String>();
		conn = getConnection();
		try {
			pstmt = conn.prepareStatement("select id from reviewup where reviewnum = ?");
			pstmt.setInt(1, reviewnum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewUpIdList.add(rs.getString("id"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ReviewUpIdList;
	}
	
	public int getReviewUpCount(int reviewnum) {
		int count = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select likes from landreview where reviewnum = ?");
			pstmt.setInt(1, reviewnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			
		
		return count;
	}
	
	public void updateReviewCount(String id){
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update member set total=total+1 where id = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public void updateReviewLikes(int reviewnum){
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update landreview set likes = likes+1 where reviewnum = ?");
			pstmt.setInt(1, reviewnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	
	public int getLandSaveCount(int contentid) {
		int count = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(id) from landsave where contentid = ?");
			pstmt.setInt(1, contentid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
		return count;
	}
	
	public String getReviewNic(String id) {
		String Nic = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select nic from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Nic = rs.getString(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			
		
		return Nic;
	}
	
	public String getReviewGrade(String id) {
		String Grade = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select grade from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Grade = rs.getString(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			
		
		return Grade;
	}
	
	public String getReviewGradeName(String grade) {
		String GradeName = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select gradename from membergrade where gradenum = ?");
			pstmt.setString(1, grade);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				GradeName = rs.getString(1);
			}
		}
			catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			
		
		return GradeName;
	}
	
	
}

