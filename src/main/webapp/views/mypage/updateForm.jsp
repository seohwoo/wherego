<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ page import = "team02.member.MemberDTO" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>



<title>어디 GO 회원정보 수정</title>



<%
	String id = (String)session.getAttribute("memId");
		
	MemberDAO manager = MemberDAO.getInstance();
	MemberDTO c = manager.getMember(id); 
	try{
%>
<body >
<form method="post" action="updatePro.jsp" name="userinput" onsubmit="return checkIt()">

	<table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
	
    <tr > 
      <td  colspan="2" height="39"  align="center">
	     <font size="+1" ><b>어디 GO 회원 정보수정</b></font></td>
    </tr>
    
    <tr>
      <td colspan="2" class="normal" align="center">회원의 정보를 수정합니다.</td>
    </tr>
    
     <tr> 
      <td width="200" ><b>아이디 입력</b></td>
      <td width="400" >&nbsp;</td>
    <tr>  
	
	<tr> 
      <td  width="200"> 사용자 ID</td>
      <td  width="400"><%=c.getId()%></td>
    </tr>
    
     <tr> 
      <td width="200"> 비밀번호</td>
      <td width="400"> 
        <input type="password" name="pw" size="20" maxlength="12" value="<%=c.getPw()%>">
      </td>
    </tr>  

	 <tr> 
      <td  width="200" ><b>개인정보 수정사항</b></td>
      <td width="400" >&nbsp;</td>
    </tr>  

	 <tr> 
      <td   width="200">사용자 이름</td>
      <td  width="400"> 
        <input type="text" name="name" size="20" maxlength="12" value="<%=c.getName()%>">
      </td>
    </tr>
    
    <tr> 
      <td   width="200">사용자 닉네임</td>
      <td  width="400"> 
        <input type="text" name="nic" size="20" maxlength="10" value="<%=c.getNic()%>">
      </td>
    </tr>
    
    <tr> 
      <td   width="200">주 소</td>
      <td  width="400"> 
        <input type="text" name="address" size="30" maxlength="30" value="<%=c.getAddress()%>" >
     
      </td>
    </tr>
    
    
    
    <tr> 
      <td width="200">E-Mail</td>
      <td width="400">
	    <%if(c.getEmail()==null){%>
		  <input type="text" name="email" size="40" maxlength="30" >
		<%}else{%>
          <input type="text" name="email" size="40" maxlength="30" value="<%=c.getEmail()%>">	
		<%}%>
      </td>
    </tr>
    
    <tr> 
      <td   width="200">전화번호</td>
      <td  width="400"> 
        <input type="text" name="phone" size="20" maxlength="12" value="<%=c.getPhone()%>">
      </td>
    </tr>
    
    
   
    
	<tr> 
      <td colspan="2" align="center"> 
       <input type="submit" name="sujung" value="수   정" >
       <input type="button" value="취  소" onclick="javascript:window.location='/wherego/views/mypage/myPage.jsp'">      
      </td>
    </tr>

	  </table>
</form>
</body>
<%}catch(Exception e){}%>
</html>






























