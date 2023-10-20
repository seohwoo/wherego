<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.notice.NoticeDAO" %>
<%@ page import = "team02.notice.NoticeDTO" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<%
	String memId = (String) session.getAttribute("memId");
	
	NoticeDAO dao = new NoticeDAO();
    String nic = dao.selectNo(memId);
    if (!"admin".equals(memId)) { //아이디의 등급이 관리자일때
        // 로그인 id가 admin이 아닐 때
 %>
        <script>
            alert("관리자만 접근가능!");
            window.location="/team02/views/board/noticeList.jsp";
        </script>
    <body>
<% } else { %>
     <%@ include file="/views/main/nav.jsp" %>
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	 <!-- 공지 게시판 -->
    <h2 align="center">📢 공지게시판 📢</h2>
    <br />
	
    <form action="noticePro.jsp" method="post" onsubmit="return writeSave()">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            	<input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic  %>">
            	<input type="hidden" name = id class="form-control" value="<%=memId %>" >
        </div>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class="form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">공지내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-secondary">공지 등록</button>
        </div>
    </form>
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
        
<% }%>
</body>
</html>
