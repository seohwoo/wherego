<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

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



<body >

<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt()">
	<table width="600" border="1" cellspacing="3" cellpadding="3" align="center">
	<tr>
		<td colspan="2" height="39" align="center" >
		<font size= "+2"><b>회원가입 양식</b></font>
		</td>
	</tr>
	
	<tr>
		<td width="200" bgcolor=> 아이디 </td>
		<td width="400" > 
		<input type="text" name="id" size="20" maxlength="12" required="required">
		<input type="button" name="confirm_id" value="ID중복확인" 
        	OnClick="DuplicateID(this.form)">
       	</td>
	</tr>
		
	<tr>
		<td width="200" > 비밀번호 </td>
		<td width="400" >
		<input type="password" name="pw" size="20" maxlength="12" required="required">
		</td>	
	</tr>
	
	<tr>
		<td width="200" > 이름 </td>
		<td width="400">
		<input type="text" name="name" size="20" maxlength="12" required="required"> </td>	
	</tr>
	
	<tr>
		<td width="200" > 닉네임 </td>
		<td width="400" >	
		<input type="text" name="nic" size="20" maxlength="10"> 
		<input type="button" name="confirm_nic" value="닉네임 중복확인" 
        	OnClick="DuplicateNic(this.form)" required="required">
         </td>
	</tr>
	
	<tr>
		<td width="200" > 생년월일 </td>
		<td width="400" >	
		<input type="date" name="birth" size="20" maxlength="12" required="required"> </td>
	</tr>
	
	<tr>
		<td width="200" > 성별 </td>
		<td width="400" >	
		남성<input type="radio" name="gender" value="남자" required="required"> 
		여성<input type="radio" name="gender" value="여자" required="required"> 
		
		</td>
	</tr>
	
	<tr>
		<td width="200" > 주소 </td>
		<td width="400" >	
		<input type="text" name="address" size="30" maxlength="30" required="required"> </td>
		
	</tr>
		
	<tr>
		<td width="200" > 이메일 </td>
		<td width="400" >
		<input type="email" name="email" size="20" maxlength="20" required="required"> </td>	
	</tr>
	
	<tr>
		<td width="200" > 전화번호 </td>
		<td width="400" >	
		<input type="text" name="phone" size="20" maxlength="12" required="required"> </td>
	</tr>
	

	

		<td colspan="2" align="center" > 
	        <input type="submit" name="confirm" value="등   록" >
	        <input type="reset" name="reset" value="다시입력">
	        <input type="button" value="가입안함" onclick="window.location='/team02/views/main/main.jsp'">
     	</td>
	
	</table>
</form>
</body>
</html>