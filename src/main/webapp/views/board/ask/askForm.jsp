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
	String memId = (String) session.getAttribute("memId");
	AskboardDAO dao = new AskboardDAO();
    String nic = dao.select(memId);
    if (memId == null) {
        // 로그인이 안되었을 때 (null)
 %>
        <script>
            alert("로그인 후 사용가능!");
            window.location="/wherego/views/board/ask/askList.jsp";
        </script>
    <body>
<% } else { 
	int num = 0, ref = 1;
	if(request.getParameter("num")!= null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
	}
%>
     <jsp:include page="/views/main/nav.jsp" />
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	 <!-- 문의 리스트 -->
    <h2 align="center">Q & A</h2>
    <br />
	
    <form action="askPro.jsp" method="post" onsubmit="return writeSave()">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= nic  %>">
            <input type="hidden" name = id class="form-control" value="<%=memId %>" >
            <input type="hidden" name = ref class="form-control" value="<%=ref %>" >
        </div>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class="form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2">
        </div>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
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
