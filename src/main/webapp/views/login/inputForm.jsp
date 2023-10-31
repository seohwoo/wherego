<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title> 어디 Go 회원가입</title>
</head>


<body>
	<jsp:include page="/views/main/nav.jsp" />	
	<jsp:include page="/views/main/title.jsp" />


<br />
<h3 align="center">✔회원가입✔</h3> <br />


<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt()" style="margin: auto; width: 400px;">
	<table>
	
	<tr>
		<td>
		<div class="input-group mb-3">
		 <span class="input-group-text">이름</span>
		<input type="text" class="form-control" name="name" required="required">
		</div>
		</td>	
	</tr>	
	
	<tr>
		<td>	
			<div class="input-group mb-3">
			<span class="input-group-text">닉네임</span>
				<input type="text"  class="form-control" name="nic"> 
				<input class="btn btn-outline-secondary" type="button" name="confirm_nic" value="닉네임 중복확인" 
		        	OnClick="DuplicateNic(this.form)" required="required">
	        </div>
         </td>
	</tr>
	
	<tr>
		<td> 
			<div class="input-group mb-3">
			<span class="input-group-text">아이디</span>
				<input type="text" class="form-control" name="id" required="required">
				<input class="btn btn-outline-secondary" type="button" name="confirm_id" value="아이디 중복확인" 
		        	OnClick="DuplicateID(this.form)">
        	</div>

       	</td>
	</tr>
		
	<tr>

		<td >
			<div class="input-group mb-3">
				<span class="input-group-text">비밀번호</span>
				<input type="password" class="form-control" name="pw" required="required">
			</div>

		</td>	
	</tr>

	
	<tr>

		<td>
			<div class="input-group mb-3">	
				<span class="input-group-text">생년월일</span>
				<input type="date" class="form-control" name="birth" required="required"> 
			</div>	
		</td>
	</tr>
	
	<tr>
		<td>	
			<div>	
				<input class="form-check-input" type="radio"  name="gender" value="남자" required="required"> &nbsp;
				<label class="form-check-label" > 남성</label> &nbsp;
				<input class="form-check-input" type="radio" name="gender" value="여자" required="required"> &nbsp;
				<label class="form-check-label" > 여성</label>
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			<div class="input-group mb-3">	
				<input type="text" class="form-control" id="sample5_address" name="address" required="required" > 
				<input type="button" class="btn btn-outline-secondary" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
			</div>
			<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
			<div class="input-group mb-3">	
			<input type="text" class="form-control"  name="addressDetail" required="required" placeholder="상세주소" >
			</div>
		</td>
	</tr>
		
	<tr>
	<td>
		<span class="input-group-text">이메일</span>
			<div class="input-group mb-3">
			  <input type="text" class="form-control" name="email">
			  <span>@</span>
				  <select class="form-select form-select-sm" name = "emailOption">
			        <option selected>이메일 입력</option>
			        <option  value="gmail.com">gmail.com</option>
			        <option  value="naver.com">naver.com</option>
			        <option value="nate.com">nate.com</option>
			        <option value="daum.net">daum.net</option></td>
		        </select>
			</div>
	</td>
	</tr>
	
	
	
	<tr>
		<td width="400">	
		<span class="input-group-text">전화번호</span>
		<input type="text"  class="form-control" name="phone"required="required"> </td>
	</tr>
	

	
	</table>
	<br />
	<div class="text-center">
	 	<input class="btn btn-outline-success" type="submit" name="confirm" value="가입하기" >
	    <input class="btn btn-outline-warning" type="reset" name="reset" value="다시입력">
	    <input class="btn btn-outline-danger" type="button" value="가입안함" onclick="window.location.href='/wherego/views/main/main.jsp'">
	</div>

</form>

	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />
</body>
<script>

   
   function DuplicateID(userinput){ // 아이디 중복체크
	   if (userinput.id.value == "") {
           alert("아이디를 입력하세요");
           return;
   }
	   url = "confirmId.jsp?id="+userinput.id.value ;
	   open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
   }
   
   
	function DuplicateNic (userinput){ // 닉네임 중복체크
		if (userinput.nic.value == "") {
	           alert("닉네임을 입력하세요");
	           return;
   }
		 url = "confirmNIC.jsp?nic="+userinput.nic.value ;
		   open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
	   }
  
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a9d59c81d3321fd7e3b885e4c1f6fcc&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;

                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords);
                    }
                });
            }
        }).open();
    }

</script>
</html>