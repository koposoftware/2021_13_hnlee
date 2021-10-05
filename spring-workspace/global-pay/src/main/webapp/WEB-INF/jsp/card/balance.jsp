<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

  <!-- aside start -->
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/aside.jsp"/>
  <!-- aside end -->
  
  
  
  <main class="main-content position-relative max-height-vh-100 h-100 mt-1 border-radius-lg ">
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/jsp/inc/dash-board/navbar.jsp"/>
    <!-- End Navbar -->
    
    
    
    
    
<!-- Start container -->
	<div class="container-fluid py-4">
		<nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">카드</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">페이카드</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">잔액 조회</h6>
        </nav>

<!-- row start -->
		<div class="row mt-4">
			<!-- <h4 class="text-center">외화별 잔액</h4>
			<hr class="horizontal dark" /> -->
			<div class="col-12">
				
				<a href="${path }/refund" class="btn btn-link text-dark px-2 mb-0" style="float: right">
					<span class="btn-inner--icon"><i class="ni ni-basket"></i></span>
					<span class="btn-inner--text">환불</span>
				</a>
				<a href="${path }/charge" class="btn btn-link text-dark px-2 mb-0" style="float: right">
					<span class="btn-inner--icon"><i class="ni ni-money-coins"></i></span>
					<span class="btn-inner--text">충전</span>
				</a>
				<button class="btn btn-link text-dark px-2 mb-0" style="float: right">
					<span class="btn-inner--icon"><i class="ni ni-chart-bar-32"></i></span>
					<span class="btn-inner--text">수익률</span>
				</button>
			</div>
			<c:forEach var="vo" items="${balances }" >
				
				<div class="col-xl-3 col-sm-3 mt-xl-0 mb-4 cursor-pointer">
					<div class="card move-on-hover">
						<div class="card-body p-3">
							<div class="row">
								<div class="col-8  mb-4">
									<div class="numbers">
										<p class="text-sm mb-0 text-capitalize font-weight-bold currencyEns">${ vo.currencyEn }
										</p>
										<h5 class="font-weight-bolder mb-0">
											${ vo.balance }
											
				                    		<span class="text-dark text-xs text-end">
			                    				(1 ${vo.nationCodeVO.currencyCode } = ${vo.exchangeRateVO.buyBasicRate})
			                    			</span>
											
											<!--  <span
												class="text-success text-sm font-weight-bolder">+55%</span> -->
										</h5>
									</div>
								</div>
								<div class="col-4 text-end">
									<img src="${path }/resources/assets/img/flag/48/${vo.nationCodeVO.nationEnInitial }/${vo.nationCodeVO.nationEn }.png" />
								</div>
								<div class="d-flex flex-column border-0 p-3 bg-gray-100 border-radius-lg">
				                    		<span class="mb-2 text-sm text-danger font-weight-bold">지금 팔면 : 
				                    			<span class="text-dark font-weight-bold ms-sm-2">
				                    				<fmt:formatNumber type="number" maxFractionDigits="2" value="${(vo.exchangeRateVO.buyBasicRate  * (1- 0.03)) * vo.balance }" /> ￦
				                    			</span>
				                    			
				                    		</span>
				                    		<span class="mb-2 text-sm text-success font-weight-bold">지금 사면 : 
				                    			<span class="text-dark ms-sm-2 font-weight-bold">
				                    				<fmt:formatNumber type="number" maxFractionDigits="2" value="${(vo.exchangeRateVO.transferSendRate) * vo.balance }" /> ￦
				                    			</span>
				                    		</span>
				                    		<span class="text-dark text-xs text-end">
			                    				( ${vo.exchangeRateVO.regDate } 기준 )
			                    			</span>
				                    		
			                  	</div>
							</div>
						</div>
					</div>
				</div>

			</c:forEach>
		</div>


      
      
      <!-- footer start -->
  	  <jsp:include page="/WEB-INF/jsp/inc/dash-board/footer.jsp"/>
      <!-- footer end -->

    </div>
  </main>
  
  
  <!-- fixed-plugin start -->
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/fixed-plugin.jsp"/>
  <!-- fixed-plugin end -->

  
  
  <!--   Core JS Files  start -->
  <jsp:include page="/WEB-INF/jsp/inc/common/script.jsp"/>
  <!--   Core JS Files  end -->
  
</body>

</html>