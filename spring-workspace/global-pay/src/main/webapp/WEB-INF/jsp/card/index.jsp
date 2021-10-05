<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
function authorize(){
	let location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
    		+ "response_type=code"
    		+ "&client_id=f07ebe18-950e-41d5-895d-d7588dac259d"
    		+ "&redirect_uri=http://localhost:9997/global-pay/callback"
    		+ "&scope=login inquiry transfer"
    		+ "&state=b80BLsfigm9OokPTjy03elbJqRHOfGSY"
    		+ "&auth_type=0";
    var popup = window.open(location, '오픈뱅킹 본인인증', 'width=700px,height=800px,scrollbars=yes');
}


//$(location).attr('pathname');
</script>
<script type="text/javascript">
function registerPW(){
	
	let password = $('#password').val();
	console.log(password);
	
	// 결제 비밀번호 등록하기
	$.ajax({
        url : "${path}/card/registerPW",
        type : "post",
        data : {
        	password : password
        },
        success : function(result) {
        	$('#registerPWModal').modal('hide')
        	$('#registerPWModal').replaceWith(result);
        	$('#confirmTitle').text("완료안내");
        	$('#confirmBody').text("비밀번호 등록이 완료되었습니다.");
        	$('#confirmModal').modal('show');
        	setTimeout(function(){
        		location.reload();
        	},3000);
        },
        error : function(){
        	alert("ajax 오류입니다.")
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
          <h6 class="font-weight-bolder mb-0">내 페이카드</h6>
        </nav>
      <!-- row start -->
      
       <div class="row mt-4">
        <div class="col-lg-8">
          <div class="row">
            <div class="col-xl-6 mb-xl-0 mb-4">
              <div class="card bg-transparent shadow-xl">
                <div class="overflow-hidden position-relative border-radius-xl" style="background-image: url('${pageContext.request.contextPath }/resources/assets/img/curved-images/curved14.jpg');">
                  <span class="mask bg-gradient-dark"></span>
                  
                  
                  <c:if test="${not empty cardVO }">
                  
	                  <%-- 카드 앞면 사진 부분 ( 카드 존재하는 사람만 ) --%>
	                  <div class="card-body position-relative z-index-1 p-3">
	                    <i class="fas fa-wifi text-white p-2"></i>
	                    <h5 class="text-white mt-4 mb-5 pb-2">${cardVO.cardNo }</h5>
	                    <div class="d-flex">
	                      <div class="d-flex">
	                        <div class="me-4">
	                          <p class="text-white text-sm opacity-8 mb-0">이름</p>
	                          <h6 class="text-white mb-0">${cardVO.familyName }&nbsp;&nbsp;${cardVO.givenName }</h6>
	                        </div>
	                        <div>
	                          <p class="text-white text-sm opacity-8 mb-0">만료일</p>
	                          
	                          
	                          <fmt:parseDate value="${cardVO.expireDate}" var="cardExpireDate" pattern="yyyy-MM-dd HH:mm:ss"/>
							  
	                          
	                          
	                          <h6 class="text-white mb-0"><fmt:formatDate value="${cardExpireDate}" pattern="yyyy.MM.dd"/></h6>
	                        </div>
	                      </div>
	                      <div class="ms-auto w-20 d-flex align-items-end justify-content-end">
	                        <img class="w-60 mt-2" src="${pageContext.request.contextPath }/resources/assets/img/logos/mastercard.png" alt="logo">
	                      </div>
	                    </div>
	                  </div>
                   
                  </c:if>
                  <c:if test="${ empty cardVO }">
                   
	                  <div class="card-body position-relative z-index-1 p-3">
	                    <i class="fas fa-wifi text-white p-2"></i>
	                    <h5 class="text-white mt-4 mb-5 pb-2" 
	                    	style="text-align: center;">
	                    	등록된 카드가 없습니다.
	                    </h5>
	                    <div class="d-flex">
		                    <a href="${pageContext.request.contextPath }/card/issue" 
		                    	class="btn btn-secondary btn-lg w-100 btn-lg active" 
		                    	role="button" aria-pressed="true" style="margin-bottom: 0.2rem">
		                    	카드 개설하기
		                    </a>
	                    </div>
	                  </div>
                  
                  </c:if>
                  
                  
                </div>
              </div>
            </div>
            
<c:if test="${not empty cardVO }">
            <div class="col-xl-6">
              <div class="row">
                <div class="col-md-6">
                  <div class="card">
                    <div class="card-header mx-4 p-3 text-center">
                      <div class="icon icon-shape icon-lg bg-gradient-primary shadow text-center border-radius-lg">
                        <i class="fas fa-landmark opacity-10"></i>
                      </div>
                    </div>
                    <div class="card-body pt-0 p-3 text-center">
                      <h6 class="text-center mb-0">CVC/CVV</h6>
                      <hr class="horizontal dark my-3">
                      <h5 class="mb-0">***</h5>
                      <a href="${path }/card/balance" class="btn btn-outline-primary btn-sm mb-0">전체 보기</a>
                    </div>
                  </div>
                </div>
                <div class="col-md-6 mt-md-0 mt-4">
                  <div class="card">
                    <div class="card-header mx-4 p-3 text-center">
                      <div class="icon icon-shape icon-lg bg-gradient-primary shadow text-center border-radius-lg">
                        <i class="fab fa-paypal opacity-10"></i>
                      </div>
                    </div>
                    <div class="card-body pt-0 p-3 text-center">
                      <h6 class="text-center mb-0">비밀번호</h6>
                      <hr class="horizontal dark my-3">
                      
                      <c:if test="${empty cardVO.password }">
                      	<h5 class="mb-0">&nbsp;</h5>
                      	<button class="btn btn-outline-primary btn-sm mb-0" data-bs-toggle="modal" data-bs-target="#registerPWModal">
					      비밀번호 등록
					    </button>
					    <!-- Modal -->
					    <div class="modal fade" id="registerPWModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalSignTitle" aria-hidden="true">
					      <div class="modal-dialog modal-dialog-centered" role="document">
					        <div class="modal-content">
					          <div class="modal-body p-0">
					            <div class="card card-plain">
					              <div class="card-header pb-0 text-left">
					                  <h3 class="font-weight-bolder text-primary text-gradient">결제 비밀번호</h3>
					                  <p class="mb-0">결제 시 사용할 비밀번호를 등록하세요</p>
					              </div>
					              <div class="card-body pb-3">
					                <form role="form text-left">
					                  <div class="input-group mb-3">
					                    <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호 숫자 네자리를 입력하세요" aria-label="Email" aria-describedby="email-addon">
					                  </div>
					                  <div class="input-group mb-3">
					                    <input type="password" class="form-control" placeholder="비밀번호를 한번 더 입력하세요" aria-label="Password" aria-describedby="password-addon">
					                  </div>
					                  <div class="text-center">
					                    <button type="button" onclick="registerPW()" class="btn bg-gradient-primary btn-lg btn-rounded w-100 mt-4 mb-0">등록</button>
					                  </div>
					                </form>
					              </div>
					            </div>
					          </div>
					        </div>
					      </div>
					    </div>
					    
                      </c:if>
                      
                      <c:if test="${not empty cardVO.password }">
                      	  <div id="existPassword">
	                      <h5 class="mb-0">****</h5>
	                      <a href="${path }/card/balance" class="btn btn-outline-primary btn-sm mb-0">전체 보기</a>
	                      </div>
                      </c:if>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
<%--             <div class="col-md-12 mb-lg-0 mb-4">
              <div class="card mt-4">
                <div class="card-header pb-0 p-3">
                  <div class="row">
                    <div class="col-6 d-flex align-items-center">
                      <h6 class="mb-0">연결 계좌</h6>
                    </div>
                    <div class="col-6 text-end">
                      <a class="btn bg-gradient-secondary mb-0" href="${path}/card/account">&nbsp;&nbsp;전체보기</a>
                    </div>
                  </div>
                </div>
                <div class="card-body p-3">
                
                
                  <div class="row">
                  
                  	<c:forEach items="${acntList }" var="acnt" varStatus="status" begin="1" end="2">
                    <div class="col-md-6 mb-md-0 mb-4">
                      <div class="card card-body border card-plain border-radius-lg d-flex align-items-center flex-row">
                        <img class="w-10 me-3 mb-0" src="${pageContext.request.contextPath }/resources/assets/img/logos/mastercard.png" alt="logo">
                        <h6 class="mb-0">${acnt.bankName }</h6>&nbsp;
                        <h7 class="mb-0">${acnt.accountNumMasked }</h7>
                        <i class="fas fa-pencil-alt ms-auto text-dark cursor-pointer" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Card"></i>
                      </div>
                    </div>
                    </c:forEach>
                  	<c:forEach var="account" items="${accounts }">
                    <div class="col-md-6 mb-md-0 mb-4">
                      <div class="card card-body border card-plain border-radius-lg d-flex align-items-center flex-row">
                        <img class="w-10 me-3 mb-0" src="${pageContext.request.contextPath }/resources/assets/img/logos/mastercard.png" alt="logo">
                        <h6 class="mb-0">${account.accountBank }</h6>&nbsp;
                        <h7 class="mb-0">${account.accountNum }</h7>
                        <i class="fas fa-pencil-alt ms-auto text-dark cursor-pointer" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit Card"></i>
                      </div>
                    </div>
                    </c:forEach>
                    
                  </div>
                </div>
              </div>
            </div> --%>
          
          
          
          </div>
        </div>
        <div class="col-lg-4">
          <div class="card h-100">
            <div class="card-header pb-0 p-3">
              <div class="row">
                <div class="col-6 d-flex align-items-center">
                  <h6 class="mb-0">카드 잔액 TOP 5</h6>
                </div>
	                <div class="col-6 text-end">
	                  <a href="${path }/card/balance" class="btn btn-outline-dark btn-sm mb-0">상세 보기</a>
	                </div>
              </div>
            </div>
            <div class="card-body p-3 pb-0">
              <ul class="list-group">
              	<c:forEach var="vo" items="${balances }" varStatus="status">
              		
              		<c:if test="${status.count <= 5}">
              		<li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-0 border-radius-lg">
              		  <div class="d-flex align-items-center text-sm">
	                    <button class="btn btn-link text-dark text-sm mb-0 px-0 ms-4">
	                    	<img src="${path }/resources/assets/img/flag/24/${vo.nationCodeVO.nationEnInitial }/${vo.nationCodeVO.nationEn }.png"/> 
	                    	${ vo.currencyEn }
	                    </button>
	                  </div>
	                  <div class="d-flex align-items-center">
	                    <h6 class="mb-0 px-0 ms-4 text-dark font-weight-bold text-xxl">${ vo.balance } ${ vo.nationCodeVO.currencyCode }</h6>
	                  </div>
	                </li>
	                </c:if>
	                
		        </c:forEach>
              
              
              
              </ul>
            </div>
          </div>
        </div>
      </div>

</c:if>
      
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