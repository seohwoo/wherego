<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team02.content.land.LandDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="/wherego/views/main/main.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>평점 주기</title>
</head>
<body>
<%
    String contentid = request.getParameter("contentid");
    String id = (String)session.getAttribute("memId");
    if(id == null){
        %>
        <script>
        alert("로그인후 사용가능합니다.");
        window.close();
        </script>
    <%
    } else {
%>
<form method="post" action="randStarInsertPro.jsp?contentid=<%=contentid%>" enctype="multipart/form-data" OnSubmit="return validateAndSubmit()">
    <div class="stars1">
        <label for="star1" class="star" data-rating="1"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star2" class="star" data-rating="2"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star3" class="star" data-rating="3"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star4" class="star" data-rating="4"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
        <label for="star5" class="star" data-rating="5"> <i class="far fa-star" style="color: #ffc83d;"></i></label>
    </div>

    <div>
        <input type="radio" name="stars" value="1" id="star1" style="display: none;">
        <input type="radio" name="stars" value="2" id="star2" style="display: none;">
        <input type="radio" name="stars" value="3" id="star3" style="display: none;">
        <input type="radio" name="stars" value="4" id="star4" style="display: none;">
        <input type="radio" name="stars" value="5" id="star5" style="display: none;">
    </div>
		
    <br />
    <p style="font-family: 'Pretendard-Regular'">사진을 올려주세요 <small> (선택)</small></p>
    <div style="width:500px;">
        <input type="file" class="form-control" name="img1" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img2" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img3" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img4" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
        <input type="file" class="form-control" name="img5" accept="image/jpeg, image/jpg, image/png, image/gif"/> <br />
    </div>
    <br />
    <p style="font-family: 'Pretendard-Regular'">상세한 후기를 써주세요 </p>
    <textarea name="review" class="form-control" rows="3" cols="50" placeholder="다녀오신 후기를 작성해주시면 방문예정자들에게도 도움이 됩니다."></textarea><br/>
    <input type="submit" class="btn btn-warning" name="confirm" value="등록">
    <input type="button" class="btn btn-light" value="닫기" OnClick="window.close();">
</form>
<%
} %>  
</body>
<script>
const stars = document.querySelectorAll('.stars1 .star');
const radioButtons = document.querySelectorAll('input[name="stars"]');

radioButtons.forEach((radio, index) => {
    radio.addEventListener('change', () => {
        const starsValue = radio.value;
        for (let i = 0; i < stars.length; i++) {
            const sRating = parseInt(stars[i].getAttribute("data-rating"));
            if (sRating <= starsValue) {
                stars[i].innerHTML = '<i class="fas fa-star" style="color: #ffc83d;"></i>';
            } else {
                stars[i].innerHTML = ' <i class="far fa-star" style="color: #ffc83d;"></i>';
            }
        }
    });
});

function validateAndSubmit() {
    const selectedStars = document.querySelector('input[name="stars"]:checked');
    const reviewTextarea = document.querySelector('textarea[name="review"]');
    if (!selectedStars || reviewTextarea.value.trim() === '') {
        alert("평점과 리뷰를 모두 입력했는지 확인해주세요.");
        return false;
    } else {
        return true;
    }
}
</script>
<style>
.stars1 {
    padding-left: 70px;
    font-size: 30px;
    cursor: pointer;
}
.stars1 .star {
	color: #FFA500;
    transition: color 0.3s;
}
</style>
</html>
