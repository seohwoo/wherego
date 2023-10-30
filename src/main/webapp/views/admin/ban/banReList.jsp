<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="team02.admin.use.AdminBanDAO" %>
<%@ page import="team02.admin.use.AdminBanDTO" %>

<%
    int boardnum = Integer.parseInt(request.getParameter("boardnum"));
    int ref = Integer.parseInt(request.getParameter("ref"));
    AdminBanDAO dao = AdminBanDAO.getInstance();
    int cnt = dao.banReCnt(1);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Q&A</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
    <h3 align = "center">💭 답변 💭</h3>
    <br />
    <div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='/wherego/views/admin/ban/banList.jsp'">문의목록</button>
    </div>
    <br />

    <% 
        if (cnt>0) {
        	ArrayList<AdminBanDTO> banReList = dao.findBanReList(1);
            for (AdminBanDTO dto : banReList) {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
                <table class="table table-bordered border-primary" width="700" cellpadding="0" cellspacing="0" align="center">
                	<tr>
                		<td align="center" width="250"><b>작성자</b></td>
                		<td align="center" width="250"><%=dto.getWriter()%></td>
                		<td align="center" width="250"><b>날짜</b></td>
                		<td align="center" width="250"><%=dto.getReg_date()%></td>
                	</tr>
                	<tr><td align="center" width="250"><b>내용</b>
                	<td colspan="3" align="center"><%=dto.getContent() %></tr>
                </table>
		</div>
		<div align="center">
			<button type="button" class="btn btn-outline-danger" OnClick="window.location='reUpdateForm.jsp?num=<%=dto.getNum()%>'">답변수정</button>
		    <button type="button" class="btn btn-outline-warning" Onclick="window.location='reDeleteForm.jsp?num=<%=dto.getNum()%>'">답변삭제</button>
	    </div>
    <%
            }
        } else {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
	    	<table class="table table-bordered border-primary" >
	        <tr>
	            <td align="center">답변예정 중 입니다. 조금만 기다려주세요</td>
	            <td align="center"><%=boardnum %></td>
	            <td align="center"><%=ref %></td>
	        </tr>
	    	</table>
    	</div>
    <%
        }
    %>
    <br />
    <div class = "fixed-bottom">
	<br/><hr /><br/>
	</div>
</body>
</html>
