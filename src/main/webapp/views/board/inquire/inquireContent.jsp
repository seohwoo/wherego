<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team02.inquire.board.InquireDAO" %>
<%@ page import="team02.inquire.board.InquireDTO" %>    

<!DOCTYPE html>
<html>
<head>
	<title>어디 Go</title>
</head>
<body>
	<% if(session.getAttribute("memId") == null){%>
		<script>
            alert("로그인하세요 🤬🤬🤬🤬");
            window.location="/wherego/views/board/inquire/inquireList.jsp";
        </script>
	<%}else{
	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	
 	int num = Integer.parseInt(request.getParameter("num"));
 	String pageNum = request.getParameter("pageNum");
	
	String id = (String)session.getAttribute("memId");
	InquireDAO dao = InquireDAO.getInstance();
	InquireDTO dto =  dao.findInquireContent(num);
 	int grade = dao.isAdmin(id);   
  	
  	Date reg_dateD = inputFormat.parse(dto.getReg_date());
	String reg_date = outputFormat.format(reg_dateD);

  	if(grade!=99 && !id.equals(dto.getId())){%>
  		<script>
            alert("작성자 or 관리자만 접근가능!");
            window.location="/wherego/views/board/inquire/inquireList.jsp";
        </script>
  	<%}else{
	%>
	 <jsp:include page="/views/main/nav.jsp" />
	
	<br />
	<div class="text-center">
		<h1>어디 Go</h1>
	</div>
	<br />
	<hr />
	
	<!-- 문의 글 -->
     <h2 align="center">상세문의</h2>
    <br />
	<div align="center">
    	<button type="button" class="btn btn-light" OnClick="window.location='inquireList.jsp'">문의목록 보기</button>
    </div>
    <br />
    <div class="d-grid gap-2 col-6 mx-auto">
	<table class="table table-bordered" width="700" cellpadding="0" cellspacing="0" align="center">
	    <tr>
	      <td align="center"  width="50" ><b>#</b></td>
	      <td align="center"  width="50" ><%=dto.getNum() %></td>
	      <td  align="center"  width="250" ><b>작성자</b></td>
	      <td align="center" width="250"><%=dto.getWriter() %></td>
	     </tr>
	     <tr>
	      <td  align="center"  width="250" ><b>제목</b></td>
	      <td align="center" width="250"><%=dto.getTitle() %></td>
	      <td  align="center"  width="200" ><b>날짜</b></td>
	      <td align="center" width="200"><%=reg_date %></td>
	    </tr>
	    <tr>
	    	<td align="center"><b>문의 내용</b></td>
		    <td colspan="3" align="center"><%=dto.getContent()%></td>
		  </tr>
	</table>
	</div>
		<%if(grade == 99){%>
		<div align="center">
			<button type="button" class="btn btn-outline-info" OnClick="window.location='/wherego/views/board/inquire/inquireForm.jsp?boardnum=<%=dto.getNum()%>&ref=<%=dto.getRef()%>'">답변달기</button>
		    <button type="button" class="btn btn-outline-danger" Onclick="window.location='inquireDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
		    <br />
		</div>
		<%}else if(id.equals(dto.getId())) { %>
		<div align="center">
		    <button type="button" class="btn btn-outline-warning" OnClick="window.location='inquireUpdateForm.jsp?num=<%=num%>'">수정하기</button>
		    <button type="button" class="btn btn-outline-danger" Onclick="window.location='inquireDeleteForm.jsp?num=<%=num%>'">삭제하기</button>
		    <br />
		</div>
		<%} %>
		<br />    
		    
	<h3 align="center">💭 답변 💭</h3>
    <br />

    <% 
    	int cnt = dao.inquireReCnt(dto.getNum());
        if (cnt>0) {
        	ArrayList<InquireDTO> inquireReList = dao.findInquireReList(dto.getNum());
            for (InquireDTO reDto : inquireReList) {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
                <table class="table table-bordered border-primary" width="700" cellpadding="0" cellspacing="0" align="center">
                	<tr>
                		<td align="center" width="250"><b>작성자</b></td>
                		<td align="center" width="250"><%=reDto.getWriter()%></td>
                		<td align="center" width="250"><b>날짜</b></td>
                		<td align="center" width="250"><%=reDto.getReg_date()%></td>
                	</tr>
                	<tr><td align="center" width="250"><b>내용</b>
                	<td colspan="3" align="center"><%=reDto.getContent() %></tr>
                </table>
		</div>
				<%if(grade==99) { %>
				<div align="center">
					<button type="button" class="btn btn-outline-danger" OnClick="window.location='inquireUpdateForm.jsp?num=<%=reDto.getNum()%>'">답변수정</button>
				    <button type="button" class="btn btn-outline-warning" Onclick="window.location='inquireDeleteForm.jsp?num=<%=reDto.getNum()%>'">답변삭제</button>
			    </div>
    			<%}
            }
        } else {
    %>
    	<div class="d-grid gap-2 col-6 mx-auto">
	    	<table class="table table-bordered border-primary" >
	        <tr>
	            <td align="center">답변예정 중 입니다. 조금만 기다려주세요</td>
	        </tr>
	    	</table>
    	</div>
    <% }%>
    <br />
    <div class = "fixed-bottom">
	<br/><hr /><br/>
	</div>
		
	<br />
	<hr />
	<br />
	<jsp:include page="/views/main/footer.jsp" />
<%}
}%>		
</body>
</html>