<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team02.admin.use.AdminBanDAO" %>
<%@ page import="team02.admin.use.AdminBanDTO" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<% if(session.getAttribute("memId") == null){%>
		<script>
            alert("로그인하세요 🤬🤬🤬🤬");
            window.location="/wherego/views/admin/ban/banList.jsp";
        </script>
<%
	}else{

	int num = Integer.parseInt(request.getParameter("num"));
	
	AdminBanDAO dao = AdminBanDAO.getInstance();
	AdminBanDTO dto = dao.findPostToNum(num);

    String id = (String) session.getAttribute("memId");
	int grade = dao.isAdmin(id);
    if (!id.equals(dto.getId()) && grade != 99) {
%>
        <script>
            alert("작성자만 삭제 가능합니다");
            window.location="/wherego/views/admin/ban/banList.jsp";
        </script>
<% } else { %>
    <body>
     <jsp:include page="/views/main/nav.jsp" />
    
    <br />
    <div class="text-center">
        <h1>어디 Go</h1>
    </div>
    <br />
    <hr />
    
    <!-- 문의 리스트 -->
    <h2 align="center">문의 게시판</h2>
    <br />
    <h1>정말 삭제하시겠습니까?</h1>
    <form action="banDeletePro.jsp" method="post" onsubmit="return writeSave()">
        <input type="hidden" name="num" value="<%= num %>">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= dto.getWriter() %>">
            <input type="hidden" name="id" class="form-control" value="<%= id %>">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class "form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2" value="<%= dto.getTitle() %>">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">문의내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"><%= dto.getContent() %></textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-danger">삭제</button>
        </div>
    </form>
    
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
</body>
<% }
}%>
</html>
