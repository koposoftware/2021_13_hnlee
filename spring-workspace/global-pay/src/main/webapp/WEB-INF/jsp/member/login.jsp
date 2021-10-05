<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<script type="text/javascript">
$(document).on("ready", function(){
	
	// 권한 선택되었을때 
	$('.roleList li a').on("click", function(){
		role = $(this).data("role");
		$('#role').val(role);
		console.log($('#role').val())
	});
	
});


</script>
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
              <h3 class="font-weight-bolder text-info text-gradient">로그인</h3>
              <!-- <p class="mb-0">Enter your email and password to sign in</p> -->
            </div>

			<div class="card-body">
				<ul class="nav nav-pills nav-fill p-1 roleList" role="tablist">
			      <li class="nav-item">
			         <a class="nav-link mb-0 px-0 py-1 active" 
			         	data-bs-toggle="tab" href="#profile-tabs-simple" role="tab" aria-controls="profile" aria-selected="true"
			         	data-role="user">
			         사용자
			         </a>
			      </li>
			      <li class="nav-item">
			         <a class="nav-link mb-0 px-0 py-1" 
			         	data-bs-toggle="tab" href="#dashboard-tabs-simple" role="tab" aria-controls="dashboard" aria-selected="false"
			         	data-role="admin">
			         관리자
			         </a>
			      </li>
			      <li class="nav-item">
			         <a class="nav-link mb-0 px-0 py-1" 
			         	data-bs-toggle="tab" href="#dashboard-tabs-simple" role="tab" aria-controls="dashboard" aria-selected="false"
			         	data-role="partner">
			         파트너
			         </a>
			      </li>
			   </ul>
			   
			   
				<form:form role="form" method="post" action="${pageContext.request.contextPath}/login">
					<s:csrfInput/>
					<label>아이디</label>
					<div class="mb-3">
						<input name="id" type="id" class="form-control" placeholder="ID"
							aria-label="Id" aria-describedby="email-addon">
					</div>
					<label>비밀번호</label>
					<div class="mb-3">
						<input name="password"  type="Password" class="form-control" placeholder="Password"
							aria-label="Password" aria-describedby="password-addon">
					</div>
					
					
					<!-- 로그인 실패 시 출력할 메세지 -->
					<div class=" text-center mt-0 mb-2">
						<span class="error">
							${requestScope.loginFailMsg}
						</span>
					</div>
					
					
					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" id="rememberMe"
							checked=""> <label class="form-check-label"
							for="rememberMe">아이디 저장</label>
						<input type="hidden" name="role" id="role" value="user">
					</div>
					
					<div class="text-center">
						<button type="submit"
							class="btn bg-gradient-info w-100 mt-4 mb-0">로그인</button>
					</div>
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