<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "team02.mylist.MyListDAO" %>
<%@ page import = "team02.mylist.MyListDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>
<%!
    int pageSize = 10;  // 게시판 첫페이지에 보여줄 글 개수  
    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
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

    List articleList = null;
    MyListDAO dbPro = MyListDAO.getInstance();
    count = dbPro.getArticleCount();
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, endRow);
    }

	number=count-(currentPage-1)*pageSize;
%>


<title>게시판</title>
<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700">
<tr>
    <td align="right" bgcolor="<%=value_c%>">
    <%if(session.getAttribute("memId") == null){%>
    	<a href="/team02/views/main/main.jsp">로그인</a>
    <%}else{%>
    	<a href="writeForm.jsp">글쓰기</a>
    	<a href="/team02/views/mylist/myWirte.jsp">내꺼</a>
    	
    <%}%>
    </td>
</table>

<%
    if (count == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {  %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=blue_b%>"> 
       <td align="center"  width="100"  >글번호</td> 
      <td align="center"  width="100" >제목</td> 
      <td align="center"  width="100" >내용</td>
      <td align="center"  width="150" >조회수</td> 
      <td align="center"  width="150" >사진</td> 
      <td align="center"  width="150" >지역</td> 
      <td align="center"  width="100" >작성일</td>     
    </tr>
 <%  
        for (int i = 0 ; i < articleList.size() ; i++) {
           MyListDTO article = (MyListDTO)articleList.get(i);
%>   
	    <tr height="30">
	    
	    <td align="center"  width="100" > <%=number--%></td>
	    <td align="center"  width="100" >
	    
	     <%=article.getId()%> 
	     
	     </td>
   		<td align="center"  width="100"> 
   		
   		<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           <%=article.getSubject()%></a> 
        
   		
   		
	    <td align="center"  width="150"><%=article.getCount()%></td>
	    <td align="center"  width="150"><%=article.getImage()%></td>
	    <td align="center"  width="50"><%=article.getZone()%></td>
	    <td align="center"  width="50"><%=article.getReg_date()%></td>
	    
  </tr>
    <%}%>
</table>
<%}%>

<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="board.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        <a href="board.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
        <a href="board.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>


</center>


