<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "team02.member.MemberDAO" %>
<%@ include file="/views/login/color.jsp"%>

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<title>아이디 중복확인</title>
</head>
<% request.setCharacterEncoding("UTF-8");%>

<%
	String id = request.getParameter("id");
	MemberDAO manager = MemberDAO.getInstance();
	int check = manager.confirmId(id);
%>

<body bgcolor="666699">
<%
    if(check == 1) {
%>

<table width="270" border="0" cellspacing="0" cellpadding="5">

  <tr bgcolor="CCCCFF"> 
    <td height="39" ><%=id%> (은)는 이미 사용중인 아이디입니다.</td>

  </tr>
</table>

<form name="checkForm" method="post" action="confirmId.jsp">
<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td  align="center"> 

       <p><em>다른 아이디를 선택하세요.</em></p>
       <div class="input-group mb-3">
       <input class="form-control" type="text"  name="id" required pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$"> 
       <input class="btn btn-outline-dark" type="submit" value="중복확인" >
       <small>아이디는 영어와 숫자를 포함하여 6자 이상 12자 이하여야 합니다.</small>
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
      <p>입력하신 <%=id%> (은)는 사용하실 수 있는 ID입니다. </p>
      <input class="btn btn-outline-dark" type="button" value="닫기" onclick="setid()">
    </td>
  </tr>
</table>
<%
    }
%>
</body>
</html>
<script language="javascript">
  
  function setid() {		
	  opener.document.userinput.id.value="<%=id%>";	
	  opener.document.userinput.idCheck.value="1";
	  self.close();	  
  }
</script>