<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.askboard.AskboardDAO" %>
<%@ page import = "team02.askboard.AskboardDTO" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<%
int num = Integer.parseInt(request.getParameter("num"));

AskboardDAO dao = new AskboardDAO();
AskboardDTO dto = dao.getAsking(num);

    String memId = (String) session.getAttribute("memId");
    String nic = dao.select(memId);
    if (!memId.equals(dto.getId())) {
        // 게시물 작성자와 로그인 사용자가 일치하는 경우
%>
        <script>
            alert("작성자만 수정 가능합니다");
            window.location="/wherego/views/board/ask/askList.jsp";
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
    
    <!-- 문의 리스트 (수정) -->
    <h2 align="center">문의 게시판 (수정)</h2>
    <br />
    <form action="askUpdatePro.jsp" method="post" onsubmit="return writeSave()">
        <input type="hidden" name="num" value="<%= num %>">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic %>">
            <input type="hidden" name="id" class="form-control" value="<%= memId %>">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class "form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2" value="<%= dto.getTitle() %>">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">문의내용(수정)</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"><%= dto.getContent() %></textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-success">수정된 문의 등록</button>
        </div>
    </form>
    
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
<% }%>
</body>
</html>
