<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <!-- spring을 활용한 예외처리를 위한 taglib -->
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
</head>

<script type="text/javascript">
$(document).ready(function(){

	// 아이디 중복체크 클릭했을 때 
	$('#idCheck').on("click",function(){
		let inputId = $('#userId').val();
		
		console.log(inputId);
		
		if(inputId){
			$.ajax({ 
				url :  "${pageContext.request.contextPath}/idCheck"
				, type : "post"
				, data : {
					id : inputId
				}
				, success : callback
				, error : function(){
					//alert("Ajax Error")
				}
			});
		}
	});
	
	// 입력 결과 화면
	$('.result').hide();
	
	
	
});

// 아이디 중복체크 결과
function callback(result){

	if(result > 0){
		$('#idCheck').text('사용불가');
	}
	else{
		$('#idCheck').text('사용가능');
		$('#idResult').show();
	}
}
</script>
<style>
.error {
	color: red;
    font-size: 0.8rem;
    font-family: 'Pretendard';
}
.result{
	color: green;
    font-size: 0.8rem;
    font-family: 'Pretendard';
}
</style>

<body class="g-sidenav-show  bg-gray-100">

  <!-- Navbar -->
  <jsp:include page="/WEB-INF/jsp/inc/main/navbar.jsp"/>
  <!-- End Navbar -->
  
  
  
  
  
  
  <section class="min-vh-100 mb-8">
  
  
  
  
  	<!-- Start 상단 title -->
    <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('${pageContext.request.contextPath}/resources/assets/img/curved-images/curved14.jpg');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-5 text-center mx-auto">
            <h1 class="text-white mb-2 mt-5">Hana Global Pay !</h1>
            <p class="text-lead text-white">해외직구는 하나 글로벌 페이와 함께</p>
          </div>
        </div>
      </div>
    </div>
    <!-- End 상단 title -->
    
    
    
    
    
    
<!-- Start Container -->
    <div class="container">
      <div class="row mt-lg-n10 mt-md-n11 mt-n10">
        <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
          <div class="card z-index-0">
            <div class="card-header pb-0 text-center bg-transparent">
              <h3 class="font-weight-bolder text-info text-gradient">회원 가입</h3>
              <!-- <p class="mb-0">Enter your email and password to sign in</p> -->
            </div>
            
            <div class="card-body">
			<form:form role="form text-left" method="post" modelAttribute="memberVO">
              	<s:csrfInput/>
				<form:errors path="id" class="error"/>
				<span class="result" id="idResult">
					<i class="ni ni-check-bold"></i>
					사용가능한 id입니다.
				</span>
              	<div class="input-group mb-3">
				  <form:input path="id" type="text" class="form-control" placeholder="ID" id="userId" aria-label="id" aria-describedby="button-addon2"/>
				  <button class="btn btn-outline-dark mb-0" type="button" id="idCheck">중복확인</button>
				</div>
				
                <form:errors path="password" class="error"/>
                <span class="result" id="pwResult">
					<i class="ni ni-check-bold"></i>
					사용가능한 비밀번호입니다.
				</span>
				<div class="mb-3">
                  <form:input path="password" type="password" class="form-control" 
                  			placeholder="Password" aria-label="Password" aria-describedby="password-addon"/>
                </div>
                
                
                <form:errors path="password" class="error"/>
                <span class="result" id="pwCheckResult">
					<i class="ni ni-check-bold"></i>
					비밀번호가 일치합니다.
				</span>
                <div class="mb-3">
                  <input id="password2" type="password" class="form-control" 
                  			placeholder="Password 확인" aria-label="PasswordCheck" aria-describedby="password-addon"/>
                </div>
                
                <form:errors path="name" class="error"/>	
                <div class="mb-3">
                  <form:input path="name" type="text" class="form-control" 
                  		placeholder="Name" aria-label="Name" aria-describedby="email-addon"/>
                </div>
                
                <form:errors path="email" class="error"/>
                <span class="result" id="emailResult">
					<i class="ni ni-check-bold"></i>
					사용 가능한 이메일입니다.
				</span>	
                <div class="mb-3">
                  <form:input path="email" type="email" class="form-control" placeholder="Email" aria-label="Email" aria-describedby="email-addon"/>
                </div>
                
                <form:errors path="phone" class="error"/>	
                <span class="result" id="phoneResult">
					<i class="ni ni-check-bold"></i>
					사용 가능한 전화번호입니다.
				</span>	
                <div class="input-group mb-3">
				  <form:input path="phone" type="text" class="form-control" placeholder="휴대폰 번호" aria-label="Tel" aria-describedby="button-addon2"/>
				  <button class="btn btn-outline-dark mb-0" type="button" id="button-addon2">본인인증</button>
				</div>
                
                
                
                <div class="form-check form-check-info text-left">
                  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked>
                  <label class="form-check-label" for="flexCheckDefault">
                    I agree the <a href="javascript:;" class="text-dark font-weight-bolder">Terms and Conditions</a>
                  </label>
                </div>
                <div class="text-center">
                  <form:button type="submit" class="btn bg-gradient-dark w-100 my-4 mb-2">Sign up</form:button>
                </div>
                <p class="text-sm mt-3 mb-0">Already have an account? <a href="javascript:;" class="text-dark font-weight-bolder">Sign in</a></p>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>
<!-- End Container -->   
    
    
    
  </section>
  
  
  
  
  
  <!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <jsp:include page="/WEB-INF/jsp/inc/main/footer.jsp"/>
  <!-- -------- END FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->

  <!--   Core JS Files   -->
  <jsp:include page="/WEB-INF/jsp/inc/common/script.jsp"/>
</body>

</html>