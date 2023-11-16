<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/views/login/color.jsp"%>
<html>
<head>
	<link href="/wherego/views/mypage/mypage.css" rel="stylesheet" type="text/css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>회원탈퇴</title>
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
<body onload="begin()" >
<form name="myform" action="deletePro.jsp" method="post" onSubmit="return checkIt()">
<table >
   
  <tr height="30">
    <td colspan="2">
	  <label class="form-label" >탈퇴하시겠습니까?</label>
  
  <tr height="30">
  	<td>
  		<div class="input-group mb-3">
			<span class="input-group-text">비밀번호</span>
			<input type="password" class="form-control" name="pw">
		</div>
	</td>
  <tr height="30">
    <td colspan="2">
      <input type=submit class="btn btn-outline-danger" value="회원탈퇴"> 
      <input type="button" class="btn btn-outline-danger" value="취  소" onclick="javascript:window.location='/wherego/views/main/main.jsp'"></td></tr>
</table>
</form>
</body>
</html>
    