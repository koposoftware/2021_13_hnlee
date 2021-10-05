<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
let selectedHistory;

$(document).on("ready", function(){
	
	$('#chargeHistory').on("click", function(){
		selectedHistory = 'charge';
		changeTbody(selectedHistory);
	});
	$('#refundHistory').on("click", function(){
		selectedHistory = 'refund';
		changeTbody(selectedHistory);
	});
	$('#payHistory').on("click", function(){
		selectedHistory = 'pay';
		changeTbody(selectedHistory);
	});
	
});

function changeTbody(history){
	$.ajax({ 
		url :  "${pageContext.request.contextPath}/history/" + history
		, type : "POST"
		, success : function(result){
			console.log(result)
			$('.transaction_history').replaceWith(result);
			
		}
		, error : function(){
			alert("Ajax Error")
		}
	});
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
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">카드</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">페이카드</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">이용 내역</h6>
        </nav>
    
      <!-- row start -->
      
      <div class="row mt-3">
        <div class="col-12">
        
          <div class="card mb-4">
            <div class="card-header pb-4">
            </div>
            
            
            <div class="nav-wrapper position-relative end-0 opacity-7" style="align-self: center;width: 55rem;font-size: small;">
			  <ul class="nav nav-pills nav-fill p-1" role="tablist">
			    <li class="nav-item">
			      <a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" href="#profile-tabs-icons" role="tab" aria-controls="preview" aria-selected="true">
			      <i class="ni ni-badge text-sm me-2"></i> 전체보기
			      </a>
			    </li>
			    <li class="nav-item">
			      <a id="chargeHistory" class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#dashboard-tabs-icons" role="tab" aria-controls="code" aria-selected="false">
			        <i class="ni ni-laptop text-sm me-2"></i> 충전내역
			      </a>
			    </li>
			    <li class="nav-item">
			      <a id="refundHistory" class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#dashboard-tabs-icons" role="tab" aria-controls="code" aria-selected="false">
			        <i class="ni ni-laptop text-sm me-2"></i> 환불내역
			      </a>
			    </li>
			    <li class="nav-item">
			      <a id="payHistory" class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#dashboard-tabs-icons" role="tab" aria-controls="code" aria-selected="false">
			        <i class="ni ni-laptop text-sm me-2"></i> 결제내역
			      </a>
			    </li>
			  </ul>
			</div>
            
            
            
            
            
            
            <div class="card-body px-0 pt-3 pb-3">
              <div class="table-responsive p-0">
                <table class="table align-items-center justify-content-center mb-0">
                
                
                  <thead>
                    <tr>
                      
                      <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">외화</th>
                      <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">구분</th>
			          <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7 ps-2">거래액</th>
			          <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7 ps-2">거래 일자</th>
			          <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7 ps-2">거래후 잔액</th>
                    </tr>
                  </thead>
                  
                  <tbody class="transaction_history">


					<c:forEach var="vo" items="${list }">
	                    <tr>
	                    
	                      <td class="align-middle text-center" style="width: 5%">
	                        <div class="d-flex px-2 py-1">
				              <div>
				              	<img class="px-2" src="${path }/resources/assets/img/flag/32/${vo.nationEnInitial }/${vo.nationEn }.png" />
				              </div>
				              <div class="d-flex flex-column justify-content-center">
				                <h6 class="mb-0 text-sm">${vo.currencyEn }</h6>
				                <!-- <p class="text-xs text-secondary mb-0">john@creative-tim.com</p> -->
				              </div>
				            </div>
					                        
	                      </td>
	                      <td class="align-middle text-center">
	                      	  <span class="text-xs">${vo.type }</span>
	                             
	                      </td>
	                      
	                      
	                      
	                      <td class="align-middle text-center">
	                      	<div class="d-flex align-items-center" style="place-content: center;">
	                      	
	                      	
	                      	
	                      		<c:if test="${vo.type eq '충전' }">
			                    <button class="btn btn-icon-only btn-rounded btn-outline-success mb-0 me-3 btn-sm d-flex align-items-center justify-content-center">
			                    	<i class="fas fa-arrow-up" aria-hidden="true"></i>
			                    </button>
			                    <div class="d-flex flex-column">
			                      <h6 class="mb-1 text-success text-md">
			                      <span class="mb-0 ">+ </span>
	                          		<span class="mb-0 ">${vo.feAmount }</span>
	                      			<span class="mb-0 ">${vo.currencyCode }</span>
			                      </h6>
			                      <span class="text-xs">원화 : ${vo.etcAmount } ￦</span>
			                    </c:if>
			                    
			                    
			                    
			                    <c:if test="${vo.type eq '환불' }">  
			                    <button class="btn btn-icon-only btn-rounded btn-outline-danger mb-0 me-3 btn-sm d-flex align-items-center justify-content-center">
			                    	<i class="fas fa-arrow-down" aria-hidden="true"></i>
			                    </button>
			                    <div class="d-flex flex-column">
			                      <h6 class="mb-1 text-danger text-md">  
	                          		<span class="mb-0 ">${vo.feAmount }</span>
	                      			<span class="mb-0 ">${vo.currencyCode }</span>
			                      </h6>
			                      <span class="text-xs">원화 : ${vo.etcAmount } ￦</span>
			                    </c:if>  
			                    
			                    
			                    
			                    <c:if test="${vo.type eq '결제' }">  
			                    <button class="btn btn-icon-only btn-rounded btn-outline-danger mb-0 me-3 btn-sm d-flex align-items-center justify-content-center">
			                    	<i class="fas fa-arrow-down" aria-hidden="true"></i>
			                    </button>
			                    <div class="d-flex flex-column">
			                      <h6 class="mb-1 text-danger text-md">  
			                      <span class="mb-0 ">- </span>
	                          		<span class="mb-0 ">${vo.feAmount }</span>
	                      			<span class="mb-0 ">${vo.currencyCode }</span>
			                      </h6>
			                      <span class="text-xs">할인 : ${vo.etcAmount } ￦</span>
			                    </c:if>  
			                      
			                      
			                      
			                      	
			                    </div>
			                  </div>
	                      </td>
	                      
	                      <td class="align-middle text-center">
	                      	<span class="text-xs"> ${vo.regDate }</span>
	                      </td>
	                      
	                      <td class="align-middle text-center">
	                      	<span class="text-xs">${vo.afterBalance } ${vo.currencyCode } </span>
				          </td>
	                      
	                    </tr>
                    </c:forEach>                  
                    
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
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
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/chartJS.jsp"/>
  <!--   Core JS Files  end -->
  
</body>

</html>