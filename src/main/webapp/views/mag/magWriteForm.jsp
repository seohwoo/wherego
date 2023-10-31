<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "team02.mag.MagDAO" %>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>


<%
  // 로그인 된 세션 ID
  String id = (String)session.getAttribute("memId");
  try{  
    
%>
    
<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action="magWritePro.jsp">
<input type="hidden" name="id" value="<%=id%>">






<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
    <td align="right" colspan="2">
	    <a href="magList.jsp"> 글목록</a> 
   </td>
   </tr>



  <tr>
    <td  width="70" align="center">제목</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="subject" ></td>
  </tr>
  <tr>
    <td  width="70" align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
  <tr>
    <td  width="70" align="center" >사진</td>
    <td  width="330" >
     <input type="text" size="8" maxlength="12" name="firstimage"> 
	 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="글쓰기" >  
  <input type="reset" value="다시작성">
</td>
</tr>
</table>    
 <%
  }catch(Exception e){}
%>     
</form>      
</body>
</html>      