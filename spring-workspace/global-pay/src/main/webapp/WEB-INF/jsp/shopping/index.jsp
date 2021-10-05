<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script type="text/javascript">
$(document).ready(function(){
	
	// 상품 찜하기 버튼 클릭했을 때
	$('.shopping-favourite').on("click", function(){
		
		product = $(this).data('value');
		
		// 찜하기 목록에 추가하기 : 상품번호가 필요함
		$.ajax({ 
			url :  "${pageContext.request.contextPath}/shopping/addFavourite/"+product
			, type : "get"
			, success : function(e){
				
				// cnt : -1(이미 존재하는 상품), 0(찜목록 추가 실패), 1(찜 성공)
				
				if(e == 1){
					$('.favourite-result-msg').text('해당 상품의 찜하기가 완료되었습니다. 찜 목록을 확인하시겠습니까?');
				}
				else if (e == -1) {
					$('.favourite-result-msg').text('이미 찜 완료된 상품입니다. 찜 목록을 확인하시겠습니까?');
				}
				else {
					$('.favourite-result-msg').text('찜하기에 실패하였습니다. 찜 목록을 확인하시겠습니까?');
				}
			
				$("#add-favourite-list-modal").modal('show');
			}
			, error : function(){
				alert("Ajax Error")
			}
		});
		
	})
	
	
	// 상품 알람 버튼 눌렀을때 신청했을 때
	$('.shopping-alarm').on("click", function(){
		
		product = $(this).data('value');
		price = $(this).data('price');
		currencyEn = $(this).data('currency');
		curRate = -1;
		
		// 상품의 현재 환율 가격 받아오기
		$.ajax({ 
			url :  "${pageContext.request.contextPath}/currency/curRate"
			, type : "post"
			, data : {
				currencyEn : currencyEn
			}
			, success : function(e){
				curRate = e.buyBasicRate*(1 + (e.cashBuySpread * 0.01))
				curPrice = price * curRate
				curPrice = comma(Math.ceil(curPrice))
				
				// cur-rate
				$('#cur-rate').text("1" + currencyEn + " = " + curRate + " " + "원")

				// cur-price 
				$('#cur-price').text(price + " " + currencyEn)
				$('#cur-price-won').text("=  " + curPrice + " 원")
			
				$("#register-shopping-alarm-modal").modal('show');
			}
			, error : function(){
				alert("Ajax Error")
			}
		});
		
	}); 
	
	// 목표 환율가 입력될 때!
	$('#target-price').on("keyup", function(){
	
		targetPrice = $(this).val();
		targetRate = Math.ceil(targetPrice / price)  // 왜 price 값을 가지고 있지?????
		
		$('#target-rate').text("1" + currencyEn + " = " + comma(targetRate) + " 원");
		
		if(targetRate >= curRate){
			targetRateChange = Math.ceil(targetRate - curRate);
			$('#target-rate-change').text("(환율 " + comma(targetRateChange) +  " 원 상승 시, 알람)");
		}
		else{
			targetRateChange = Math.ceil(curRate - targetRate);
			$('#target-rate-change').text("(환율 " + comma(targetRateChange) +  " 원 하락 시, 알람)");
		}
		
		
	});
	

	// 알림 신청 눌릴 때! : 알람 신청한 가격, 알람 신청한 환율, 알람 신청한 상품
	$('.complete-alarm-register').on("click", function(){
		
		targetPrice = $('#target-price').val();
		targetRate = Math.ceil(targetPrice / price)

		if(isNotNull(targetRate)){
			
			console.log(targetRate)
			console.log(targetPrice)
			console.log(product) // 이 값을 왜 가지고 있는 거임?????
			
			// db에 알람 신청 insert하기
			$.ajax({ 
				url :  "${pageContext.request.contextPath}/shopping/registerAlarm"
				, type : "post"
				, data : {
					alarmRate : targetRate
					, alarmPrice : targetPrice
					, productNo : product
					, alarmCurrency : currencyEn
				}
				, success : function(e){

					if(e == 1){
						alert("알림신청이 완료되었습니다.");
					}
					else if (e == -1) {
						alert("이미 알람신청된 상품입니다.");
					}
					else {
						alert("알림 신청이 실패하였습니다.");
					}
					
					$("#register-shopping-alarm-modal").modal('hide');
				}
				, error : function(){
					alert("Ajax Error")
				}
			});
			
			
		}
		else{
			alert("목표 금액을 입력해주세요.")
		}
		
	});
	
	
	// 알림신청 모달창 닫을 때
	$('#register-shopping-alarm-modal').on('hidden.bs.modal', function () {
		$("#target-price").val('');
		$("#target-rate").empty();
		$("#target-rate-change").empty();
	})
	
})

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
function detail(no){
	
	let role = $('#role').val()
	let id = $('#id').val()
	
	if(role == '[ROLE_CARD]'){
		// 상세 페이지로 이동
		location.href = "${path}/shopping/detail/" + no
	}
	else {
		$('#nonCardAlert').modal('show');
	}	
	
	//href="${path }/shopping/detail/${product.no}"
}
</script>


