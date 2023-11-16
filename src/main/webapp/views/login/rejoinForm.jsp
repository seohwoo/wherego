<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "team02.member.MemberDAO" %>
<%@ page import = "team02.member.MemberDTO" %>
<%@ include file="/views/login/color.jsp"%>
<% request.setCharacterEncoding("UTF-8");%>

<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title> 어디 Go 회원 재등록</title>
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
<h3 align="center">✔회원정보 재등록✔</h3> <br />

<form method="post" action="rejoinPro.jsp" name="userinput" onsubmit="return checkIt()" style="margin: auto; width: 400px;">

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
        	<input type="text"  class="form-control" name="nic" maxlength="15" value="<%=c.getNic()%>">
        	<input class="btn btn-outline-secondary" type="button" name="confirm_nic" value="닉네임 중복확인" 
		        	OnClick="DuplicateNic(this.form)" required="required">
		        	<small>닉네임은 15자 이하여야 합니다.</small>
        	</div>
      </td>
    </tr>
    
    <tr> 
     	<td>
     		<div class="input-group mb-3">
			<span class="input-group-text">비밀번호</span>
			<input type="password" class="form-control" name="pw" required pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@*_.\-])[A-Za-z\d!@*_.\-]{6,12}$">
    		<small>비밀번호는 영어 대문자, 소문자, 숫자, 특수문자(!@*_.-)를 각각 1자 이상 포함하여 6자 이상 12자 이하여야 합니다.</small>
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
			<input type="text" class="form-control"  name="addressDetail" value="<%=c.getAddress() %>" placeholder="상세주소" required>
			</div>
		</td>
	</tr>
    
    <tr>
    	<td>
   			<div class="input-group mb-3">
			<span class="input-group-text">이메일</span>
			<input type="text" class="form-control" name="email" value="<%=c.getEmail()%>">
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
	 	<input class="btn btn-outline-success" type="submit" name="confirm" value="재등록" >
	    <input class="btn btn-outline-warning" type="reset" name="reset" value="취  소" onclick="javascript:window.location='/wherego/views/login/logout.jsp'">
	</div>
 
</form>

	<br/>
	<hr />
	<br/>
		<jsp:include page="/views/main/footer.jsp" />
</body>

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




<script>
//닉네임 중복확인 버튼 클릭 시
function DuplicateNic(userinput) {
    if (userinput.nic.value === "") {
        alert("닉네임을 입력하세요");
        return;
    }
    url = "confirmNIC.jsp?nic=" + userinput.nic.value;
    open(url, "confirm", "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
    setNicConfirmed(true); // 닉네임 중복확인 설정
}

</script>
</html>
