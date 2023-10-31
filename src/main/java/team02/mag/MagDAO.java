package team02.mag;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import team02.db.land.OracleDB;

public class MagDAO extends OracleDB {
   private static MagDAO instance = new MagDAO();
   public static MagDAO getInstance() {
      return instance;
   }
   
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String sql = "";

   public ArrayList getMagines(int start, int end) throws Exception {
	      ArrayList MagList = null;
	      
	      try {
	         sql="select * from (select b.* , rownum r from  (select * from mag landsave by reg_date asc) b)  where r >= ? and r <= ?";
	         conn = getConnection();
	         pstmt = conn.prepareStatement(sql);   
	         pstmt.setInt(1, start); 
	         pstmt.setInt(2, end); 
	         rs = pstmt.executeQuery();
	         
	         
	         if(rs.next()) {
	            MagList = new ArrayList();
	            do {
	               MagDTO mag = new MagDTO();
	               mag.setNum(rs.getInt("num"));
	               mag.setFirstimage(rs.getString("firstimage"));
	               mag.setId(rs.getString("id"));
	               mag.setNic(rs.getString("nic"));
	               mag.setSubject(rs.getString("subject"));
	               mag.setContent(rs.getString("content"));
	               mag.setReg_date(rs.getString("reg_date"));
	               MagList.add(mag);
	            }while(rs.next());
	         }
	   } catch (Exception e) {
	      e.printStackTrace();
	   }finally {
	      close(rs, pstmt, conn);
	   }
	      return MagList;
	   }
   
   
}