<body class="g-sidenav-show  bg-gray-100">
<s:authentication property="principal" var="user"/> 
<input type="hidden" value="${user.authorities}" id="role">
<input type="hidden" value="${user.username}" id="id">
<input type="hidden" value="${user.password}" id="pw">

  <!-- aside start -->
  <jsp:include page="/WEB-INF/jsp/inc/dash-board/aside.jsp"/>
  <!-- aside end -->
  
  
  
  <main class="main-content position-relative max-height-vh-100 h-100 mt-1 border-radius-lg ">
    <!-- Navbar -->
    <jsp:include page="/WEB-INF/jsp/inc/dash-board/navbar.jsp"/>
    <!-- End Navbar -->
    
<div class="modal fade" id="nonCardAlert" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
  <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title" id="modal-title-default">공지</h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <p class="text-center">카드를 개설한 회원만 접근 가능합니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-gradient-primary" data-bs-dismiss="modal">확인</button>
        <button type="button" class="btn btn-link  ml-auto" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>   
    
    
    
<!-- Start container -->
    <div class="container-fluid py-4">
    	<nav aria-label="breadcrumb">
          <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
            <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:;">쇼핑</a></li>
            <li class="breadcrumb-item text-sm text-dark active" aria-current="page">해외직구</li>
          </ol>
          <h6 class="font-weight-bolder mb-0">쇼핑하기</h6>
        </nav>
    
     <!-- row start -->
		<div class="row mt-3">
			<div class="col-4">
				<div class="card">
					<div class="card-header p-0 mx-3 mt-3 position-relative z-index-1">
						<a href="javascript:;" class="d-block"> <img
							src="${path }/resources/assets/img/shopping/amazon.jpg"
							class="img-fluid border-radius-lg">
						</a>
					</div>

					<div class="card-body pt-2">
						<span
							class="text-gradient text-primary text-uppercase text-xs font-weight-bold my-2">USD</span>
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							Amazon </a>
						<p class="card-description mb-4">딱 하나만 사도 아마존 무료배송!<br> 즉시 지급 1만원 쿠폰 발급! 미국 제품 직구는 아마존에서 구매하는 것이 이득이라는 것은 안비밀!</p>
						<a class="text-black text-sm font-weight-bold mb-0 icon-move-right mt-auto" 
		                	href="${pageContext.request.contextPath }/currency/list">
		                  바로 가기
		                  <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
		                </a>
					</div>
				</div>
			</div>

			<div class="col-4">
				<div class="card">
					<div class="card-header p-0 mx-3 mt-3 position-relative z-index-1">
						<a href="javascript:;" class="d-block"> <img
							src="${path }/resources/assets/img/shopping/aliexpress.jpg"
							class="img-fluid border-radius-lg">
						</a>
					</div>

					<div class="card-body pt-2">
						<span
							class="text-gradient text-primary text-uppercase text-xs font-weight-bold my-2">CNY</span>
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							Aliexpress </a>
						<p class="card-description mb-4">어메이징 특가를 만나볼 준비가 되셨나요? <br>AliExpress는 원하는 것은 무엇이든 손가락 하나로 손쉽게 찾을 수 있는 쇼핑몰 입니다.</p>
						<a class="text-black text-sm font-weight-bold mb-0 icon-move-right mt-auto" 
		                	href="${pageContext.request.contextPath }/currency/list">
		                  바로 가기
		                  <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
		                </a>
					</div>
				</div>
			
			</div>

			<div class="col-4">
			
				<div class="card">
					<div class="card-header p-0 mx-3 mt-3 position-relative z-index-1">
						<a href="javascript:;" class="d-block"> <img
							src="${path }/resources/assets/img/shopping/mytheresa.png"
							class="img-fluid border-radius-lg">
						</a>
					</div>

					<div class="card-body pt-2">
						<span
							class="text-gradient text-primary text-uppercase text-xs font-weight-bold my-2">EUR</span>
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							Mytheresa </a>
						<p class="card-description mb-4">지금 럭셔리 Best Of The Rest를 쇼핑하세요! 여성을 위한 럭셔리 디자이너 패션 온라인샵 마이테레사에서 유럽의 감성을 쇼핑하세요! </p>
						
						<a class="text-black text-sm font-weight-bold mb-0 icon-move-right mt-auto" 
		                	href="${pageContext.request.contextPath }/currency/list">
		                  바로 가기
		                  <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
		                </a>
						
					</div>
				</div>
			</div>


		</div>














		<div class="row">
      	<div class="col-12 mt-4">
          <div class="card mb-4">
            <div class="card-header pb-0 p-3">
              <h4 class="font-weight-bolder">글로벌 하나페이 전용 상품</h4>
              <p class="text-sm">글로벌 하나페이 고객들만을 위한 특가 상품을 지금 바로 만나보세요</p>
            </div>
			<div class="card-body p-3">





	<c:forEach var="product" items="${products }" varStatus="status">

		<c:if test="${status.count % 4 eq 1 }">
			<div class="row" style="margin: 1.5rem">
		</c:if>

				<div class="col-xl-3 col-md-6 mb-xl-0 mb-4">
					<div class="card card-blog card-plain">
						<div class="position-relative">
							<a type="button" class="d-block shadow-xl border-radius-xl" onclick="javascript:detail('${product.no}')"> 
								<img src="${product.img }" alt="img-blur-shadow"
									class="img-fluid shadow border-radius-xl">
							</a>
						</div>
						<div class="card-body px-1 pb-0">
							<p class="text-gradient text-dark mb-2 text-sm">${product.partnerShopVO.shopName}/ <span class="mb-2 text-xs">${product.brand } </span></p>
							<a type="button" onclick="javascript:detail('${product.no}')">
								<h5><c:out value="${fn:substring(product.name ,0,40)}"/>...</h5>
							</a>
							<h6 class="mb-2 text-end">${product.currency}&nbsp;${product.price }</h6>
							
							
							<div class="d-flex align-items-center justify-content-between">
								<a type="button"
									class="btn btn-outline-primary btn-sm mb-2">구매하기</a>
								
								
								<!-- Start : 찜하기, 알림신청  -->
								<div class="avatar-group mt-2">


								    <!-- Button trigger modal : 찜하기 버튼 -->
									<a title="찜하기" class="shopping-favourite" data-value="${product.no }">
									<!--<a data-bs-toggle="modal" data-bs-placement="bottom"
										title="찜하기"  data-bs-target="#add-favourite-list-modal" id="shopping-favourite"> -->
										<img alt="Image placeholder"
												src="${pageContext.request.contextPath }/resources/assets/img/picture/heart.png" style="width: 1.5rem;height: 1.5rem">
									</a>
																		
								    <!-- Modal : 찜하기 모달 -->
									<div class="modal fade" id="add-favourite-list-modal" tabindex="-1" role="dialog" aria-labelledby="modal-notification" aria-hidden="true">
								      <div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
								        <div class="modal-content">
								          <div class="modal-header">
								            <h6 class="modal-title" id="add-favourite-list-modal-title">찜하기</h6>
								            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
								              <span aria-hidden="true">×</span>
								            </button>
								          </div>
								          <div class="modal-body">
								            <div class="py-3 text-center">
								              <i class="ni ni-favourite-28 ni-3x"></i>
								              <h4 class="text-gradient text-primary mt-4">찜하기 결과</h4>
								              <p class="favourite-result-msg"></p>
								            </div>
								          </div>
								          <div class="modal-footer">
								            <button type="button" class="btn btn-white">
								            	<a href="${path }/shopping/favourite">
								            		찜목록 이동
								            	</a>
								            </button>
								            <button type="button" class="btn btn-link ml-auto" data-bs-dismiss="modal">계속 쇼핑하기</button>
								          </div>
								        </div>
								      </div>
								    </div>
																	
																		
																		
																		
																		
								    <!-- Button trigger modal : 알람신청 버튼 -->
								    <a class="shopping-alarm" 
								    	data-value="${product.no }" data-price="${product.price }" data-currency="${product.currency }">
