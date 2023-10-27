package team02.member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.Types;


import team02.db.land.OracleDB;
import team02.member.MemberDTO;

public class MemberDAO extends OracleDB {
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {   
		return instance;
	}
	private MemberDAO() {}

	Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";
    
    public void insertMember(MemberDTO member) {
    	try {
    		conn = getConnection();
    		sql = " insert into member(id, pw, name, nic, birth, gender, address, email, "
    				+ " phone, reg_date) values (?,?,?,?,?,?,?,?,?,sysdate) ";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPw());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getNic());
            pstmt.setString(5, member.getBirth());
            pstmt.setString(6, member.getGender());

            //주소와 상세주소가 모두 존재하는 경우 합쳐서 저장
            if (member.getAddress() != null && member.getAddressDetail() != null) {
                pstmt.setString(7, member.getAddress() + " " + member.getAddressDetail());
            } else if (member.getAddress() != null) {
                pstmt.setString(7, member.getAddress());
            } else {
                pstmt.setNull(7, Types.VARCHAR); // 주소가 없는 경우 DB에 null 저장
            }
            
            // 이메일과 이메일 옵션을 합쳐서 저장
            String fullEmail = member.getEmail() + "@" + member.getEmailOption();
            pstmt.setString(8, fullEmail);

            pstmt.setString(9, member.getPhone());           
            pstmt.executeUpdate();    
    	}catch(Exception e) {      
    		e.printStackTrace();        
    	}finally {        
    		close(rs, pstmt, conn);    
    	}
    }
    
    public int confirmId(String id) {  			  			
    	String dbpasswd = "";
    	int x=-1;		
    	try {		
    		conn = getConnection();		
    		sql = "select id from member where id=?";		
    		pstmt = conn.prepareStatement(sql);		
    		pstmt.setString(1,id);		   	
    		rs = pstmt.executeQuery();		
    		if(rs.next())		
    			x = 1;
    		else		
    			x = -1;		
    	}catch(Exception e) {	
    		e.printStackTrace();		
    	}finally{
    		close(rs, pstmt, conn);			
    	}
    	return x;		
    }
    
    public int confirmNIC(String nic) {
    	String dbpasswd = "";		
    	int x = -1;		   
    	try {			
    		conn = getConnection();				
    		sql = "select nic from member where nic=?";				
    		pstmt = conn.prepareStatement(sql);				
    		pstmt.setString(1,nic);				
    		rs=pstmt.executeQuery();			
    		if(rs.next())			
    			x = 1;			
    		else			
    			x = -1;			
    	}catch(Exception e) {				
    		e.printStackTrace();				
    	}finally{
    		close(rs, pstmt, conn);
    	}	
    	return x;	
    }
//    
    public MemberDTO getMember(String id) throws Exception {        
        MemberDTO member=null;
        try {
          conn = getConnection();
          sql = "select * from member where id = ?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          rs = pstmt.executeQuery();
          
          if (rs.next()) {
        	member = new MemberDTO();
            member.setId(rs.getString("id"));
            member.setPw(rs.getString("pw"));
            member.setName(rs.getString("name"));
            member.setNic(rs.getString("nic"));
            member.setBirth(rs.getString("birth"));
            member.setGender(rs.getString("gender"));
            member.setAddress(rs.getString("address"));
	    	member.setEmail(rs.getString("email"));
	    	member.setPhone(rs.getString("phone"));
	    	member.setGrade(rs.getInt("grade"));
	    	member.setTotal(rs.getInt("total"));
	    	member.setProfile(rs.getString("profile"));             
	    	member.setReg_date(rs.getString("reg_date"));  
				 }
        	}catch(Exception ex) {
        		ex.printStackTrace();
        	}close(rs, pstmt, conn);
        	 return member;
           }
    
    public void updateMember(MemberDTO member) {
      	try {
      		conn = getConnection();
      		sql = "update member set pw=?,name=?,nic=?,address=?,email=?,phone=?,profile=? where id=?";
      		pstmt = conn.prepareStatement(sql);      
	        pstmt.setString(1, member.getPw());
	        pstmt.setString(2, member.getName());
	        pstmt.setString(3, member.getNic());
	        pstmt.setString(4, member.getAddress());
	        pstmt.setString(5, member.getEmail());
	        pstmt.setString(6, member.getPhone());
	        pstmt.setString(7, member.getProfile());
	        pstmt.setString(8, member.getId());
	        pstmt.executeUpdate();
	         }catch(Exception ex) {
	              ex.printStackTrace();
	         }finally {
	        	  close(rs, pstmt, conn);
	         }
	      }
    
    
    public int userCheck(String id, String pw) {
        String dbpw="";
        int x=-1;
        try {
             conn = getConnection();
             sql="select pw from member where id = ?";
             pstmt = conn.prepareStatement(sql);
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
             }catch(Exception e) {
               e.printStackTrace();
             } 
              close(rs, pstmt, conn);
              return x;
   		}
    
    
    public int deleteMember(String id, String pw) {           
        String dbpw="";
        int x=-1;
        try {
             conn = getConnection();
             sql ="select pw from member where id = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
                
        if(rs.next()){
           dbpw= rs.getString("pw"); 
        if(dbpw.equals(pw)){
      	  sql = "delete from member where id=?";
      	  pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.executeUpdate();
              x= 1; 
            }else
              x= 0; 
             }
            }catch(Exception e) {
            e.printStackTrace();


         	}finally {
        	 close(rs, pstmt, conn);
         	}
        	return x;
      	}
   
    
    public void updateProfileImage(String id, String fileName) throws Exception { //사진업로드하는  dao     
        try {
            conn = getConnection();
            sql = "UPDATE member SET profile = ? WHERE id = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fileName);
            pstmt.setString(2, id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	 close(rs, pstmt, conn);
        }
    }
      
   
 }   
     
  


