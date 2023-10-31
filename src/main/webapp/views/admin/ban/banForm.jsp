<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="team02.admin.use.AdminMemberDAO" %>
<%@ page import="team02.admin.use.AdminMemberDTO" %>
<%@ page import="team02.admin.use.AdminBanDAO" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>

<% if (session.getAttribute("memId") == null) {%>
    <script>
        alert("로그인 후 사용가능..!!!😥");
        window.location="/wherego/views/admin/ban/banList.jsp?pageNum=1";
    </script>
<%}else{ 
	String id = (String) session.getAttribute("memId");
	AdminMemberDAO daoM = AdminMemberDAO.getInstance();
	AdminBanDAO daoB = AdminBanDAO.getInstance();		
	AdminMemberDTO dtoM = daoM.userInfo(id);
	String banId = daoB.isBanId(id);
	
	if (dtoM.getGrade()!=1 && dtoM.getGrade()!=99) {%>
    <script>
        alert("정지된 사용자만 작성 가능..!!!😥");
        window.location="/wherego/views/admin/ban/banList.jsp?pageNum=1";
    </script>	

	<%--
		else if(id.equals(banId)) {%>
			<script>
				alert("변경 요청은 한번만 가능합니다..!!!😥");
				window.location="/wherego/views/admin/ban/banList.jsp?pageNum=1";
			</script>	 
		<%}
	 --%>
	<%}else{%>	
    <body>
 	<%
	int boardnum = 0, ref = 1;
	if(request.getParameter("boardnum")!= null){
		boardnum=Integer.parseInt(request.getParameter("boardnum"));
		ref=Integer.parseInt(request.getParameter("ref"))+1;
	}
		if(boardnum == 0){%>
     <jsp:include page="/views/main/nav.jsp" />
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	 <!-- 문의 리스트 -->
    <h2 align="center">Q & A</h2>
    <%} else{ %>
    <br />
    <h3 align="center">💭 답변 💭</h3>
    <%} %>
    <br />
	<div class="d-grid gap-2 col-6 mx-auto">
    <form action="banPro.jsp" method="post" onsubmit="return writeSave()">
        <div class="mb-3">
            <label for="exampleFormControlInput1" class="form-label">작성자</label>
            <input type="text" name="writer" class="form-control" id="exampleFormControlInput1" value="<%= dtoM.getNic()  %>"  readonly>
            <input type="hidden" name = id class="form-control" value="<%=id %>" >
            <input type="hidden" name = ref class="form-control" value="<%=ref %>" >
            <input type="hidden" name = boardnum class="form-control" value="<%=boardnum %>" >
        </div>
        <%if(boardnum ==0){ %>
        <div class="mb-3">
            <label for="exampleFormControlInput2" class="form-label">제목</label>
            <input type="text" name="title" class="form-control" id="exampleFormControlInput2">
        </div>
        <%} %>
        <%if(boardnum ==0){ %>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
        </div>
        <%}else{ %>
        <div class="mb-3">
            <label for="exampleFormControlTextarea1" class="form-label">내용</label>
            <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="3">[답변]</textarea>
        </div>
        <%} %>
        <div class="d-grid gap-2 col-6 mx-auto">
            <button type="submit" class="btn btn-secondary">등록</button>
        </div>
    </form>
    </div>
	    <%if(boardnum == 0){ %>
	    <div class="fixed-bottom">
	        <hr />
	        <jsp:include page="/views/main/footer.jsp" />
	    </div>
<% 		}			
	} 
}%>
</body>

</html>
