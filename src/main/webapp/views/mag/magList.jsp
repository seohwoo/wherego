<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<%@ page import = "java.util.List" %>


<title>관리자 메거진 리스트 보기</title>

<%
    int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수
%>

<%
   String id = (String) session.getAttribute("memId");
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
    count = dbPro.getMagCount();   // 만들어야함  메거진 총 갯수
    if (count > 0) {
    	MagList = dbPro.getMagines(startRow, endRow, id);  // 메거진 시작과 끝
    } 

   number=count-(currentPage-1)*pageSize;
%>



<center><b>글목록(전체 글:<%=count%>)</b>
  <table width="700">
   <tr>
     <td align="right">
      <%if(session.getAttribute("memId") == null){%>
       <a href="/wherego/views/main/main.jsp">로그인</a>
      <%}else{%>
       <a href="magWriteForm.jsp">메거진 쓰기</a>
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
        <td align="center"  width="50"  >번 호</td> 
        <td align="center"  width="150"  >사진 </td> 
        <td align="center"  width="250" >제  목</td>       
        <td align="center"  width="150" >작성일</td>        
      </tr>
<%  
   for (int i = 0 ; i < MagList.size() ; i++) {
      MagDTO mag = (MagDTO)MagList.get(i);
%>
     <tr height="30">
       <td align="center"  width="50" > <%=number++%></td>
       <td> <img width="150" height="150"  src="<%=mag.getFirstimage()%>"></td>
       <td align="center"  width="100">
       <a href="content.jsp?num=<%=mag.getNum()%>&pageNum=<%=currentPage%>">
       <%=mag.getSubject() %></td>
       <td align="center"  width="150"><%=mag.getReg_date() %></td>
     </tr>
   <%}%>
 </table>
<%}%>


<center>
<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
       
        int startPage = (int)(currentPage/10)*10+1;
      int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="magList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="magList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="magList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>




