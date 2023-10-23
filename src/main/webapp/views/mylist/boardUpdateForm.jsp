<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "team02.mylist.MyListDAO" %>
<%@ page import = "team02.mylist.MyListDTO" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>


<title>글 수정</title>
<script language="JavaScript" src="script.js"></script>


<%
	String id = (String)session.getAttribute("memId");
  	int num = Integer.parseInt(request.getParameter("num"));
  	String pageNum = request.getParameter("pageNum");
  	try{
	  	MyListDAO dbPro = MyListDAO.getInstance();
	  	MyListDTO article =  dbPro.updateGetArticle(num);

%>

<body >  
<center><b>글수정</b>
<br>
<form method="post" name="boardUpdateform" action="boardUpdatePro.jsp?pageNum=<%=pageNum%>">
<table width="600" border="1" cellspacing="0" cellpadding="0"  align="center">
  <tr>
	<td  width="100"  align="center">닉네임</td>
    <td align="left" width="300"><%=article.getId()%>
	   	<input type="hidden" name="num" value="<%=article.getNum()%>"></td>
  		<input type="hidden" size="50" maxlength="50" name="id" value="<%=num%>">
  		
  </tr>

	<tr>
    <td  width="100"   align="center" >제목</td>
    <td align="left" width="300">
       <input type="text" size="40" maxlength="50" name="content" value="<%=article.getContent()%>" style="width:100%"></td>
  	</tr>

	<tr>
    <td  width="100"  align="center">지역</td>
    <td align="left" width="300">
       <input type="text" size="50" maxlength="500" name="zone" value="<%=article.getZone()%>" style="width:100%"></td>
  	</tr>

	<tr>
    <td  width="100"  align="center">사진</td>
    <td align="left" width="300">
       <input type="text" size="50" maxlength="500" name="image" value="<%=article.getImage()%>" style="width:100%"></td>
  	</tr>

	<tr>
    <td  width="100"  align="center">내용</td>
    <td align="left" width="300">
       <input type="text" size="50" maxlength="500" name="subject" value="<%=article.getSubject()%>" style="width:100%"></td>
  	</tr>


 <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='board.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>


<%
}catch(Exception e){}%>   