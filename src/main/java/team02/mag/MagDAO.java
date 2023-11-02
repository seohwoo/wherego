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


    // 메거진 글 갯수
   public int getMagCount() throws Exception {
	   int x= 0;
	   
	   try{
		   sql="select count(*) from mag ";
		   conn = getConnection();
		   pstmt = conn.prepareStatement(sql);		 
		   rs = pstmt.executeQuery();
		   
		   if(rs.next()) {
			   x=rs.getInt(1);
		   }
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		close(rs, pstmt, conn);
	}
	   return x;
   }
   
 //메거진 내용 불러오는 메소드
   public ArrayList getMagines(int start, int end) throws Exception {
	   ArrayList MagList = null;
	   
	   try {
		   sql="select * from (select b.* , rownum r from  (select * from mag order by num desc) b)  where r >= ? and r <= ?";
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
				   mag.setId(rs.getString("id"));		
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
   
   
   // 메거진 글쓰기
   public void insertMag(MagDTO mag) {
	      try {
	         conn = getConnection();
	         sql = "insert into mag (num, contentid, id, subject, content, reg_date) values (mag_seq.NEXTVAL,?,?,?,?,sysdate)";
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, mag.getContentid());
	          pstmt.setString(2, mag.getId());
	          pstmt.setString(3, mag.getSubject());
	          pstmt.setString(4, mag.getContent());
	          pstmt.executeUpdate();
	      } catch(Exception e) {
	          e.printStackTrace();
	      } finally {
	         close(rs, pstmt, conn);
	      }
	  }
   
    
   //메거진 컨텐트  내용보기
   
   public MagDTO getmag(int num)throws Exception {
	   MagDTO mag = null;
	   sql="select * from mag where num = ?";
	   try {
		   conn = getConnection();
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setInt(1, num);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   mag = new MagDTO();
			   mag.setNum(rs.getInt("num"));
			   mag.setId(rs.getString("id"));
			   mag.setContentid(rs.getString("contentid"));
			   mag.setSubject(rs.getString("subject"));
			   mag.setContent(rs.getString("content"));			  
			   mag.setReg_date(rs.getString("reg_date"));			   
		   }		   		   
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		close(rs, pstmt, conn);
	}
	   return mag;
   }
   
   
}