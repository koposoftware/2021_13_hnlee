<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script>
	function acntBal(fintechUseNum){
		// ajax	
		$.ajax({ 
			url :  "${pageContext.request.contextPath}/acnt/balance"
			, type : "post"
			, data : {
				fintechUseNum : fintechUseNum
			}
			, success : function(balance){
				// modal
				$('#balanceModalBody').text(balance.balanceAmt)
				$('#accountBalModal').modal('show')
			}
			, error : function(){
				alert("Ajax Error")
			}
		});
	}
	function accountBal(balance){
		// modal
		balance = comma(balance) + " 원"
		$('#balanceModalBody').text(balance)
		$('#accountBalModal').modal('show')
	}
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
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
    
    
<!-- Modal -->
<div class="modal fade" id="accountBalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">계좌 잔액</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="balanceModalBody">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>    
    
    
<!-- Start container -->
	<div class="container-fluid py-4">
		<nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">카드</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">페이카드</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">연결 계좌</h6>
        </nav>

<!-- row start -->
		<div class="row mt-4">
			<div class="col-12">
				<%-- <a href="${path }/refund" class="btn btn-link text-dark px-2 mb-0" style="float: right">
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
				</button> --%>
				
				<div class="col-12 text-end mb-3">
	                <a class="btn bg-gradient-dark mb-0" href="javascript:authorize()"><i class="fas fa-plus"></i>&nbsp;&nbsp;새 계좌 등록</a>
	            </div>
			</div>
				  <c:forEach var="vo" items="${accounts }" >
				<div class="col-xl-3 col-sm-3 mt-xl-0 mb-4 cursor-pointer">
				  	<div class="card move-on-hover">
						<div class="card-body p-3">
							<div class="row">
								<div class="col-12">
									<div class="numbers">
										<p class="text-sm mb-0 text-capitalize font-weight-bold currencyEns">${ vo.accountBank }
										</p>
										<h5 class="font-weight-bolder mb-0">
											<c:out value="${fn:substring(vo.accountNum ,0,3)}"/>******
				                    		<span class="text-dark text-xs text-end">
			                    				${vo.alias } 
			                    			</span>
										</h5>
									</div>
								</div>
								<div class="col-12 text-end">
									<span class="text-dark text-xs text-end">
			                    		${holder }
			                    	</span>
								</div>
								<div class="d-flex flex-column">
				                    <!-- Button trigger modal -->
									<button type="button" class="btn bg-gradient-secondary btn-lg w-100" 
										onclick="javascript:accountBal('${vo.balance }')">
									  잔액보기
									</button>
									
			                  	</div>
							</div>
						</div>
					</div>
				</div>
				  </c:forEach>
				  <c:forEach var="vo" items="${acntList }" >
				  <div class="col-xl-3 col-sm-3 mt-xl-0 mb-4 cursor-pointer">
				  	<c:set var="holder" value="${vo.accountHolderName }"/>
					<div class="card move-on-hover">
						<div class="card-body p-3">
							<div class="row">
								<div class="col-12">
									<div class="numbers">
										<p class="text-sm mb-0 text-capitalize font-weight-bold currencyEns">${ vo.bankName }
										</p>
										<h5 class="font-weight-bolder mb-0">
											${ vo.accountNumMasked }
				                    		<span class="text-dark text-xs text-end">
			                    				${vo.accountAlias } 
			                    			</span>
										</h5>
									</div>
								</div>
								<div class="col-12 text-end">
									<span class="text-dark text-xs text-end">
			                    		${vo.accountHolderName }
			                    	</span>
								</div>
								<div class="d-flex flex-column">
				                    <button type="button" onclick="javascript:acntBal('${fintechUseNum}')" type="button" class="btn bg-gradient-secondary btn-lg w-100">
				                    	잔액보기
				                    </button>
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