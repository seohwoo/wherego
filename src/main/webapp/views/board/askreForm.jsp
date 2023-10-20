<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.askreply.AskreplyDAO" %>
<%@ page import = "team02.askreply.AskreplyDTO" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<%
try {
	String memId = (String) session.getAttribute("memId");
	String asknum = (String) session.getAttribute("num");
	
	AskreplyDAO dao = new AskreplyDAO();
    String nic = dao.selectRe(memId);
    
    String boardnum = dao.selectNum(asknum);
    if (!"admin".equals(memId)) { //아이디의 등급이 관리자일때
        // 로그인 id가 admin이 아닐 때
 %>
        <script>
            alert("관리자만 접근가능!");
            window.location="/team02/views/board/askList.jsp";
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
            <input type="hidden" name = boardnum class="form-control" value="<%=boardnum %>" >
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic  %>">
            <input type="hidden" name = id class="form-control" value="<%=memId %>" >
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">댓글</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3">[답변]</textarea>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-secondary">등록</button>
        </div>
    </form>
    
    <div class="fixed-bottom">
        <hr />
        <jsp:include page="/views/main/footer.jsp" />
    </div>
        
<% }
} catch (Exception e) {
}
%>
</body>
</html>
