<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="team02.user.save.SaveDAO" %>


<%
    String id = (String) session.getAttribute("memId");
    int num = Integer.parseInt(request.getParameter("num"));
    SaveDAO DR = SaveDAO.getInstance();
    DR.deleteReview(num);

%>
<script>
	function closeAndRefresh() {
    window.close(); // 현재 창을 닫음
    window.opener.location.reload(); // 원래 창을 새로고침
	}
	</script>

<h1> 삭제가 완료되었습니다.</h1>
<input type = "button" class="btn btn-light" value="닫기" OnClick = "closeAndRefresh();">
