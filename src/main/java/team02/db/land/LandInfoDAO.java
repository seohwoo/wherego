package team02.db.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			String firstImage, String cat1, String cat2, String cat3) throws Exception {

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"insert into landinfo(CONTENTID, AREACODE, SIGUNGUCODE, TITLE, ADDR1, FIRSTIMAGE, CAT1, CAT2, CAT3) values (?,?,?,?,?,?,?,?,?)");
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

}
