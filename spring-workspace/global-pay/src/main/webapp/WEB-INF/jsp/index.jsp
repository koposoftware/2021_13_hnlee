<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
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
            <h1 class="text-white mb-2 mt-5">
            	<spring:message code="hello" text="안녕하세요" />
            </h1>
            <p class="text-lead text-white">
            	<spring:message code="intro" text="해외직구는 하나 사는 가격에, 두 개 살 수 있는 하나 글로벌 페이에서!" />
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- End 상단 title -->
    
    
    
    
    
<!-- Start Container -->
    <div class="container">
      <div class="row mt-lg-n10 mt-md-n11 mt-n10">
      <div class="col-xl-8 col-lg-5 col-md-7 mx-auto">
      	<div class="card z-index-0">
      		<div class="card-body">
	      		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			      <ol class="carousel-indicators">
			        <li data-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
			        <li data-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
			        <li data-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
			      </ol>
			      <div class="carousel-inner">
			        <div class="carousel-item active">
			          <img class="d-block w-100" src="${path }/resources/assets/img/shopping/main0.png" alt="First slide">
			        </div>
			        <div class="carousel-item">
			          <img class="d-block w-100" src="${path }/resources/assets/img/shopping/main2.png" alt="Second slide">
			        </div>
			        <div class="carousel-item">
			          <img class="d-block w-100" src="${path }/resources/assets/img/shopping/main1.jpeg" alt="Third slide">
			        </div>
			      </div>
			      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
			        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			        <span class="sr-only">Previous</span>
			      </a>
			      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
			        <span class="carousel-control-next-icon" aria-hidden="true"></span>
			        <span class="sr-only">Next</span>
			      </a>
			    </div>
		    </div>
      	</div>
      </div>
        <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
          <div class="card z-index-0 mb-3">
            <div class="card-header pb-0 text-center bg-transparent">
              <h3 class="font-weight-bolder text-info text-gradient">
              	<spring:message code="q1" text="어떤 혜택이 있나요?" />
              </h3>
            </div>

			<div class="card-body">
			   <span>
			   		<spring:message code="a1" text="하나 글로벌 페이를 이용하여 카드에 49개국 외화를 미리 충전하고 충전된 외화로 수수료 없이 해외 결제하는 외화 충전/ 결제 서비스 입니다." />
              </span>
			</div>

          </div>
          <div class="card z-index-0 mb-3">
            <div class="card-header pb-0 text-center bg-transparent">
              <h3 class="font-weight-bolder text-info text-gradient">
			   		<spring:message code="q2" text="언제든지 환전이 가능한가요?" />
			  </h3>
            </div>

			<div class="card-body">
			   <span>
			   		<spring:message code="a2" text="네 맞습니다. 하나 글로벌 페이를 이용하시면 언제, 어디서든 낮은 환율이 왔을 때 바로 충전 가능합니다. 또한 결제시에 해외 수수료가 면제되는 혜택을 누릴 수 있습니다." />
			   </span>
			   

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