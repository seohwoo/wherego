<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.member.MemberDAO" %>
<%@ include file="/views/login/color.jsp"%>
<html>
<head>
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
    String id = (String)session.getAttribute("memId");
	String pw  = request.getParameter("pw");
	
	MemberDAO manager = MemberDAO.getInstance();
    int check = manager.deleteMember(id,pw);
	
	if(check==1){
		session.invalidate();
%>
<body bgcolor="<%=bodyback_c%>">
<form method="post" action="/team02/views/main/main.jsp" name="userinput" >
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="<%=title_c%>"> 
    <td height="39" align="center">
	  <font size="+1" ><b>회원정보가 삭제되었습니다.</b></font></td>
  </tr>
  <tr bgcolor="<%=value_c%>">
    <td align="center"> 
      <p>그동안 저희 어디GO를 이용해 주셔서 감사합니다.</p>
      <meta http-equiv="Refresh" content="5;url=/team02/views/main/main.jsp" >
    </td>
  </tr>
  <tr bgcolor="<%=value_c%>">
    <td align="center"> 
      <input type="submit" value="확인">
    </td>
  </tr>
</table>
</form>
<%}else {%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}%>

</body>
</html>
