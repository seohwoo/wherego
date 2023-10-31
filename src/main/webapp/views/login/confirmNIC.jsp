<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.member.MemberDAO" %>
<%@ include file="/views/login/color.jsp"%>

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<title>닉네임 중복확인</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<% request.setCharacterEncoding("UTF-8");%>

<%
	String nic = request.getParameter("nic");
	MemberDAO manager = MemberDAO.getInstance();
	int check = manager.confirmNIC(nic);  // 아직 dao 안만듬

%>


<body bgcolor="666699">
<%
    if(check == 1) {
%>

<table width="270" border="0" cellspacing="0" cellpadding="5">


  <tr bgcolor="CCCCFF"> 
    <td height="39" ><%=nic%> (은)는 이미 사용중인 닉네임입니다.</td>

  </tr>
</table>

<form name="checkForm" method="post" action="confirmNIC.jsp">
<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td align="center"> 

       <p><em>다른 닉네임을 선택하세요.</em></p>
       <div class="input-group mb-3">
       <input class="form-control" type="text"  name="nic" required="required"> 
       <input  class="btn btn-outline-dark" type="submit" value="중복확인">
       </div>

    </td>
  </tr>
</table>
</form>
<%
    } else {
%>
<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="CCCCFF"> 
    <td align="center"> 
      <p>입력하신 <%=nic%> 는(은) 사용하실 수 있는 닉네임입니다. </p>
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