<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<title> 회원가입 사이트</title>
<link href="style.css" rel="stylesheet" type="text/css">
 <style>
        body {
            background-color: #ccc; /* 회색 배경 */
            color: #000; /* 블랙 텍스트 색상 */
            font-family: Arial, sans-serif;
        }

        form {
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
            background-color: #FFE08C; /* 배경 색상을 #FFE08C으로 변경 */
            padding: 20px;
        }

        table {
            width: 100%;
            border: 1px solid #555;
            border-collapse: collapse;
        }

        table td {
            padding: 10px;
            border: 1px solid #555;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            background-color: #fff; /* 백그라운드 색상을 흰색으로 변경 */
            border: 1px solid #555;
            color: #000; /* 텍스트 색상을 블랙으로 변경 */
        }

        input[type="submit"],
        input[type="reset"],
        input[type="button"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover,
        input[type="button"]:hover {
            background-color: #0056b3;
        }
    </style>

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
		</td>
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
		<input type="password" name="pw" size="20" maxlength="12" required="required">
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
		<input type="date" name="birth" size="20" maxlength="12" required="required"> </td>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 성별 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		남성<input type="radio" name="gender" value="남자" required="required"> 
		여성<input type="radio" name="gender" value="여자" required="required"> 
		
		</td>
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 주소 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="text" name="address" size="30" maxlength="30" required="required"> </td>
		
	</tr>
		
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 이메일 </td>
		<td width="400" bgcolor="<%=value_c%>">
		<input type="email" name="email" size="20" maxlength="20" required="required"> </td>	
	</tr>
	
	<tr>
		<td width="200" bgcolor="<%=value_c%>"> 전화번호 </td>
		<td width="400" bgcolor="<%=value_c%>">	
		<input type="text" name="phone" size="20" maxlength="12" required="required"> </td>
	</tr>
	

	

		<td colspan="2" align="center" bgcolor="<%=value_c%>"> 
	        <input type="submit" name="confirm" value="등   록" >
	        <input type="reset" name="reset" value="다시입력">
	        <input type="button" value="가입안함" onclick="window.location='/team02/views/main/main.jsp'">
     	</td>
	
	</table>
</form>
</body>
</html>