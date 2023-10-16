<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.login.MemberShipDAO" %>
<%@ include file="/views/login/color.jsp"%>

<html>
<head><title>닉네임 중복확인</title>
<link href="style.css" rel="stylesheet" type="text/css">
<% request.setCharacterEncoding("UTF-8");%>

<%
	String nic = request.getParameter("nic");
	MemberShipDAO manager = MemberShipDAO.getInstance();
	int check = manager.confirmNIC(nic);  // 아직 dao 안만듬

%>


<body bgcolor="<%=bar%>">
<%
    if(check == 1) {
%>

<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="<%=blue_b%>"> 
    <td height="39" ><%=nic%>이미 사용중인 닉네임입니다.</td>
  </tr>
</table>

<form name="checkForm" method="post" action="confirmNIC.jsp">
<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td bgcolor="<%=back_c%>" align="center"> 
       다른 닉네임을 선택하세요.<p>
       <input type="text" size="10" maxlength="12" name="nic"> 
       <input type="submit" value="닉네임중복확인">
    </td>
  </tr>
</table>
</form>
<%
    } else {
%>
<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="<%=title_c%>"> 
    <td align="center"> 
      <p>입력하신 <%=nic%> (은)는 사용하실 수 있는 닉네임입니다. </p>
      <input type="button" value="닫기" onclick="setnic()">
    </td>
  </tr>
</table>
<%
    }
%>
</body>
</html>
<script language="javascript">
  function setnic()
    {		
    	opener.document.userinput.nic.value="<%=nic%>";
		self.close();
		}
</script>