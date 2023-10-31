package team02.mag;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

   // 글쓴 후 db 넣기
   public void insertArticle(MagDTO mag) {   
         try {
            conn = getConnection(); 
            sql = "insert into mag (num, id, subject, content, firstimage, reg_date) values (mag_seq.NEXTVAL,?,?,?,?,sysdate)";
            pstmt = conn.prepareStatement(sql);         
            pstmt.setString(1, mag.getId());
            pstmt.setString(2, mag.getSubject());
            pstmt.setString(3, mag.getContent());
            pstmt.setString(4, mag.getFirstimage());
            pstmt.executeUpdate();
         } catch(Exception e) {
            e.printStackTrace();
         } finally {
            close(rs, pstmt, conn);
         }
      }
   
   // 메거진 갯수 count 메소드
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
         sql="select * from (select b.* , rownum r from  (select * from mag order by num asc) b)  where r >= ? and r <= ?";
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

   public MagDTO updateGetArticle(int num) throws Exception {
		MagDTO mag=null;
		try {
			conn = getConnection();
			sql = "select * from mag where num = ?";
			pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mag = new MagDTO();
				mag.setNum(rs.getInt("num"));
				mag.setId(rs.getString("id"));
				mag.setNic(rs.getString("nic"));
	            mag.setSubject(rs.getString("subject"));
	            mag.setContent(rs.getString("content"));
	            mag.setFirstimage(rs.getString("firstimage"));
	            mag.setReg_date(rs.getString("reg_date"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return mag;
	}
   
   public void updateArticle(MagDTO mag) {
		try {
			conn = getConnection();
			sql = "select * from mag where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mag.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){		
				sql="update mag set subject=?, content=? where num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mag.getSubject());
				pstmt.setString(2, mag.getContent());
				pstmt.setInt(3, mag.getNum());
				pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
   

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
            mag.setSubject(rs.getString("subject"));
            mag.setContent(rs.getString("content"));
            mag.setFirstimage(rs.getString("firstimage"));
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