<!-- 								    <a data-bs-toggle="modal" data-bs-placement="bottom"
											title="알람신청"  data-bs-target="#RegisterShoppingAlarm" id="shopping-alarm"> -->
										<img alt="Image placeholder"
												src="${pageContext.request.contextPath }/resources/assets/img/picture/alarm.png" style="width: 1.3rem;height: 1.3rem">
									</a>
								    
								    <!-- Modal : 알람신청 모달 -->
								    <div class="modal fade" id="register-shopping-alarm-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
								      <div class="modal-dialog modal-dialog-centered" role="document">
								        <div class="modal-content">
								          <div class="modal-header">
								            <h5 class="modal-title" id="register-shopping-alarm-modal-title">알림신청</h5>
								            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
								              <span aria-hidden="true">×</span>
								            </button>
								          </div>
								          <div class="modal-body">
								            <form>
								              <div class="form-group">
								               
								               	<div class="row">
									                <div class="col-6">
									               		<label for="cur-rate" class="col-form-label">현재 환율 : </label>
									                	<span class="form-control" id="cur-rate" style="text-align: center">
									                	</span>
									                </div>
									                <div class="col-6">
										                <label for="cur-price" class="col-form-label">상품 가격 : </label>
									                	<span class="form-control" id="cur-price" style="text-align: center">
									                	</span>
									                </div>
									            </div>
									            <div class="row">
										            <div class="w-100"></div>
										            <div class="col">
									                	<h1 class="display-6" id="cur-price-won" style="text-align: center;margin-top: 1rem;"></h1>
										            </div>
									            </div>
									            
								              </div>
								              
								              <div class="row">
									              <div class="form-group">
									                <label for="target-price" class="col-form-label">목표 가격 : </label>
									                <input type="text" class="form-control" placeholder="알림을 받고 싶은 원화 가격을 입력하세요!" id="target-price" style="text-align: center;">
									              	<h1  class="display-6" id="target-rate" style="text-align: center;margin-top: 1rem;"></h1>
									              	<p class="display-7" id="target-rate-change" style="text-align: center;"></p>
									              </div>
									              
								              </div>
								            </form>
								          </div>
								          <div class="modal-footer">
								            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">취소하기</button>
								            <button type="button" class="btn bg-gradient-primary complete-alarm-register">알림신청</button>
								          </div>
								          
								        
								          
								          
								          
								          
								          
								        </div>
								      </div>
								    </div>
													
								</div>
								<!-- End : 찜하기, 알림신청  -->
								
							</div>
						</div>
					</div>
				</div>

		<c:if test="${status.count % 4 eq 0 }">
			</div>
		</c:if>

	</c:forEach>

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
  <!--   Core JS Files  end -->
  
</body>

</html>