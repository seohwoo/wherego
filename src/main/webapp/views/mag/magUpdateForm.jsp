<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>
<%@ page import = "team02.mag.MagDTO" %>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try{
	  MagDAO dbPro = MagDAO.getInstance();
	  MagDTO mag =  dbPro.updateGetArticle(num);

%>
 
<center><b>글수정</b>
<br>
<form method="post" name="writeform" action="magUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    
	   <input type="hidden" name="num" value="<%=mag.getNum()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=mag.getSubject()%>"></td>
  </tr>
  
  <tr>
    <td  width="70"  align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=mag.getContent()%></textarea></td>
  </tr>
  
  <tr>      
   <td colspan=2  align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
<%
}catch(Exception e){}%>      
      
</body>
</html>       
