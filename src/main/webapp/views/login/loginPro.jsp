<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "team02.login.MemberShipDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
    String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	MemberShipDAO manager = MemberShipDAO.getInstance();
    int check= manager.userCheck(id,pw);

	if(check==1){
		//로그인 성공
		session.setAttribute("memId",id);
		response.sendRedirect("main.jsp");
	}else if(check==0){%>
	<script> 
	  alert("아이디와 비밀번호를 확인하세요.");
      history.go(-1);
	</script>
<%	}else{ %>
	<script>
	  alert("아이디와 비밀번호를 확인하세요.");
	  history.go(-1);
	</script>
<%}	%>	