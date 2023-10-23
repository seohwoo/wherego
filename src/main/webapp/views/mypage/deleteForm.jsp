<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/views/login/color.jsp"%>>
<html>
<head><title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
   <script language="javascript">
       function begin(){
         document.myform.pw.focus();
       }

       function checkIt(){
		  if(!document.myform.pw.value){
           alert("비밀번호를 입력하지 않으셨습니다.");
           document.myform.pw.focus();
           return false;
         }
	   }   
   </script>
</head>
<BODY onload="begin()" >
<form name="myform" action="deletePro.jsp" method="post" onSubmit="return checkIt()">
<TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
  
  <TR height="30">
    <TD colspan="2" align="middle" >
	  <font size="+1" ><b>회원 탈퇴</b></font></TD></TR>
  
  <TR height="30">
    <TD width="110"  align=center>비밀번호</TD>
    <TD width="150" align=center>
      <INPUT type=password name="pw"  size="15" maxlength="12"></TD></TR>
  <TR height="30">
    <TD colspan="2" align="middle" >
      <INPUT type=submit value="회원탈퇴"> 
<<<<<<< HEAD
      <input type="button" value="취  소" onclick="javascript:window.location='/team02/views/mypage/myPage.jsp'"></TD></TR>
=======
      <input type="button" value="취  소" onclick="javascript:window.location='/wherego/views/main/main.jsp'"></TD></TR>
>>>>>>> branch 'feature/5' of https://git@github.com/seohwoo/wherego.git
</TABLE>
</form>
</BODY>
</HTML>
    