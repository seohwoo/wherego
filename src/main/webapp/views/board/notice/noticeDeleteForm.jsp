<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team02.notice.NoticeDAO" %>
<%@ page import="team02.notice.NoticeDTO" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<%
int num = Integer.parseInt(request.getParameter("num"));

NoticeDAO dao = new NoticeDAO();
NoticeDTO dto = dao.getNoContent(num);

 String memId = (String) session.getAttribute("memId");
 String nic = dao.selectNo(memId);
 int grade = dao.getGradeById(memId);
 if (grade!=99) { 
%>
        <script>
            alert("관리자만 삭제 가능합니다");
            window.location="/wherego/views/board/notice/noticeList.jsp";
        </script>
    <body>
<% } else { %>
     <jsp:include page="/views/main/nav.jsp" />
    
    <br />
    <div class="text-center">
        <h1>어디 Go</h1>
    </div>
    <br />
    <hr />
    
    <h2 align="center">📢 공지사항 📢</h2>
    <br />
    <form action="noticeDeletePro.jsp" method="post" onsubmit="return writeSave()">
        <input type="hidden" name="num" value="<%= num %>">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic %>" readonly>
            <input type="hidden" name="id" class="form-control" value="<%= memId %>">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class="form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2" value="<%= dto.getTitle() %>" readonly>
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">공지내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3" readonly><%= dto.getContent() %></textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit"  class="btn btn-danger">공지 삭제</button>
        </div>
    </form>
    
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
<% }%>
</body>
</html>
