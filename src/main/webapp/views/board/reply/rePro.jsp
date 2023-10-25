<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="team02.askReply.ReplyDAO" %>
<%@ page import="team02.askReply.ReplyDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // boardnum과 ref 파라미터를 정수로 변환
    int boardnum = Integer.parseInt(request.getParameter("boardnum"));
    int ref = Integer.parseInt(request.getParameter("ref"));
    
    // boardnum와 ref 값을 댓글 객체에 설정
    ReplyDTO dto = new ReplyDTO();
    dto.setBoardnum(boardnum);
    dto.setId(request.getParameter("id"));
    dto.setWriter(request.getParameter("writer"));
    dto.setContent(request.getParameter("content"));
    dto.setRef(ref);

    ReplyDAO dao = ReplyDAO.getInstance();
    dao.insertReply(dto);

    response.sendRedirect("/wherego/views/board/ask/askList.jsp");
%>
