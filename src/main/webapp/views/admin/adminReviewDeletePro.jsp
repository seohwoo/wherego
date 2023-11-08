<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="team02.user.save.SaveDAO" %>
<%@ page import="team02.main.use.SearchDAO" %>
<% request.setCharacterEncoding("UTF-8");%>
<%
	String id = request.getParameter("id");
    String contentid = request.getParameter("contentid");
    SaveDAO DR = SaveDAO.getInstance();
    DR.deleteReview(id, contentid);

%>
<script>
	function closeAndRefresh() {
    window.close(); // 현재 창을 닫음
    window.opener.location.reload(); // 원래 창을 새로고침
	}
</script>

<h1> 삭제가 완료되었습니다.</h1>
<input type = "button" class="btn btn-light" value="닫기" OnClick = "closeAndRefresh();">
