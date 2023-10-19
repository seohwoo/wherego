<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/views/login/color.jsp"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String id = (String)session.getAttribute("memId");
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">



<body bgcolor="<%=bodyback_c%>">
<center><b>글삭제</b>
<br>


<form method="POST" name="delForm"  action="boardDeletePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>" 
   onsubmit="return deleteSave()"> 
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
  <tr height="30">
     <td align=center  bgcolor="<%=value_c%>">
       <b>삭제 하시겠습니까..</b></td>
  </tr>
  
 <tr height="30">
    <td align=center bgcolor="<%=value_c%>">
      <input type="submit" value="글삭제" >
      <input type="button" value="글목록" 
       onclick="document.location.href='board.jsp?pageNum=<%=pageNum%>'">     
   </td>
 </tr>  
</table> 
</form>

</body>
</html> 







