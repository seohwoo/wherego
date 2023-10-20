<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<% request.setCharacterEncoding("UTF-8");%>

<%
    String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String askListUrl = String.valueOf(session.getAttribute("askListUrl"));
	
	
	

	
	MemberDAO manager = MemberDAO.getInstance();
	
    int check= manager.userCheck(id,pw);

	if(check==1){
		//로그인 성공
		session.setAttribute("memId",id);
		if(askListUrl.equals("http://localhost:8080/wherego/views/main/board/askList.jsp")) {
			String originalString = askListUrl;
			String realAskListUrl = originalString.substring(originalString.indexOf("/wherego"));
			response.sendRedirect(realAskListUrl);
		}else{
			response.sendRedirect("/wherego/views/main/main.jsp");
		}
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