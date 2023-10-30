<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.notice.NoticeDAO" %>
<%@ page import = "team02.notice.NoticeDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   String id = (String)session.getAttribute("memId");

	   NoticeDAO dao = NoticeDAO.getInstance();
	   NoticeDTO dto =  dao.getNoContent(num);
  	   String writer = dao.getAdmin(num);	  
%>

<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	 <jsp:include page="/views/main/nav.jsp" />	
	 <jsp:include page="/views/main/title.jsp" /><br />	
	
	<!-- 문의 글 -->
     <h2 align="center">📢 공지게시판 📢</h2>
    <br />
	<div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='noticeList.jsp'">공지사항 보기</button>
    </div>
    <br />
    <div class="d-grid gap-2 col-6 mx-auto">
	<table class="table table-bordered" width="700" cellpadding="0" cellspacing="0" align="center">
	    <tr>
	      <td align="center"  width="50" ><b>#</b></td>
	      <td align="center"  width="50" ><%=dto.getNum() %></td>
	      <td  align="center"  width="250" ><b>작성자</b></td>
	      <td align="center" width="250"><%=dto.getWriter() %></td>
	     </tr>
	     <tr>
	      <td  align="center"  width="250" ><b>제목</b></td>
	      <td align="center" width="250"><%=dto.getTitle() %></td>
	      <td  align="center"  width="200" ><b>날짜</b></td>
	      <td align="center" width="200"><%=sdf.format(dto.getReg_date()) %></td>
	    </tr>
	    <tr>
	    	<td align="center"><b>공지 내용</b></td>
		    <td colspan="3" align="center"><%=dto.getContent()%></td>
		  </tr>
	</table>
	</div>
	<%
	String memId = (String) session.getAttribute("memId");
	String admin = "admin"; 
    int grade = dao.getGradeById(memId);
    if (grade!=99)   %> 
	<div align="center">
		<button type="button" class="btn btn-light" OnClick="window.location='noticeUpdateForm.jsp?num=<%=num%>'">수정하기</button>
	    <button type="button" class="btn btn-light" onclick="window.location='noticeDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
	</div>
	
	<br /><hr /><br />
		<jsp:include page="/views/main/footer.jsp" />		
</body>
</html>