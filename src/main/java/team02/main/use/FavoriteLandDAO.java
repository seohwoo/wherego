package team02.main.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import team02.db.land.OracleDB;
import team02.location.land.LocationLandDTO;

public class FavoriteLandDAO extends OracleDB {

	private static FavoriteLandDAO instance = new FavoriteLandDAO();

	public static FavoriteLandDAO getInstance() {
		return instance;
	}

	private FavoriteLandDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<HashMap<String, String>> findFavoriteLandList() {
		ArrayList<HashMap<String, String>> favoriteLandList = new ArrayList<HashMap<String, String>>();

		conn = getConnection();
		try {
			String sql = " select * from (select cnt.* , rownum r from (select * from landreadcount order by readcount desc ) cnt) "
					+ " where r >=1 and r <=8 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, String> favoriteLandMap = new HashMap<String, String>();
				favoriteLandMap.put("contentid", rs.getString("contentid"));
				favoriteLandMap.put("readcount", rs.getString("readcount"));
				favoriteLandList.add(favoriteLandMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return favoriteLandList;
	}

	public LocationLandDTO selectLandToCid(String contentid) {
		LocationLandDTO dto = new LocationLandDTO();

		conn = getConnection();
		try {
			String sql = " select contentid, title, firstimage, category, areacodename, sigungucodename from landinfo where contentid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contentid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto.setContentid(rs.getString("contentid"));
				dto.setTitle(rs.getString("title"));
				dto.setFirstimage(rs.getString("firstimage"));
				dto.setCategory(rs.getString("category"));
				dto.setAreacodename(rs.getString("areacodename"));
				dto.setSigungucodename(rs.getString("sigungucodename"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return dto;
	}

}
