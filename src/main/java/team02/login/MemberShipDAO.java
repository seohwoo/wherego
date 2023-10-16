package team02.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import team02.login.MemberShipDTO;

public class MemberShipDAO extends Connect{
   private static MemberShipDAO instance = new MemberShipDAO();
   public static MemberShipDAO getInstance() {
      return instance;
   }
      private MemberShipDAO() {}
    
       
      public void insertMember(MemberShipDTO member)throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         
         try {
            conn = getConnection();
            pstmt = conn.prepareStatement(
            "insert into member values (?,?,?,?,?,?,?,?,?,sysdate)");
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPw());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getNic());
            pstmt.setString(5, member.getBirth());
            pstmt.setString(6, member.getGender());
            pstmt.setString(7, member.getAddress());
            pstmt.setString(8, member.getEmail());
            pstmt.setString(9, member.getPhone());
            pstmt.executeUpdate();
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
             if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
             if (conn != null) try { conn.close(); } catch(Exception e) {}
         }
      }
   
      
      
      public int confirmId(String id)  // 아이디 중복체크용
    			throws Exception {
    				Connection conn = null;
    		       PreparedStatement pstmt = null;
    				ResultSet rs= null;
    		       String dbpasswd="";
    				int x=-1;
    		       
    				try {
    					conn =getConnection();
    					
    					pstmt = conn.prepareStatement(
    							"select id from member where id=?");
    					pstmt.setString(1,id);
    					rs=pstmt.executeQuery();
    					
    					if(rs.next())
    						x=1;
    					else
    						x=-1;
    				} catch(Exception ex) {
    					ex.printStackTrace();
    				} finally {
    					if (rs != null) try { rs.close(); } catch(SQLException ex) {}
    			           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    			           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    			       }
    					return x;
    				}
    				
      public int confirmNIC(String nic)  // 닉네임 중복체크용
  			throws Exception {
  				Connection conn = null;
  		       PreparedStatement pstmt = null;
  				ResultSet rs= null;
  		       String dbpasswd="";
  				int x=-1;
  		       
  				try {
  					conn =getConnection();
  					
  					pstmt = conn.prepareStatement(
  							"select nic from member where nic=?");
  					pstmt.setString(4,nic);
  					rs=pstmt.executeQuery();
  					
  					if(rs.next())
  						x=1;
  					else
  						x=-1;
  				} catch(Exception ex) {
  					ex.printStackTrace();
  				} finally {
  					if (rs != null) try { rs.close(); } catch(SQLException ex) {}
  			           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
  			           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
  			       }
  					return x;
  				}

      public MemberShipDTO getMember(String id)  
    	throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          MemberShipDTO member=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from member where id = ?");
              pstmt.setString(1, id);
              rs = pstmt.executeQuery();
      
              if (rs.next()) {
            	member = new MemberShipDTO();
                member.setId(rs.getString("id"));
                member.setPw(rs.getString("pw"));
                member.setName(rs.getString("name"));
                member.setNic(rs.getString("nic"));
                member.setBirth(rs.getString("birth"));
                member.setGender(rs.getString("gender"));
                member.setAddress(rs.getString("address"));
   				member.setEmail(rs.getString("email"));
   				member.setPhone(rs.getString("phone"));
                member.setReg_date(rs.getTimestamp("reg_date"));  
   			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
   		return member;
      }
      
      
      
      public void updateMember(MemberShipDTO member)  // 회원 수정
      throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          try {conn = getConnection();
          
          pstmt = conn.prepareStatement(
            "update member set pw=?,name=?,nic=?,address=?,email=?,phone=? where id=?");
      
          pstmt.setString(1, member.getPw());
          pstmt.setString(2, member.getName());
          pstmt.setString(3, member.getNic());
          pstmt.setString(4, member.getAddress());
          pstmt.setString(5, member.getEmail());
          pstmt.setString(6, member.getPhone());
          pstmt.setString(7, member.getId());
      
          pstmt.executeUpdate();
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
      }
      
      public int userCheck(String id, String pw)   // 유저체크
              throws Exception {        
                    Connection conn = null;
                   PreparedStatement pstmt = null;
                 ResultSet rs= null;
                   String dbpw="";
                 int x=-1;
                  
                 try {
                      conn = getConnection();
                      pstmt = conn.prepareStatement(
                            "select pw from member  where id = ?");
                      pstmt.setString(1, id);
                      rs= pstmt.executeQuery();

                    if(rs.next()){
                       dbpw= rs.getString("pw"); 
                       if(dbpw.equals(pw))
                          x= 1; 
                       else
                          x= 0; 
                    }else
                       x= -1;
                    
                  } catch(Exception e) {
                      e.printStackTrace();
                  } finally {
                    if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                      if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
                      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
                  }
                 return x;
        }
        
        
        
        public int talMember(String id, String pw)  //탈퇴
              throws Exception {
                  Connection conn = null;
                  PreparedStatement pstmt = null;
                  ResultSet rs= null;
                  String dbpw="";
                  int x=-1;
                  try {
                    conn = getConnection();

                      pstmt = conn.prepareStatement(
                         "select pw from member where id = ?");
                      pstmt.setString(1, id);
                      rs = pstmt.executeQuery();
                      
                    if(rs.next()){
                       dbpw= rs.getString("pw"); 
                       if(dbpw.equals(pw)){
                          pstmt = conn.prepareStatement("delete from member where id=?");
                          pstmt.setString(1, id);
                          pstmt.executeUpdate();
                          x= 1; 
                       }else
                          x= 0; 
                    }
                  } catch(Exception e) {
                      e.printStackTrace();
                  } finally {
                      if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                      if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
                      if (conn != null) try { conn.close(); } catch(SQLException ex) {}
                  }
                 return x;
              }    
 }   
      
      


   
      
      
      
  
      
      
      
  