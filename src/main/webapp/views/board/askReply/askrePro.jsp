<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.askreply.AskreplyDAO" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" scope="page" class="team02.askreply.AskreplyDTO">
   <jsp:setProperty name="dto" property="*"/>
</jsp:useBean>
 
<%

	AskreplyDAO dao = AskreplyDAO.getInstance();
    dao.insertReply(dto);

    response.sendRedirect("/wherego/views/board/ask/askList.jsp");
%>