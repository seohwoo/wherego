<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "java.util.List" %>

<!-- 찜하기 -->
<%@ page import = "team02.user.save.SaveDAO"%> 
<%@ page import = "team02.user.save.SaveDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.util.List" %>
<%@page import = "java.util.HashMap" %>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>어디Go - Magazine</title>
</head>
<body>
<jsp:include page="/views/main/nav.jsp" />
<jsp:include page="/views/main/title.jsp" /><br />

<%
    int pageSize = 5;  // 게시판 첫페이지에 보여줄 글 개수
%>



<%
	String id = "";
	if(session.getAttribute("memId")!=null) {
   		id = (String) session.getAttribute("memId");
	}
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List MagList = null;
    MagDAO dbPro =  MagDAO.getInstance();
    count = dbPro.getMagCount();   //  메거진 글 갯수
    if (count > 0) {
    	MagList = dbPro.getMagines(startRow, endRow);  // 메거진 시작과 끝
    } 

   number=count-(currentPage-1)*pageSize;
%>



<center><b>글목록(전체 글:<%=count%>)</b>
  <table width="700">
   <tr>
     <td align="right">
      <%if(id.equals("admin")){%>
       <a href="/wherego/views/mag/test.jsp">메거진 쓰기</a>
      <%}else {%>      
       <a href="/wherego/views/main/main.jsp">메인페이지 이동</a>
      <%}%>
    </td>
   </tr> 
  </table>
</center>

<%
    if (count == 0) {
%>
   <center>
   <table width="700" border="1" cellpadding="0" cellspacing="0">
     <tr> 
       <td align="center">
       현재 작성된 메거진 없습니다.
       </td>
      </tr>
   </table>
   </center>

<%}else{%>
  <table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
      <tr height="30" > 
        <td align="center"  width="50"  >글번호</td> 
        <td align="center"  width="150" >제목</td>                           
        <td align="center"  width="150" >등록날짜</td>        
      </tr>
<%  
   for (int i = 0 ; i < MagList.size() ; i++) {
      MagDTO mag = (MagDTO)MagList.get(i);
%>
     <tr height="30">
       <td align="center"  width="50" > <%=number--%></td>      
       <td align="center"  width="100">
       <a href="content.jsp?num=<%=mag.getNum()%>&pageNum=<%=currentPage%>">
       <%=mag.getSubject() %></td>      
       <td align="center"  width="150"><%=mag.getReg_date() %></td>
     </tr> 
   <%}%>
 </table>
<%}%>

<br />
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
		<%
		    if (count > 0) {
		        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		       
		        int startPage = (int)(currentPage/10)*10+1;
		      	int pageBlock=10;
		        int endPage = startPage + pageBlock-1;
		        if (endPage > pageCount) endPage = pageCount;
		        
		        if (startPage > 10) {    %>
		        <li class="page-item">
		          <a class="page-link" href="magList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
		            <span aria-hidden="true">&laquo; 이전</span>
		          </a>
		        </li>
		<%      }
		        for (int i = startPage ; i <= endPage ; i++) {  %>
		        <li class="page-item">
		          <a class="page-link" href="magList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
		            <span aria-hidden="true">&laquo; 이전</span>
		          </a>
		        </li>
		<%
		        }
		        if (endPage < pageCount) {  %>
		         li class="page-item">
		          <a class="page-link" href="magList.jsp?pageNum=<%= startPage - 10 %>" aria-label="Previous">
		            <span aria-hidden="true">&laquo; 이전</span>
		          </a>
		        </li>
		<%
		        }
		    }
		%>
		</ul>
	</nav>
</body>
</html>

