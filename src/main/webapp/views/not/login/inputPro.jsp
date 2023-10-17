<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.member.MemberDAO" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="member" class="team02.member.MemberDTO">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>







 <% 

	MemberDAO manager = MemberDAO.getInstance();
	manager.insertMember(member);
	response.sendRedirect("/team02/views/main/main.jsp");
%>  