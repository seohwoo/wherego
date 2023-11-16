<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="team02.mag.MagDAO" %>
<head>
	<link href="/wherego/views/mypage/mypage.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	
</head>

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

<h2> 삭제가 완료되었습니다.</h2>
<input type = "button" class="btn btn-light" value="닫기" OnClick = "closeAndRefresh();">
