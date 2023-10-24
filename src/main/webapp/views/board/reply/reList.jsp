<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="team02.askReply.ReplyDTO" %>
<%@ page import="team02.askReply.ReplyDAO" %>

<%
    int boardnum = Integer.parseInt(request.getParameter("boardnum"));
    int ref = Integer.parseInt(request.getParameter("ref"));
    ReplyDAO dao = ReplyDAO.getInstance();
    ArrayList<ReplyDTO> replyList = dao.getReply(boardnum);
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
    	<button type="button" class="btn btn-light" OnClick="window.location='/wherego/views/board/ask/askList.jsp'">문의목록</button>
    </div>
    <br />

    <% 
        if (replyList != null && !replyList.isEmpty()) {
            for (ReplyDTO dto : replyList) {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
                <table class="table table-bordered border-primary" width="700" cellpadding="0" cellspacing="0" align="center">
                	<tr>
                		<td align="center">작성자</td>
                		<td align="center"><%=dto.getWriter()%></td>
                		<td align="center">날짜</td>
                		<td align="center"><%=dto.getReg_date()%></td>
                	</tr>
                	<tr><td align="center"><b>내용</b>
                	<td colspan="3" align="center"><b><%=dto.getContent() %></b></tr>
                </table>
		</div>
    <%
            }
        } else {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
	    	<table class="table table-bordered border-primary" >
	        <tr>
	            <td align="center">답변예정 중 입니다. 조금만 기다려주세요</td>
	        </tr>
	    	</table>
    	</div>
    <%
        }
    %>
    <br />
    <div class = "fixed-bottom">
	<br/><hr /><br/>
		<jsp:include page="/views/main/footer.jsp" />	
	</div>
</body>
</html>
