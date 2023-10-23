package team02.location.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;

public class LocationLandDAO extends OracleDB {

	private static LocationLandDAO instance = new LocationLandDAO();

	public static LocationLandDAO getInstance() {
		return instance;
	}

	private LocationLandDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<HashMap<String, String>> selectAreaCode() {
		ArrayList<HashMap<String, String>> areaCodeList = new ArrayList<HashMap<String, String>>();

		conn = getConnection();
		try {
			String sql = " select distinct areacode, areacodename from landinfo order by cast(areacode as number(10)) asc ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> areaMap = new HashMap<String, String>();
				areaMap.put("code", rs.getString("areacode"));
				areaMap.put("name", rs.getString("areacodename"));
				areaCodeList.add(areaMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return areaCodeList;
	}

	public ArrayList<HashMap<String, String>> selectSigunguCode(String areacode) {
		ArrayList<HashMap<String, String>> sigunguCodeList = new ArrayList<HashMap<String, String>>();

		conn = getConnection();
		try {
			String sql = " select distinct sigungucode, sigungucodename from landinfo where areacode = ? order by cast(SigunguCode as number(10)) asc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areacode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> areaMap = new HashMap<String, String>();
				areaMap.put("code", rs.getString("sigungucode"));
				areaMap.put("name", rs.getString("sigungucodename"));
				sigunguCodeList.add(areaMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sigunguCodeList;
	}

	public int totalLand(String areacode, String sigunguCode) {
		int totalCnt = 0;

		conn = getConnection();
		try {
			String sql = " select count(*) from landinfo where areacode = ? and SigunguCode=? and firstimage is not null order by title asc; ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areacode);
			pstmt.setString(2, sigunguCode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return totalCnt;
	}

	public ArrayList<HashMap<String, String>> selectLand(String areaCode, String sigunguCode) {
		ArrayList<HashMap<String, String>> landList = new ArrayList<HashMap<String, String>>();

		conn = getConnection();
		try {
			String sql = " select contentid, title, firstimage, category, areacodename, sigungucodename from landinfo "
					+ " where areacode = ? and SigunguCode= ? and firstimage is not null order by title asc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areaCode);
			pstmt.setString(2, sigunguCode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> areaMap = new HashMap<String, String>();
				areaMap.put("contentid", rs.getString("contentid"));
				areaMap.put("title", rs.getString("title"));
				areaMap.put("firstimage", rs.getString("firstimage"));
				areaMap.put("category", rs.getString("category"));
				areaMap.put("areacodename", rs.getString("areacodename"));
				areaMap.put("sigungucodename", rs.getString("sigungucodename"));
				landList.add(areaMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return landList;
	}

}
