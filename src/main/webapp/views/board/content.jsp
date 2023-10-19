<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.askboard.AskboardDAO" %>
<%@ page import = "team02.askboard.AskboardDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   String id = (String)session.getAttribute("memId");
   
   try{
	   AskboardDAO dao = AskboardDAO.getInstance();
	   AskboardDTO dto =  dao.getAsking(num);
  	   String writer = dao.getWriter(num);
  	   
	  int ref=dto.getRef();
	  int re_step=dto.getRe_step();
	  int re_level=dto.getRe_level();

	  if(re_step == 0 || id.equals("admin") || id.equals(writer)){
		  //0이면 새 글, admin은 모두 볼 수 있음
		  
%>



<!DOCTYPE html>
<html>
<head>
</head>
<body>
	 <%@ include file="/views/main/nav.jsp" %>
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	<!-- 문의 글 -->
     <h2 align="center">askContent</h2>
    <br />
	<div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='askList.jsp'">문의목록 보기</button>
    </div>
    <br />
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
	    	<td align="center"><b>문의 내용</b></td>
		    <td colspan="3" align="center"><%=dto.getContent()%></td>
		  </tr>
	</table>
	<%
	String memId = (String) session.getAttribute("memId");
	String admin = "admin"; 
	if (memId.equals(admin)) { %>
	<div align="center">
	    <button type="button" class="btn btn-light" ">답변달기</button>
	    <button type="button" class="btn btn-light">삭제하기</button>
	</div>
	<%
	} else { %>
	<div align="center">
	    <button type="button" class="btn btn-light" OnClick="window.location='askUpdateForm.jsp?num=<%=num%>'">수정하기</button>
	    <button type="button" class="btn btn-light" onclick="window.location='askDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
	</div>
	<%}
	}
}catch(Exception e){} 	%>
	

	
	<div class="fixed-bottom">
	<hr />
		<%@ include file="/views/main/footer.jsp" %>	
	</div>
</body>
</html>