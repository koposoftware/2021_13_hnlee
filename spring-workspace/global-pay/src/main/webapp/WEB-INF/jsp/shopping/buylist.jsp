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
          <h6 class="font-weight-bolder mb-0">결제 내역</h6>
        </nav>
    
      <!-- row start -->
      <div class="row mt-3">
          <div class="card h-100">
            <!-- <div class="card-header pb-0 px-3">
            	<div class="row">
					<div class="col-6 d-flex align-items-center">
						<h4 class="font-weight-bolder">결제 내역</h4>
						
					</div>
				</div>
            </div> -->
            <div class="card-body pt-4 p-3">
              <ul class="list-group">
              
              	<c:forEach var="pay" items="${list }">
	                <li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
	                  <div class="d-flex flex-column">
	                  	<h6 class="mb-3 text-sm">${pay.productVO.name }</h6>
	                  	<div class="d-flex px-2 py-1">
	                     <div>
	                       <img src="${pay.productVO.img }" class="avatar avatar-xxl me-5" alt="user4">
	                     </div>
	                     <div class="d-flex flex-column justify-content-center"> 
	                     	<span class="mb-2 text-xs">총 결제 금액 : 
	                    		<span class="text-dark ms-sm-2 font-weight-bold">
	                    		
	                    			<fmt:formatNumber value="${pay.feAmount }" pattern="#,###" />
	                    			&nbsp;${pay.currencyEn }
	                    		
	                    		</span>
	                    	</span>
	                     	<span class="mb-2 text-xs">할인 금액 : 
	                    		<span class="text-dark ms-sm-2 font-weight-bold">
	                    		
	                    			<fmt:formatNumber value="${pay.discountAmount }" pattern="#,###" />
	                    			&nbsp;${pay.currencyEn }
	                    		
	                    		</span>
	                    	</span>
	                       	<span class="mb-2 text-xs">브랜드 : <span class="text-dark font-weight-bold ms-sm-2">${pay.productVO.brand }</span></span>
	                    	<span class="mb-2 text-xs">쇼핑몰 : <span class="text-dark ms-sm-2 font-weight-bold">${pay.productVO.partnerShopVO.shopName }</span></span>
	                    	<span class="mb-2 text-xs">결제일 : <span class="text-dark ms-sm-2 font-weight-bold">${pay.regDate }</span></span>
	                    	<a type="button"
									class="btn btn-outline-primary btn-sm mb-2" href="${path }/shopping/detail/${pay.productNo}">상세 보기</a>
	                     </div>
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
	                  
	                  
	                  
	                  
	                </li>
                </c:forEach>
              </ul>
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