package team02.db.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class LandInfoDAO extends OracleDB {

	private static LandInfoDAO instance = new LandInfoDAO();

	public static LandInfoDAO getInstance() {
		return instance;
	}

	private LandInfoDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public void insertFestival(String contentId, String areaCode, String sigunguCode, String title, String addr1,
			String firstImage, String cat1, String cat2, String cat3) {

		try {
			conn = getConnection();
			String sql = "insert into landinfo(CONTENTID, AREACODE, SIGUNGUCODE, TITLE, ADDR1, FIRSTIMAGE, CAT1, CAT2, CAT3) values (?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentId);
			pstmt.setString(2, areaCode);
			pstmt.setString(3, sigunguCode);
			pstmt.setString(4, title);
			pstmt.setString(5, addr1);
			pstmt.setString(6, firstImage);
			pstmt.setString(7, cat1);
			pstmt.setString(8, cat2);
			pstmt.setString(9, cat3);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	/*
	 * public ArrayList<String> selectContentId(String areaCode) { ArrayList<String>
	 * contentIdList = new ArrayList<String>();
	 * 
	 * try { conn = getConnection(); String sql =
	 * " select contentid from landinfo where areacode=? "; pstmt =
	 * conn.prepareStatement(sql); pstmt.setString(1, areaCode); rs =
	 * pstmt.executeQuery(); while (rs.next()) {
	 * contentIdList.add(rs.getString("contentid")); } } catch (Exception e) {
	 * e.printStackTrace(); } finally { close(rs, pstmt, conn); } return
	 * contentIdList; }
	 */

	public ArrayList<String> selectContentId(String areaCode, String sigunguCode) {
		ArrayList<String> contentIdList = new ArrayList<String>();

		try {
			conn = getConnection();
			String sql = " select contentid from landinfo where areacode=? and sigunguCode=? and firstimage is not null ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areaCode);
			pstmt.setString(2, sigunguCode);
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

	public ArrayList<String> selectNotContentId(String areaCode) {
		ArrayList<String> contentIdList = new ArrayList<String>();

		try {
			conn = getConnection();
			String sql = " select contentid from landinfo "
					+ " where homepage is null and overview is null and infocenter is null and restdate is null and usetime is null and parking is null and chkbabycarriage is null and chkpet is null and category is null and areacode = ? and firstimage is not null";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areaCode);
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

	public ArrayList<String> selectCategory(String contentid) {
		ArrayList<String> categoryList = new ArrayList<String>();

		try {
			conn = getConnection();
			String sql = " select cat1, cat2, cat3 from landinfo where contentid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				categoryList.add(rs.getString("cat1"));
				categoryList.add(rs.getString("cat2"));
				categoryList.add(rs.getString("cat3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return categoryList;
	}

	public void updateLand(String homepage, String overview, String infocenter, String restdate, String usetime,
			String parking, String chkbabycarriage, String chkpet, String category, String contentid) {

		try {
			conn = getConnection();
			String sql = " update landinfo set homepage = ? , overview = ?, infocenter = ?, restdate = ?, usetime = ?, parking = ?, chkbabycarriage = ?, chkpet = ?, category = ? where contentid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, homepage);
			pstmt.setString(2, overview);
			pstmt.setString(3, infocenter);
			pstmt.setString(4, restdate);
			pstmt.setString(5, usetime);
			pstmt.setString(6, parking);
			pstmt.setString(7, chkbabycarriage);
			pstmt.setString(8, chkpet);
			pstmt.setString(9, category);
			pstmt.setString(10, contentid);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}

	public ArrayList<String> selectContentid(String areaCode) {
		ArrayList<String> contentidList = new ArrayList<String>();

		conn = getConnection();
		try {
			String sql = " select contentid from landinfo where firstimage is not null and areacode=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areaCode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				contentidList.add(rs.getString("contentid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contentidList;
	}

	public void insertXY(String contentid, String mapx, String mapy, String areaCode, String sigunguCode) {

		conn = getConnection();
		try {
			String sql = " insert into landloc values(?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			pstmt.setString(2, mapx);
			pstmt.setString(3, mapy);
			pstmt.setString(4, areaCode);
			pstmt.setString(5, sigunguCode);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}