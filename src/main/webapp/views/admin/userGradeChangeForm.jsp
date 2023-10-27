<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.admin.use.AdminMemberDAO"%> 
<%@ page import = "team02.admin.use.AdminMemberDTO"%>     
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
		AdminMemberDAO dao = AdminMemberDAO.getInstance();
		AdminMemberDTO dto = dao.userInfo(id);
		HashMap<String, String> gradeInfo = dao.selectUserInfo(id, dto.getGrade());
	%>
	<form action="userGradeChangePro.jsp" method="post">
	 	<h3><%=dto.getNic() %>님의 현재등급은 <%= gradeInfo.get("gradename")%>등급입니다.</h3>
	 	<span>등급변경 : </span>
	 	<select name="grade">
	 		<option value="2">일반</option>
	 		<option value="1">정지</option>
	 		<option value="99">관리자</option>
	 	</select>
	 	<input type="hidden" name="id" value="<%=id%>"/>
	 	<h4>사유 : </h4>
	 	<textarea name="content" rows="13" cols="40"></textarea>
	 	<br />
	 	<input type="submit" name="submit" value="변경"/>
	 </form>
</body>
</html>