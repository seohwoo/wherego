package team02.mylist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import team02.db.land.OracleDB;

public class MyListDAO extends OracleDB {
	private static MyListDAO instance = new MyListDAO();
	public static MyListDAO getInstance() {
		return instance;
	}
		private MyListDAO() {}
		
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "";
	    
		public void insertArticle(MyListDTO article) {
		    
		    try {
		        conn = getConnection();
		        sql = "insert into mylist (num, id, content, subject, image, zone, reg_date) VALUES (mylist_seq.NEXTVAL,?,?,?,?,?,sysdate)";
		        pstmt = conn.prepareStatement(sql);       
		        pstmt.setString(1, article.getId());
		        pstmt.setString(2, article.getContent());
		        pstmt.setString(3, article.getSubject());
		        pstmt.setString(4, article.getImage());
		        pstmt.setString(5, article.getZone());
		        pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        close(rs, pstmt, conn);
		    }
		}

		public int getArticleCount() {
			int x = 0;
			try {
				conn = getConnection();
				sql = "select count(*) from mylist";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return x;
		}
		
		public List getArticles(int start, int end) {
			List articleList = null;
			
			try {
				conn = getConnection();
				sql = "select * from "
						+ " (select b.* , rownum r from "
						+ " (select * from mylist order by num asc) b) "
						+ " where r >= ? and r <= ? ";	
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					articleList = new ArrayList(end);
					do {
						MyListDTO article = new MyListDTO();
						article.setId(rs.getString("id"));
						article.setNum(rs.getInt("num"));
						article.setContent(rs.getString("content"));
						article.setSubject(rs.getString("subject"));
						article.setCount(rs.getInt("count"));
						article.setImage(rs.getString("image"));
						article.setZone(rs.getString("zone"));
						article.setReg_date(rs.getString("reg_date"));																
						articleList.add(article);
					} while (rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return articleList;					
		}

		public MyListDTO updateGetArticle(int num) {
			MyListDTO article = null;

			try {
				conn = getConnection();
				sql = "select * from mylist where num = ?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					article = new MyListDTO();
					article.setId(rs.getString("id"));
					article.setNum(rs.getInt("num"));
					article.setContent(rs.getString("content"));
					article.setSubject(rs.getString("subject"));
					article.setCount(rs.getInt("count"));
					article.setImage(rs.getString("image"));
					article.setZone(rs.getString("zone"));
					article.setReg_date(rs.getString("reg_date"));																	
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			return article;
		}
			
		public MyListDTO getArticle(int num) {
			MyListDTO article = null;
			
			try {
				conn = getConnection();
				sql = "update mylist set count=count+1 where num = ?";
				pstmt = conn.prepareStatement(sql); 
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement(
				"select * from mylist where num = ?"); 
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					article = new MyListDTO();
					article.setId(rs.getString("id"));
					article.setNum(rs.getInt("num"));
					article.setContent(rs.getString("content"));
					article.setSubject(rs.getString("subject"));
					article.setCount(rs.getInt("count"));
					article.setImage(rs.getString("image"));
					article.setZone(rs.getString("zone"));
					article.setReg_date(rs.getString("reg_date"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
			return article;
		}

		public String getId(int num) {
		      String result = null;
		     
		      try {
		         conn = getConnection();
		         sql = "select id from mylist where num=?";
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1, num);
		         rs = pstmt.executeQuery();
		         if (rs.next()) {
		            result = rs.getString(1); 
		         }
		      }catch(Exception e) {
		         e.printStackTrace();
		      }finally {
		         close(rs, pstmt, conn);
		      }
		      return result;
		   }
		
		public int deleteArticle(int num) {
			int x = -1;
			
			try {
					conn = getConnection();
					sql = "delete from mylist where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1,num);					
					x = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return x;
		}
		
		public List getmyArticles(int start, int end, String id) {
			List articleList = null;
			
			try {
				conn = getConnection();
				sql = "select * from "
						+ " (select b.* , rownum r from "
						+ " (select * from mylist order by num asc) b) "
						+ " where r >= ? and r <= ? and id = ?";					
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start); 
				pstmt.setInt(2, end); 
				pstmt.setString(3, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					articleList = new ArrayList(end); 
					do{ 
						MyListDTO article= new MyListDTO();
						article.setId(rs.getString("id"));
						article.setNum(rs.getInt("num"));
						article.setContent(rs.getString("content"));
						article.setSubject(rs.getString("subject"));
						article.setCount(rs.getInt("count"));
						article.setImage(rs.getString("image"));
						article.setZone(rs.getString("zone"));
						article.setReg_date(rs.getString("reg_date"));								
						articleList.add(article); 
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return articleList;
		}
		
		public int getmyArticleCount(String id) {
			int x = 0;
			
			try {
				conn = getConnection();
				sql = "select count(*) from mylist WHERE id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id); 
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x = rs.getInt(1); 
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return x; 
		}
		
		public int updateArticle(MyListDTO article) {
			int x = 0;
			
			try {
				conn = getConnection();
				sql = "select id from mylist where num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, article.getNum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql = " update mylist set id=?, subject=?, content=?, image=?, zone=? where num =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getId());		
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getContent());
					pstmt.setString(4, article.getImage());
					pstmt.setString(5, article.getZone());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x = 1;
				}else {
					x = 0;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs, pstmt, conn);
			}
			return x;
		}
}