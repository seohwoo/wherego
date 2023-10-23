<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="team02.member.MemberDAO" %>
<%@ page import="team02.member.MemberDTO" %>

<title>내 찜목록 보기</title>

	<% if (session.getAttribute("memId") == null) { %>
	    <script>
	        alert("로그인 후 사용 가능합니다.");
	        window.location = "/wherego/views/main/main.jsp";
	    </script>
	<% } %>

	<%
		String id = (String) session.getAttribute("memId");
		
		MemberDAO manager = MemberDAO.getInstance();
		MemberDTO c = manager.getMember(id);
		
		try {%>
		 <center><table >
		        <tr>
		            <td>내가 찜한 여행지 (갯수:)</td>
		        </tr>
		    </table></center>
		   
		  <hr>
	 <%
	   int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수  
	   SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm");
	%>

	<%
	    String pageNum = request.getParameter("pageNum");
	    if (pageNum == null) {
	        pageNum = "1";
	    }
	
	    int currentPage = Integer.parseInt(pageNum);
	    int startRow = (currentPage - 1) * pageSize + 1;
	    int endRow = currentPage * pageSize;
	    int count = 0;
	    int number=0;
	
	    ArrayList articleList = null;
	    
	    String pd = (String)session.getAttribute("memId");
	    MemberDAO dbPro = MemberDAO.getInstance();
	    //count = dbPro.getMyArticleCount(pd);  아직 받은게 없응
	    //if (count > 0) {  아직 받은게 없응
	      //  articleList = dbPro.getMyArticles(pd);  아직 받은게 없응
	    //}
	
		number=count-(currentPage-1)*pageSize;
	%>

	<%
		if (count == 0) {
	%>
		<center>
		 <table width="700" border="1" cellpadding="0" cellspacing="0">
		        <tr>
		            <td align="center" colspan="6">
		                아직 찜한곳이 없습니다.
		            </td>
		        </tr>
		   </table>
		 </center>
	<%}%>
 
  <hr> 
  
  <center>
	<%
	    if (count > 0) {
	        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
			 
	        int startPage = (int)(currentPage/10)*10+1;
			int pageBlock=10;
	        int endPage = startPage + pageBlock-1;
	        if (endPage > pageCount) endPage = pageCount;
	        
	        if (startPage > 10) {    %>
	        <a href="list.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
	<%      }
	        for (int i = startPage ; i <= endPage ; i++) {  %>
	        <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
	<%
	        }
	        if (endPage < pageCount) {  %>
	        <a href="list.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
	<%
	        }
	    }
	%>
	</center>

<%}catch(Exception e){}%>