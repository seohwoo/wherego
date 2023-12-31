package team02.admin.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;

public class AdminMemberDAO extends OracleDB {
	private static AdminMemberDAO instance = new AdminMemberDAO();

	public static AdminMemberDAO getInstance() {
		return instance;
	}

	private AdminMemberDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<AdminMemberDTO> selectCleanMember(int start, int end) {
		ArrayList<AdminMemberDTO> memberList = new ArrayList<AdminMemberDTO>();

		conn = getConnection();
		try {

			String sql = " select * from (select mem.*, rownum as r from "
					+ " (select * from member where grade>=2 and grade<=99 order by grade desc, reg_date desc) mem ) where r>=? and r<=? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminMemberDTO dto = new AdminMemberDTO();
				dto.setId(rs.getString("id"));
				dto.setNic(rs.getString("nic"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setGrade(rs.getInt("grade"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return memberList;
	}

	public int cleanMemberCnt() {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from member where grade>=2 and grade<=99";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return cnt;
	}

	public ArrayList<AdminMemberDTO> selectDirtyMember(int start, int end) {
		ArrayList<AdminMemberDTO> memberList = new ArrayList<AdminMemberDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select mem.*, rownum as r from "
					+ " (select * from member where grade>=0 and grade<=1 order by grade de"
					+ "sc, reg_date desc) mem ) where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminMemberDTO dto = new AdminMemberDTO();
				dto.setId(rs.getString("id"));
				dto.setNic(rs.getString("nic"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setGrade(rs.getInt("grade"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return memberList;
	}

	public int dirtyMemberCnt() {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from member where grade>=0 and grade<=1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return cnt;
	}

	public String findGradeName(int grade) {
		String gradeName = "";
		conn = getConnection();
		try {
			String sql = " select gradename from membergrade where gradeNum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				gradeName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return gradeName;
	}

	public AdminMemberDTO userInfo(String id) {
		AdminMemberDTO dto = new AdminMemberDTO();
		conn = getConnection();
		String sql = "";
		try {
			sql = " select * from member where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNic(rs.getString("nic"));
				dto.setBirth(rs.getString("birth"));
				dto.setGender(rs.getString("gender"));
				dto.setAddress(rs.getString("address"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setGrade(rs.getInt("grade"));
				dto.setTotal(rs.getInt("total"));
				dto.setProfile(rs.getString("profile"));
				dto.setReg_date(rs.getString("reg_date"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return dto;
	}

	public ArrayList<AdminReviewDTO> findUserReviews(String id) {
		ArrayList<AdminReviewDTO> reviewList = new ArrayList<AdminReviewDTO>();
		conn = getConnection();
		String sql = "";
		int cnt = 0;
		ResultSet rsLandInfo = null;
		try {
			sql = " select count(*) from landreview where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
			if (cnt > 0) {
				sql = " select * from landreview where id=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					AdminReviewDTO dto = new AdminReviewDTO();
					dto.setReviewnum(rs.getInt("reviewnum"));
					dto.setContentid(rs.getString("contentid"));
					dto.setStars(rs.getInt("stars"));
					dto.setReview(rs.getString("review"));
					dto.setImg1(rs.getString("img1"));
					dto.setImg2(rs.getString("img2"));
					dto.setImg3(rs.getString("img3"));
					dto.setImg4(rs.getString("img4"));
					dto.setImg5(rs.getString("img5"));
					dto.setReg_date_R(rs.getString("reg_date"));
					dto.setLikes(rs.getInt("likes"));
					sql = " select firstimage, title, areacodename, sigungucodename,category from landinfo where contentid=? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getContentid());
					rsLandInfo = pstmt.executeQuery();
					if (rsLandInfo.next()) {
						dto.setTitle(rsLandInfo.getString("title"));
						dto.setFirstimage(rsLandInfo.getString("firstimage"));
						dto.setAreacodename(rsLandInfo.getString("areacodename"));
						dto.setSigungucodename(rsLandInfo.getString("sigungucodename"));
						dto.setCategory(rsLandInfo.getString("category"));
					}
					reviewList.add(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rsLandInfo != null)
				try {
					rsLandInfo.close();
				} catch (SQLException ex) {
				}
			close(rs, pstmt, conn);
		}
		return reviewList;
	}

	public void changeGrade(String id, int grade) {
		conn = getConnection();
		String sql = "";
		try {
			sql = " update member set grade=? where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public HashMap<String, String> selectUserInfo(String id, int grade) {
		HashMap<String, String> userInfoMap = new HashMap<String, String>();
		conn = getConnection();
		String sql = "";
		try {
			sql = " select nic from member where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userInfoMap.put("nic", rs.getString("nic"));
			}
			sql = " select gradename from membergrade where gradeNum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userInfoMap.put("gradename", rs.getString("gradename"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return userInfoMap;
	}

	public void insertUserBan(String id, int grade, String content) {
		conn = getConnection();
		try {
			String sql = "insert into userbaninfo values(?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, grade);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public void deleteUserBan(String id) {
		conn = getConnection();
		try {
			String sql = "delete from userbaninfo where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public int isAdmin(String id) {
		int result = 0;
		conn = getConnection();
		try {
			String sql = " select grade from member where id =? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return result;
	}

	public int reviewCnt(String id) {
		int result = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from landreview where id =? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return result;
	}

}
