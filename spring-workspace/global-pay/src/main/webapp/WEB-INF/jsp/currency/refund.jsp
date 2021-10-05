<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/chartjs.min.js"></script>
</head>

<script type="text/javascript">
// 전역변수
let selectedBalance
let selectedCurrencyEn
let cardNo

$(document).on("ready", function(){
	
	// 2단계 css 숨기기
	$('#refundStep_2').hide();
	
})

// 2단계로 이동하기
function gotoSecond(){
	selectedCurrencyEn = $("input[name='selectRadio']:checked").attr("currency");
	selectedBalance =  $("input[name='selectRadio']:checked").attr("balance");
	
	$.ajax({ 
		url :  "${pageContext.request.contextPath}/refund2"
		, type : "post"
		, data : {
			currencyEn : selectedCurrencyEn
		}
		, success : secondPage
		, error : function(){
			alert("Ajax Error")
		}
	});
}

// 2단계 페이지 로딩
function secondPage(result){
	
	$('#refundStep_1').replaceWith(result);
	$('#selectedNation2').text(selectedCurrencyEn);
	$('#input-limit').text("최대 " + selectedBalance + "까지 입력 가능");
	
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
		<nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">외화</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">환전관리</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">외화 환불</h6>
        </nav>
	
<!-- 환불 1단계 -->
 	<div class="row mt-4" id="refundStep_1">
		<div class="row">
			<div class="col-12 d-flex align-items-center">
				<h4 class="font-weight-bolder">1단계 : 외화 선택</h4>
			</div>
		</div>
		<div class="row mt-4">
			<c:forEach var="vo" items="${balances }">
				<div class="col-xl-3 col-sm-3 mt-xl-0 mb-4 cursor-pointer">
					<div class="card move-on-hover">
						<div class="card-body p-3">
							<!-- 체크박스 -->
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="selectRadio" currency="${ vo.currencyEn }" balance="${ vo.balance }">
							</div>
							<!-- 외화 잔액 -->
							<div class="row">
								<div class="col-8">
									<div class="numbers">
										<p class="text-sm mb-0 text-capitalize font-weight-bold">${ vo.currencyEn }</p>
										<h5 class="font-weight-bolder mb-0">
											${ vo.balance }
										</h5>
									</div>
								</div>
								<div class="col-4 text-end">
									<img src="${path }/resources/assets/img/flag/48/${vo.nationCodeVO.nationEnInitial }/${vo.nationCodeVO.nationEn }.png" />
								</div>
							</div>
						</div>
					</div>
				</div>

			</c:forEach>
		</div>
		<div class="row">
			<div class="col-12 text-end">
				<button class="btn btn-primary btn-lg active" role="button" aria-pressed="true" onclick="gotoSecond()">
					다음단계
				</button>
			</div>
		</div>
	</div>

<!-- 환불 2단계 -->

	 

      
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