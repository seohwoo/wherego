<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="team02.notice.NoticeDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
	    pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    NoticeDAO dao = NoticeDAO.getInstance();
    NoticeDTO dto = dao.getNewNotice();
    String content = dto.getContent();
    
    // 설정할 최대 길이 (100 글자)
    int maxLength = 20;
%>
<div class="d-grid gap-2 col-6 mx-auto">
	<div class="card">
	  <div class="card-body">
	  
	  <div align="center">
	   <button type="button"  class="btn btn-outline-dark" 
			OnClick="window.location='/wherego/views/board/notice/noticeList.jsp'">📢 <b><%= dto.getTitle() %></b></button>
        	 
             <% if (content.length() <= maxLength) {
                // 길이가 100글자 이하이면 전체 내용 출력
                out.print(content);
             } else {
                // 100글자를 넘을 경우 "더보기" 링크 추가
                out.print(content.substring(0, maxLength) + "...");
             }
             %>
             <% if (content.length() > maxLength) { %>
                        <a href="/wherego/views/board/notice/contentNo.jsp?num=<%= dto.getNum() %>&pageNum=<%= currentPage %>">더보기</a>
                    <% } %>
             
      </div>
	  </div>
	</div>
</div>

</body>
</html>