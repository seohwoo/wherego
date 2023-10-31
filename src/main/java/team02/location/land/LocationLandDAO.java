package team02.location.land;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

	public ArrayList<LocationLandDTO> selectAreaCode() {
		ArrayList<LocationLandDTO> areaCodeList = new ArrayList<LocationLandDTO>();

		conn = getConnection();
		try {
			String sql = " select distinct areacode, areacodename from landinfo order by cast(areacode as number(10)) asc ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				LocationLandDTO areaDTO = new LocationLandDTO();
				areaDTO.setAreacode(rs.getString("areacode"));
				areaDTO.setAreacodename(rs.getString("areacodename"));
				areaCodeList.add(areaDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return areaCodeList;
	}

	public ArrayList<LocationLandDTO> selectSigunguCode(String areacode) {
		ArrayList<LocationLandDTO> sigunguCodeList = new ArrayList<LocationLandDTO>();

		conn = getConnection();
		try {
			String sql = " select distinct sigungucode, sigungucodename from landinfo where areacode = ? order by cast(SigunguCode as number(10)) asc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areacode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				LocationLandDTO dto = new LocationLandDTO();
				dto.setSigunguCode(rs.getString("sigungucode"));
				dto.setSigungucodename(rs.getString("sigungucodename"));
				sigunguCodeList.add(dto);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return sigunguCodeList;
	}

	public int totalLand(String areacode, String sigunguCode) {
		int totalCnt = 0;

		conn = getConnection();
		try {
			String sql = " select count(*) from landinfo where areacode = ? and SigunguCode=? and firstimage is not null order by title asc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areacode);
			pstmt.setString(2, sigunguCode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}

		return totalCnt;
	}

	public ArrayList<LocationLandDTO> selectLand(String areaCode, String sigunguCode, int start, int end) {
		ArrayList<LocationLandDTO> landList = new ArrayList<LocationLandDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select land.*, rownum as r "
					+ " from (select contentid, title, firstimage, category, areacodename, sigungucodename from landinfo where areacode =? and SigunguCode=? and firstimage is not null order by title asc) land ) "
					+ " where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, areaCode);
			pstmt.setString(2, sigunguCode);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				LocationLandDTO dto = new LocationLandDTO();
				dto.setContentid(rs.getString("contentid"));
				dto.setTitle(rs.getString("title"));
				dto.setFirstimage(rs.getString("firstimage"));
				dto.setCategory(rs.getString("category"));
				dto.setAreacodename(rs.getString("areacodename"));
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
	
	/*내가한거  세션으로  찜한 값 불러오기 sql*/
	   public LocationLandDTO mySaveList (String sid) throws Exception {
	      LocationLandDTO save= null; 
	      try{
	      conn = getConnection();
	      String sql = "select * from landsave where id=?";
	      pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, sid);
	        rs = pstmt.executeQuery();   
	      
	        if (rs.next()){
	        save = new LocationLandDTO();
	        save.setContentid(rs.getString("contentid"));
	        save.setTitle(rs.getString("title"));
	        save.setFirstimage(rs.getString("firstimage"));
	        save.setAreacodename(rs.getString("areacodename"));
	        save.setSigungucodename(rs.getString("sigungucodename"));
	        save.setCategory(rs.getString("category"));
	        }         
	      }catch (Exception e){
	         e.printStackTrace();
	      }finally{
	         close(rs, pstmt, conn);
	         return save;
	      }
	   }
	   
	      /* 찜목록 카운트 만들기 */
	   public int getmypickpoint(String sid) throws Exception {
	      int x= 0;
	      
	      try {
	         conn = getConnection();
	         String sql = "select count(*) from landsave WHERE id = ?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, sid); 
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	            x = rs.getInt(1);
	         }
	      }catch (Exception e){
	         e.printStackTrace();
	      }finally {
	         close(rs, pstmt, conn);
	      }
	      return x;       
	   }
	   
	         
	   public List getmypick(int stRow, int edRow, String sid) {
	      List mypicklist = new ArrayList();
	      
	      try {
	         conn = getConnection();
	         String sql = "select * from "
	               + " (select b.* , rownum r from "
	               + " (select * from landsave order by contentid asc) b) "
	               + " where r >= ? and r <= ? and id = ?";               
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, stRow); 
	         pstmt.setInt(2, edRow); 
	         pstmt.setString(3, sid);
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	            mypicklist = new ArrayList(edRow); 
	            do{ 
	               LocationLandDTO mypk= new LocationLandDTO();
	               mypk.setContentid(rs.getString("contentid"));
	               mypk.setTitle(rs.getString("title"));
	               mypk.setFirstimage(rs.getString("firstimage"));
	               mypk.setAreacodename(rs.getString("areacodename"));
	               mypk.setSigungucodename(rs.getString("sigungucodename"));
	               mypk.setCategory(rs.getString("category"));
	               mypicklist.add(mypk); 
	            }while(rs.next());
	         }
	      }catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         close(rs, pstmt, conn);
	      }
	      return mypicklist;
	   }
		

}
