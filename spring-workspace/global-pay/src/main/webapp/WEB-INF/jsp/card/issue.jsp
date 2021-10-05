<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<!--
=========================================================
* Soft UI Dashboard - v1.0.3
=========================================================

* Product Page: https://www.creative-tim.com/product/soft-ui-dashboard
* Copyright 2021 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://www.creative-tim.com/license)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<!DOCTYPE html>
<html lang="en">

<head>
  <jsp:include page="/WEB-INF/jsp/inc/common/head-content.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>


<script type="text/javascript">
function authorize() {
	
	
	let url = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
			+"response_type=code"
			+"&client_id=f07ebe18-950e-41d5-895d-d7588dac259d"
			+"&redirect_uri=http://localhost:9997/global-pay/callback"
			+"&scope=login inquiry transfer"
			+"&state=b80BLsfigm9OokPTjy03elbJqRHOfGSY"
			+"&auth_type=0";
	
	window.open(url, "width=1200,height=900,scrollbars=yes,resizable=yes");
	
}

$(document).on("ready", function(){
	callbackURL = window.parent.document.URL;
	//alert(callbackURL)
	console.log(callbackURL)
	
	if(callbackURL.indexOf('callback') == -1){
		window.close();
	}
	
});

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

</script>
<body class="g-sidenav-show  bg-gray-100">

  
  <!-- aside start -->
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/aside.jsp"/>
  <!-- aside end -->
  
  
  
  <main class="main-content position-relative max-height-vh-100 h-100 mt-1 border-radius-lg ">
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/jsp/inc/dash-board/navbar.jsp"/>
    <!-- End Navbar -->
    
    
    
    
    
    
<!-- Start container -->
    <div class="container-fluid py-4">
    
    		<!-- START row -->
			<div class="row justify-content-md-center">
			
				<!-- START col-6  -->
				<div class="col-6">
				
					<!-- START card -->
					<div class="card z-index-0">
						<div class="card-header pb-0 text-center bg-transparent">
			              <h3>카드 개설하기</h3>
			              <p class="mb-0">아래 정보를 입력 후 약관에 동의해주세요</p>
			            </div>

						<!-- Start card body -->
						<div class="card-body">
							<button type="button"
									class="btn bg-gradient-dark btn-lg w-100"
									onclick="authorize()">계좌 본인 인증</button>
							
						  <div class="row">
							  <form role="form" method="post" action="${pageContext.request.contextPath}/card/issue">
							  		<s:csrfInput/>
							        <label for="familyName">영문이름</label> 
							        <div class="form-group has-success">
							        	<input name="familyName" type="text" placeholder="영문 성(Family Name)" class="form-control is-valid" />
							        </div>
							     
							        <div class="form-group has-danger">
							        	<input name="givenName" type="text" placeholder="영문 이름(Given Name)" class="form-control is-valid" />
							        </div>
									
									<label for="sample6_postcode">우편번호</label> 
									<div class="input-group mb-3">
									  	<input type="text" class="form-control"
									  		name="zip" id="sample6_postcode" placeholder="우편번호"
									  		aria-label="Recipient's username" aria-describedby="button-addon2"  required>
									  <input class="btn btn-outline-dark mb-0" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"/>
									</div>
									
									
									

									<div class="form-group">
										<label for="sample6_address">주소</label> 
										<input class="form-control" type="text" name="addr1" required id="sample6_address" placeholder="주소">
									</div>

									<div class="form-group">
										<input class="form-control" type="text" id="sample6_extraAddress" placeholder="참고항목">
									</div>

									<div class="form-group">
										<input class="form-control" type="text" name="addr2" required id="sample6_detailAddress" placeholder="상세주소">
									</div>

									<div class="text-center">
								    	<button type="submit" class="btn bg-gradient-info w-100 mt-4 mb-0">신청 완료하기</button>
									</div>
									
							  </form>
						  </div>
						  
						  
						</div>
						<!-- END card body  -->
						
						
					</div>
					<!-- END card -->
				</div>
				<!-- END col-6 -->
				
			</div>
			<!-- END row -->
			</div>
			<!-- END container -->


		<!-- footer start -->
  	  <jsp:include page="/WEB-INF/jsp/inc/dash-board/footer.jsp"/>
      <!-- footer end -->

  </main>
  
  
  <!-- fixed-plugin start -->
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/fixed-plugin.jsp"/>
  <!-- fixed-plugin end -->

  
  
  <!--   Core JS Files  start -->
  <jsp:include page="/WEB-INF/jsp/inc/common/script.jsp"/>
  <!--   Core JS Files  end -->
  
</body>

</html>