package team02.main.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
				sql = " select * from (select search.*, rownum as r from (SELECT * FROM landinfo WHERE title LIKE ? and firstimage is not null) search ) where r>=? and r<=? ";
			} else {
				sql = " select * from (select search.*, rownum as r from (SELECT * FROM landinfo WHERE addr1 LIKE ? and firstimage is not null) search ) where r>=? and r<=? ";
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

}
