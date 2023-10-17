<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.land.LandDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>평점 주기</title>
    <style>
        .stars1 {
        	padding-left:70px;
            font-size: 30px;
            cursor: pointer;
        }
        .stars1 .star {
            color: gray;
        }
        .stars1 .star.active {
            color: yellow;
            text-shadow: 2px 2px 1px gray;
        }
    </style>
</head>
<body>

<%
	String contentid = request.getParameter("contentid");
	String areaCode = request.getParameter("areaCode");
	String sigunguCode = request.getParameter("sigunguCode");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String id = (String)session.getAttribute("memId");
%>
<form method="post" action = "randStarInsertPro.jsp?areaCode=<%=areaCode%>&sigunguCode=<%=sigunguCode%>&contentid=<%=contentid%>&pageNum=<%=pageNum%>"  OnSubmit = "return validateAndSubmit()">

    <div class="stars1">
        <span class="star">&#9733;</span>
        <span class="star">&#9733;</span>
        <span class="star">&#9733;</span>
        <span class="star">&#9733;</span>
        <span class="star">&#9733;</span>
    </div>
    <div>
        <label for="stars1">평점: </label>
        <input type="radio" name="stars" value="0"> 0
        <input type="radio" name="stars" value="1"> 1
        <input type="radio" name="stars" value="2"> 2
        <input type="radio" name="stars" value="3"> 3
        <input type="radio" name="stars" value="4"> 4
        <input type="radio" name="stars" value="5"> 5
    </div>





    <script>
        const stars = document.querySelectorAll('.stars1 .star');
        const radioButtons = document.querySelectorAll('input[name="stars"]');

        radioButtons.forEach((radio, index) => {
            radio.addEventListener('change', () => {
                const starsValue = radio.value;
                for (let i = 0; i < stars.length; i++) {
                    stars[i].classList.remove('active');
                }
                for (let i = 0; i < starsValue; i++) {
                    stars[i].classList.add('active');
                }
            });
        });
	
        
        function validateAndSubmit() {
            const selectedStars = document.querySelector('input[name="stars"]:checked');
            if (!selectedStars) {
            	const popupWindow = window.open('', 'popupWindow', 'width=180, height=30,resizable=no,scrollbars=no,status=no,toolbar=no');
                popupWindow.document.write('<p>평점을 선택해주세요.</p>');
                return false;
            } else {
                return true;
            }
        }
        
        
      
    </script>
    
 
    
    평가
    <br/>
	<textarea name="comments" rows="3" cols="50" placeholder="50자 내로 적어주세요. (입력하지 않으셔도 됩니다.)"></textarea><br/>
    <input type="submit" name="confirm" value="등록">
    <input type="button" value="닫기" OnClick="window.close();">
    </form>
    

</body>
</html>

