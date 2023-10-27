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
String memId = (String)session.getAttribute("memId");

AskboardDAO dao = AskboardDAO.getInstance();
AskboardDTO dto =  dao.getAsking(num);

int ref=dto.getRef();
int grade = dao.getGradeById(memId);
if(grade!=99 || memId.equals(memId)){
		  
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
     <h2 align="center">상세문의</h2>
    <br />
	<div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='askList.jsp'">문의목록 보기</button>
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
	    	<td align="center"><b>문의 내용</b></td>
		    <td colspan="3" align="center"><%=dto.getContent()%></td>
		  </tr>
	</table>
	</div>
		<%if(grade==99){%>
		<div align="center">
			<button type="button" class="btn btn-outline-info" OnClick="window.location='/wherego/views/board/reply/reForm.jsp?boardnum=<%=dto.getNum()%>&ref=<%=ref%>'">답변달기</button>
			<button type="button" class="btn btn-outline-success" OnClick="window.location='/wherego/views/board/reply/reList.jsp?boardnum=<%=dto.getNum()%>&ref=<%=ref%>'">답변보기</button>
		    <button type="button" class="btn btn-outline-danger" Onclick="window.location='askDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
		    <br />
		</div>
		<%}else{%>
		<div align="center">
			<button type="button" class="btn btn-outline-success" OnClick="window.location='/wherego/views/board/reply/reList.jsp?boardnum=<%=dto.getNum()%>&ref=<%=ref%>'">답변보기</button>
		    <button type="button" class="btn btn-outline-warning" OnClick="window.location='askUpdateForm.jsp?num=<%=num%>'">수정하기</button>
		    <button type="button" class="btn btn-outline-danger" Onclick="window.location='askDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
		    <br />
	    </div>
		    
		<%}%>
	<% }else{%>
	<script>
            alert("작성자 or 관리자만 접근가능!");
            window.location="/wherego/views/board/ask/askList.jsp";
        </script>
	
	<%}%>
	
	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />
</body>
</html>