<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.admin.use.AdminMemberDAO"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어디GO</title>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8"); %>
	<%
		String id = request.getParameter("id");
		int grade = Integer.parseInt(request.getParameter("grade"));
		AdminMemberDAO dao = AdminMemberDAO.getInstance();
		dao.changeGrade(id, grade);
		HashMap<String, String> userInfoMap = dao.selectUserInfo(id, grade);
		String content = request.getParameter("content");
		if(grade==1) {
			dao.insertUserBan(id, grade, content);
		}else if(grade==2) {
			dao.deleteUserBan(id);
		}
	%>
	<script type="text/javascript">
    	alert("<%=userInfoMap.get("nic")%>님의 등급이 <%=userInfoMap.get("gradename")%>으로 변경되었습니다!");
    	window.location = "/wherego/views/admin/showDirtyMember.jsp?pageNum=1 "; 
	</script>
</body>
</html>