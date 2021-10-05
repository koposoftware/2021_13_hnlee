<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
$(document).on('ready', function(){
	$('.deleteFavModalBtn').on('click', function(){
		
		let no = $(this).data("no")
		console.log(no)
		
		$.ajax({ 
			url :  "${pageContext.request.contextPath}/shopping/delFavourite/"+no
			, type : "get"
			, success : function(result){
				$('#deleteFavResult').text(result)
				$('#deleteFavModal').modal('show')
			}
			, error : function(){
				alert("Ajax Error")
			}
		});
	})
})


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
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">쇼핑</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">해외직구</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">알람 목록</h6>
        </nav>
    
      <!-- row start -->
      <div class="row mt-3">
          <div class="card h-100">
            <!-- <div class="card-header pb-0 px-3">
            	<div class="row">
					<div class="col-6 d-flex align-items-center">
						<h4 class="font-weight-bolder">알림 신청 목록</h4>
						
					</div>
				</div>
            </div> -->
            <div class="card-body pt-4 p-3">
              <ul class="list-group">
              
              	<c:forEach var="vo" items="${list }" varStatus="status">
              		<c:if test="${status.count ne 1 }">
              			<hr class="mt-4">
              		</c:if>
              		<div class="row">
              		
              			<!-- 상품 정보 -->
	              		<div class="col-6 border-0 bg-gray-100 border-radius-lg">
	              		
			                <li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
			                
			                  <div class="d-flex flex-column">
			                  	<h6 class="mb-3 text-sm">${vo.productVO.name }</h6>
			                  	<div class="d-flex px-2 py-1">
			                     <div>
			                       <img src="${vo.productVO.img }" class="avatar avatar-xxl me-5" alt="user4">
			                     </div>
			                     <div class="d-flex flex-column justify-content-center"> 
			                     	<span class="mb-2 text-xs">가격 : 
			                    		<span class="text-dark ms-sm-2 font-weight-bold">
			                    		
			                    			<fmt:formatNumber value="${vo.productVO.price }" pattern="#,###" />
			                    			&nbsp;${vo.productVO.currency }
			                    		
			                    		</span>
			                    	</span>
			                       	<span class="mb-2 text-xs">브랜드 : <span class="text-dark font-weight-bold ms-sm-2">${vo.productVO.brand }</span></span>
			                    	<span class="mb-2 text-xs">쇼핑몰 : <span class="text-dark ms-sm-2 font-weight-bold">${vo.productVO.partnerShopVO.shopName }</span></span>
			                    	<span class="mb-2 text-xs">등록일 : <span class="text-dark ms-sm-2 font-weight-bold">${vo.regDate }</span></span>
			                    	<a type="button"
											class="btn btn-outline-primary btn-sm mb-2" href="${path }/shopping/detail/${vo.productNo}">상세 보기</a>
			                     </div>
			                   </div>
			                  </div>
			                  <div class="ms-auto text-end">
			                    <a type="button" class="btn btn-link text-danger text-gradient px-3 mb-0 deleteFavModalBtn" data-no="${vo.productNo}">
			                    <!-- <a type="button" class="btn btn-link text-danger text-gradient px-3 mb-0" data-bs-toggle="modal" data-bs-target="#deleteAlertModal"> -->
			                    	<i class="far fa-trash-alt me-2"></i>삭제하기
			                    </a>
			                 </div>
			                 
			                 
			               </li>
			            </div>
			            
			            <!-- 가격 알림 정보 -->
			            <div class="col-6">
			            	<div class="row">
			            	
			            	<div class="row mx-4">
			            	<div class="card mb-3 bg-gray-100">
					            <div class="card-body p-3">
					              <div class="row">
					              	
					                <div class="col-2">
					                  <div class="icon icon-shape bg-gradient-info shadow text-center border-radius-md">
					                    <i class="ni ni-bell-55 text-lg opacity-10" aria-hidden="true"></i>
					                  </div>
					                </div>
					                <div class="col-10">
					                  <div class="numbers">
					                    <p class="text-sm mb-0 text-capitalize font-weight-bold">목표 가격</p>
					                    <h5 class="font-weight-bolder mb-0">
					                      <fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.alarmPrice } " /> 
					                      <span class="text-info text-sm font-weight-bolder">￦</span>
					                    </h5>
					                    <h6 class="text-sm mb-0 text-end">
					                      (1<span class="text-info text-sm font-weight-bolder"> ${vo.exchangeRateVO.nationCodeVO.currencyCode } </span>
					                       = <fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.alarmRate } " />)
					                    </h6>
					                  </div>
					                </div>
					              </div>
					            </div>
					        </div>
					        </div>
					        
					        <div class="row mx-4">
			            	<div class="card mb-3 bg-gray-100">
					            <div class="card-body p-3">
					              <div class="row">
					              	<div class="col-2">
					                  <div class="icon icon-shape bg-gradient-primary shadow text-center border-radius-md">
					                    <i class="ni ni-world-2 text-lg opacity-10" aria-hidden="true"></i>
					                  </div>
					                </div>
					                
					                <div class="col-10">
					                  <div class="numbers">
					                    <p class="text-sm mb-0 text-capitalize font-weight-bold">현재 환율</p>
					                    <h5 class="font-weight-bolder mb-0">
					                      <fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.productVO.price * vo.exchangeRateVO.transferSendRate } " /> 
					                      
					                      <span class="text-primary text-sm font-weight-bolder">￦</span>
					                    </h5>
					                    <h6 class="text-sm mb-0 text-end">
					                      (1<span class="text-primary text-sm font-weight-bolder">${vo.exchangeRateVO.nationCodeVO.currencyCode }</span>
					                      = <fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.exchangeRateVO.transferSendRate } " /> )
					                    </h6>
					                  </div>
					                </div>
					              </div>
					            </div>
					        </div>
					        </div>
					        
					      </div>
					      
					      <%-- <div class="row">
					      	<div class="col-12">
			            	<div class="card mb-3 ">
					            <div class="card-body p-3">
					              <div class="row">
					                  <div class="numbers">
					                    <p class="text-sm mb-0 text-capitalize font-weight-bold">목표 도달까지</p>
					                    <h5 class="font-weight-bolder mb-0">
					                      <fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.exchangeRateVO.transferSendRate } " /> 
					                      <span class="text-primary text-sm font-weight-bolder">${vo.exchangeRateVO.nationCodeVO.currencyCode }</span>
					                    </h5>
					                  </div>
					              </div>
					            </div>
					        </div>
					        </div>
					      </div> --%>
					      
					      
			            </div>
			            
			            
		             </div>
	                
                </c:forEach>
              </ul>
            </div>
        </div>

						
<!-- Modal -->
<div class="modal fade" id="deleteFavModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결과</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="deleteFavResult">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">확인</button>
        <button type="button" class="btn bg-gradient-primary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	                        
      
      <!-- footer start -->
  	  <jsp:include page="/WEB-INF/jsp/inc/dash-board/footer.jsp"/>
      <!-- footer end -->
      
      
	  </div>
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