<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="team02.notice.NoticeDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    NoticeDAO dao = NoticeDAO.getInstance();
    NoticeDTO dto = dao.getNewNotice();
%>

<div class="d-grid gap-2 col-6 mx-auto">	
	<div class="accordion" id="accordionExample">
	  <div class="accordion-item">
	    <h2 class="accordion-header">
	      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
	        📢 최신공지
	      </button>
	    </h2>
	    <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
	      <div class="accordion-body">
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
	<div align="center"><button align="center" type="button"  class="btn btn-outline-dark" OnClick="window.location='noticeList.jsp'">공지사항 전체보기</button></div>
	      </div>
	    </div>
	  </div> 
	</div>
</div>
</body>
</html>