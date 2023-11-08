<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="team02.mag.MagDAO" %>


<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    MagDAO dao = MagDAO.getInstance();
	dao.deleteMag(num);
%>
<script>
	function closeAndRefresh() {
    window.close(); // 현재 창을 닫음
    window.location.replace('magList.jsp');
	}
	</script>

<h1> 삭제가 완료되었습니다.</h1>
<input type = "button" class="btn btn-light" value="닫기" OnClick = "closeAndRefresh();">
