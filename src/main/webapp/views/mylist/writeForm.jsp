<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>


<title>글쓰는곳</title>
<script language="JavaScript" src="script.js"></script>

<%
String id = (String)session.getAttribute("memId");
if(id == null){%>
	<script>    // 로그인 후 사용가능한것
		alert("로그인후 사용가능.")
		window.location="/team02/views/main/main.jsp"
	</script>
<%} %>


<%
	//로그인된 세션의 아이디로 사용가능한것


  int num=0;
  try{  
    if(request.getParameter("num")!=null){
	num=Integer.parseInt(request.getParameter("num"));
	}
%>

	<center><b>글쓰기</b>
	<br>
	<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="hidden" name="num" value="<%=num%>">
	
	<table width="400" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">
	   <tr>
	    <td align="right" colspan="2" bgcolor="<%=value_c%>">
		    <a href="board.jsp"> 글목록</a> 
	   </td>
	   </tr>
	
		<tr>
		    <td  width="70"  bgcolor="<%=value_c%>" align="center" >제 목</td>
		    <td  width="330"><input type="text" size="40" maxlength="50" name="content"></td>	
		</tr>

	  <tr>
	    <td  width="70"  bgcolor="<%=value_c%>" align="center" >내 용</td>
	    <td  width="330" >
	     <textarea name="subject" rows="13" cols="40"></textarea> </td>
	  </tr>
  
  	  <tr>
  	  	<td width="70"  bgcolor="<%=value_c%>" align="center" >사 진</td>
  	  	<td  width="330" >
  	  	<td name="subject" rows="13" cols="40"></textarea> </td>
  	  </tr>
  
	 <tr>
	 	<td  width="70"  bgcolor="<%=value_c%>" align="center" required="required">지 역</td>
	    <td  width="330" >

	     <select name="count">
	     <option  selected>선택하세요<</option>
	     <option value="1">서울</option>
	     <option value="2">인천</option>
	     <option value="3">경기도</option>
	     <option value="3">경상도</option>
	     <option value="3">충청도</option>
	     <option value="3">전라도</option>
	     <option value="3">강원도</option>
	     <option value="3">제주도</option>
	     </select>
	   </td>
	 
	 </tr>
  
	  <tr>      
		 <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
		  <input type="submit" value="글쓰기" >  
		  <input type="reset" value="다시작성">
		  <input type="button" value="목록보기" OnClick="window.location='board.jsp'"></td>
	  </tr>
	</table>   

 <%
  }catch(Exception e){}
%>  

<center>
