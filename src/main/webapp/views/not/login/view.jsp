<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ page import = "team02.member.MemberDTO" %>

<%
	String id = (String)session.getAttribute("memId");
	MemberDAO dao = MemberDAO.getInstance();

	MemberDTO dto =  dao.getMember(id);
%>

<h3><%= dto.getId()%></h3>
<h3><%= dto.getBirth()%></h3>
<h3><%= dto.getEmail()%></h3>
<h3><%= dto.getAddress()%></h3>
<h3><%= dto.getGender()%></h3>
<h3><%= dto.getName()%></h3>
<h3><%= dto.getNic()%></h3>
<h3><%= dto.getPhone()%></h3>
<img src="<%= dto.getProfile()%>"  width="100" height="100"/>
<h3><%= dto.getReg_date()%></h3>
