<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import = "java.util.Enumeration" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
   String path = request.getRealPath("image");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
   MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
   Enumeration enu = mr.getFileNames(); 
%>

<%
	String name = (String)enu.nextElement();
	mr.getFile(name);
	String fileName =  String.valueOf(mr.getFile(name).getName());        
	String id=(String)session.getAttribute("memId");
	MemberDAO manager = MemberDAO.getInstance();
	manager.updateProfileImage(id,fileName);
%>

 <script>
	 window.close();
	 window.opener.location.reload();
 </script>

</body>
</html>