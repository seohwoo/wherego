<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team02.askreply.AskreplyDAO" %>
<%@ page import="team02.askreply.AskreplyDTO" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	AskreplyDAO dao = new AskreplyDAO();
	AskreplyDTO dto = dao.getReCount(num);

   String memId = (String) session.getAttribute("memId");
   String asknum = (String) session.getAttribute("num");
   String nic = dao.selectRe(memId);
   String boardnum = dao.selectNum(asknum);
   if (!memId.equals(dto.getId())) {
        // 등급이 관리자인 사람만 삭제 가능 !!수정하기!!!
%>
        <script>
            alert("관리자만 삭제 가능합니다");
            window.location="/wherego/views/board/noticeList.jsp";
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
	
	 <!-- 답변 -->
    <h3 align="center">답변</h3>
    <br />
	
    <form action="askrePro.jsp" method="post" onsubmit="return writeSave()">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="hidden" name="num" value="<%= num %>">
            <input type="hidden" name = boardnum class="form-control" value="<%=boardnum %>" >
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic  %>">
            <input type="hidden" name = id class="form-control" value="<%=memId %>" >
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">댓글</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"><%= dto.getContent() %></textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-secondary">등록</button>
        </div>
    </form>
    
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
<% }%>
</body>
</html>
