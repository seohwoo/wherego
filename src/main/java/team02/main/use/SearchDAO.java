package team02.main.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;
import team02.location.land.LocationLandDTO;

public class SearchDAO extends OracleDB {
	private static SearchDAO instance = new SearchDAO();

	public static SearchDAO getInstance() {
		return instance;
	}

	private SearchDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int totalSearchLand(String searchValue, String searchType) {
		int totalCnt = 0;
		String sql = "";
		conn = getConnection();
		try {
			String value = "%" + searchValue + "%";
			if (searchType.equals("land")) {
				sql = " SELECT count(*) FROM landinfo WHERE title LIKE ? and firstimage is not null ";
			} else {
				sql = " SELECT count(*) FROM landinfo WHERE addr1 LIKE ? and firstimage is not null ";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, value);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return totalCnt;
	}

	public ArrayList<LocationLandDTO> searchLand(String searchValue, String searchType, int start, int end) {
		ArrayList<LocationLandDTO> landList = new ArrayList<LocationLandDTO>();
		String sql = "";
		conn = getConnection();
		try {
			String value = "%" + searchValue + "%";
			if (searchType.equals("land")) {
				sql = " SELECT * FROM (SELECT li.*, COALESCE(lr.READCOUNT, 0) as READCOUNT, ROWNUM as r FROM landinfo "
						+ " li LEFT JOIN landreadcount lr ON li.CONTENTID = lr.CONTENTID "
						+ " WHERE li.TITLE LIKE ? AND li.FIRSTIMAGE IS NOT NULL ORDER BY READCOUNT DESC) WHERE r >= ? AND r <= ? ";
			} else {
				sql = " SELECT * FROM (SELECT li.*, COALESCE(lr.READCOUNT, 0) as READCOUNT, ROWNUM as r FROM landinfo "
						+ " li LEFT JOIN landreadcount lr ON li.CONTENTID = lr.CONTENTID "
						+ " WHERE li.addr1 LIKE ? AND li.FIRSTIMAGE IS NOT NULL ORDER BY READCOUNT DESC) WHERE r >= ? AND r <= ? ";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, value);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				LocationLandDTO dto = new LocationLandDTO();
				dto.setContentid(rs.getString("contentid"));
				dto.setTitle(rs.getString("title"));
				dto.setFirstimage(rs.getString("firstimage"));
				dto.setCategory(rs.getString("category"));
				dto.setAreacodename(rs.getString("areacode"));
				dto.setAreacodename(rs.getString("areacodename"));
				dto.setSigungucodename(rs.getString("sigungucode"));
				dto.setSigungucodename(rs.getString("sigungucodename"));
				landList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return landList;
	}

	public ArrayList<HashMap<String, String>> searchMap(String searchValue, String searchType) {
		ArrayList<HashMap<String, String>> landList = new ArrayList<HashMap<String, String>>();
		String sql = "";
		conn = getConnection();
		try {
			String value = "%" + searchValue + "%";
			if (searchType.equals("land")) {
				sql = " SELECT * FROM (SELECT li.*, COALESCE(lr.READCOUNT, 0) as READCOUNT FROM landinfo "
						+ " li LEFT JOIN landreadcount lr ON li.CONTENTID = lr.CONTENTID "
						+ " WHERE li.TITLE LIKE ? AND li.FIRSTIMAGE IS NOT NULL ORDER BY READCOUNT DESC) ";
			} else {
				sql = " SELECT * FROM (SELECT li.*, COALESCE(lr.READCOUNT, 0) as READCOUNT FROM landinfo "
						+ " li LEFT JOIN landreadcount lr ON li.CONTENTID = lr.CONTENTID "
						+ " WHERE li.addr1 LIKE ? AND li.FIRSTIMAGE IS NOT NULL ORDER BY READCOUNT DESC)";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, value);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> landMap = new HashMap<String, String>();
				landMap.put("contentid", rs.getString("contentid"));
				landMap.put("title", rs.getString("title"));
				landList.add(landMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return landList;
	}

	public HashMap<String, String> selectMapXY(String contentid) {
		HashMap<String, String> xyMap = new HashMap<String, String>();
		conn = getConnection();
		try {
			pstmt = conn.prepareStatement("select * from landloc where contentid = ?");
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				xyMap.put("mapx", rs.getString("mapx"));
				xyMap.put("mapy", rs.getString("mapy"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return xyMap;
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

}
