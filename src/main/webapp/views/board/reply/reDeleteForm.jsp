<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.askReply.ReplyDAO" %>
<%@ page import="team02.askReply.ReplyDTO" %>
<!DOCTYPE html>
<html>
<head>
	<link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
    String memId = (String) session.getAttribute("memId");
    ReplyDAO dao = new ReplyDAO();
    ReplyDTO dto =  dao.getReContent(num);
    String nic = dao.selectRe(memId);
    int grade = dao.getGradeById(memId);
    if (grade!=99) { 
%>
    <script>
        alert("관리자만 접근가능!");
        window.location="/wherego/views/board/notice/noticeList.jsp";
    </script>
<% } else { 
    int ref = 1, boardnum = 0; // boardnum 변수 추가
    if (request.getParameter("boardnum") != null) {
        boardnum = Integer.parseInt(request.getParameter("boardnum"));
        // askboard의 num 값을 boardnum으로 설정
    }
    if (request.getParameter("ref") != null) {
        ref = Integer.parseInt(request.getParameter("ref"));
    }
%>
    <jsp:include page="/views/main/nav.jsp" />
    <jsp:include page="/views/main/title.jsp" /><br />
    <!-- 문의 리스트 -->
    <h2 align="center">💭 답변 💭</h2>
    <br />
    
    <div class="d-grid gap-2 col-6 mx-auto">
	    <form action="reDeletePro.jsp" method="post" onsubmit="return writeSave()">
	        <div class="mb-3">
	            <label for="exampleFormControlInput1" class="form-label">작성자</label>
	            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic  %>">
	            <input type="hidden" name="id" class="form-control" value="<%= memId %>">
	            <input type="hidden" name="num" value="<%= num %>">
	            <!-- boardnum 값을 askboard의 num의 값으로 설정 -->
	            <input type="hidden" name="boardnum" value="<%= boardnum %>">
	            <input type="hidden" name="ref" value="<%= ref %>">
	        </div>
	        <div class="mb-3">
	            <label for "exampleFormControlTextarea1" class="form-label">내용</label>
	            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3">[답변]<%=dto.getContent() %></textarea>
	        </div>
	        <div class="d-grid gap-2 col-6 mx-auto">
	            <button type="submit" class="btn btn-danger">삭제</button>
	        </div>
	    </form>
   	</div>
   	
        <br /><hr /><br />
        <jsp:include page="/views/main/footer.jsp" />
<% }%>
</body>
</html>
