<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/views/not/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>
<html>
<haed>
<title> 회원가입 사이트</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">

   
   function DuplicateID(userinput){ // 아이디 중복체크
	   if (userinput.id.value == "") {
           alert("아이디를 입력하세요");
           return;
   }
	   url = "confirmId.jsp?id="+userinput.id.value ;
	   open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
   }
   
   
	function DuplicateNic (userinput){ // 닉네임 중복체크
		if (userinput.nic.value == "") {
	           alert("닉네임을 입력하세요");
	           return;
   }
		 url = "confirmNIC.jsp?nic="+userinput.nic.value ;
		   open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
	   }
  
</script>



<body bgcolor="<%=green_g%>">

<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt()">
	<table width="600" border="1" cellspacing="3" cellpadding="3" align="center">
	<tr>
		<td colspan="2" height="39" align="center" bgcolor="<%=yellow_y%>">
		<font size= "+2"><b>회원가입 양식</b></font>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 아이디 </td>
		<td width="400" bgcolor="<%=value_c%>"> 
		<input type="text" name="id" size="20" maxlength="12" required="required">
		<input type="button" name="confirm_id" value="ID중복확인" 
        	OnClick="DuplicateID(this.form)">
       	</td>
	</tr>
		
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 비밀번호 </td>
		<td width="400" bgcolor="<%=value_c%>">
		<input type="password" name="pw" size="20" maxlength="12">
		</td>	
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 이름 </td>
		<td width="400" bgcolor="<%=value_c%>">
		<input type="text" name="name" size="20" maxlength="12" required="required"> </td>	
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 닉네임 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="text" name="nic" size="20" maxlength="10"> 
		<input type="button" name="confirm_nic" value="닉네임 중복확인" 
        	OnClick="DuplicateNic(this.form)" required="required">
         </td>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 생년월일 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="date" name="birth" size="20" maxlength="12"> </td>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 성별 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		남성<input type="radio" name="gender" value="남자" > 
		여성<input type="radio" name="gender" value="여자" > 
		
		</td>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 주소 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="text" name="address" size="30" maxlength="30"> </td>
		
	</tr>
		
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 이메일 </td>
		<td width="400" bgcolor="<%=value_c%>">
		<input type="email" name="email" size="20" maxlength="20" required> </td>	
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 전화번호 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="text" name="phone" size="20" maxlength="12" required="required"> </td>
	</tr>
	
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 프로필 사진 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="file" name="profile" class="form-control"> </td>
	</tr>
	
	
	

		<td colspan="2" align="center" bgcolor="<%=value_c%>"> 
	        <input type="submit" name="confirm" value="등   록" >
	        <input type="reset" name="reset" value="다시입력">
	        <input type="button" value="가입안함" onclick="#">
     	</td>
	
	</table>
</form>
</body>
</html>