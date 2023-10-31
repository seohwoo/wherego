<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ page import = "team02.member.MemberDTO" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title> 어디 Go 회원정보 수정</title>
</head>
<body>
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" />
	
	<br />
	
<%
	String id = (String)session.getAttribute("memId");
		
	MemberDAO manager = MemberDAO.getInstance();
	MemberDTO c = manager.getMember(id); 
%>
<h3 align="center">✔회원정보 수정✔</h3> <br />

<form method="post" action="updatePro.jsp" name="userinput" onsubmit="return checkIt()" style="margin: auto; width: 400px;">

	<table>
	<tr>

		<td>
		<div class="input-group mb-3">
		 <span class="input-group-text">이름</span>
		<input type="text" class="form-control" name="name" value="<%=c.getName()%>">
		</div>
		</td>	
	</tr>
    
    <tr>
    	<td> 
    		<div class="input-group mb-3">
			<span class="input-group-text">닉네임</span>
        	<input type="text"  class="form-control" name="nic" value="<%=c.getNic()%>">
        	</div>
      </td>
    </tr>
    
     <tr> 
     	<td>
     		<div class="input-group mb-3">
			<span class="input-group-text">아이디</span>
			<input type="text" class="form-control" name="id" value="<%=c.getId()%>" readonly>
    		</div>
  		</td>
	</tr>
    
    <tr> 
     	<td>
     		<div class="input-group mb-3">
			<span class="input-group-text">비밀번호</span>
			<input type="password" class="form-control" name="pw" required>
    		</div>
  		</td>
	</tr>

	<tr>
		<td>
			<div class="input-group mb-3">	
				<input type="text" class="form-control" id="sample5_address" name="address"  > 
				<input type="button" class="btn btn-outline-secondary" onclick="sample5_execDaumPostcode()" value="주소 검색" required><br>
			</div>
			<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
			<div class="input-group mb-3">	
			<input type="text" class="form-control"  name="addressDetail" placeholder="상세주소" required>
			</div>
		</td>
	</tr>
    
    <tr>
    	<td>
   			<div class="input-group mb-3">
			<span class="input-group-text">이메일</span>
			<%if(c.getEmail()==null){%>
		  	<input type="text" class="form-control" name="email" >
			<%}else{%>
			<input type="text" class="form-control" name="email" value="<%=c.getEmail()%>">
			<%} %>
    		</div>
   		</td>
	</tr>
    
    <tr>
		<td width="400">	
		<span class="input-group-text">전화번호</span>
		<input type="text"  class="form-control" name="phone" value="<%=c.getPhone()%>"> </td>
	</tr> 
 </table>
 <br />
	<div class="text-center">
	 	<input class="btn btn-outline-success" type="submit" name="confirm" value="수   정" >
	    <input class="btn btn-outline-warning" type="reset" name="reset" value="취  소" onclick="javascript:window.location='/wherego/views/mypage/myPage.jsp?id=<%=id%> '">
	</div>
 
</form>

	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />
</body>
</html>






























