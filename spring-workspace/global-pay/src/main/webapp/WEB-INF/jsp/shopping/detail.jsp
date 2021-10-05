<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script> -->
<script src="${pageContext.request.contextPath }/resources/assets/js/plugins/chartjs.min.js"></script>
<script type="text/javascript">
$(document).on('ready', function(){
	
	let dataSet = new Array();
	let curPrice = $('#curPrice').val();
	let totalProfit = $('#totalProfit').val();
	dataSet.push(curPrice);
	dataSet.push(curPrice - totalProfit);
	dataSet.push(totalProfit);
	
	shoppingProfitChart("shopping-profit-chart", dataSet);
})

function shoppingProfitChart(elementId, dataSet){
	// Bar chart
	var ctx5 = document.getElementById(elementId).getContext("2d");
	
	new Chart(ctx5, {
	  type: "bar",
	  data: {
	    labels: ['현재 가격', '할인 가격', '총 혜택'],
	    datasets: [{
	      label: "원화 가격",
	      weight: 5,
	      borderWidth: 0,
	      borderRadius: 4,
	      backgroundColor: '#3A416F',
	      data: dataSet,
	      fill: false,
	      maxBarThickness: 35
	    }],
	  },
	  options: {
	    responsive: true,
	    maintainAspectRatio: false,
	    plugins: {
	      legend: {
	        display: false,
	      }
	    },
	    scales: {
	      y: {
	        grid: {
	          drawBorder: false,
	          display: true,
	          drawOnChartArea: true,
	          drawTicks: false,
	          borderDash: [5, 5]
	        },
	        ticks: {
	          display: true,
	          padding: 10,
	          color: '#9ca2b7'
	        }
	      },
	      x: {
	        grid: {
	          drawBorder: false,
	          display: false,
	          drawOnChartArea: true,
	          drawTicks: true,
	        },
	        ticks: {
	          display: true,
	          suggestedMin: 1000,
	          color: '#9ca2b7',
	          padding: 10
	        }
	      },
	    },
	  },
	});
}
let productNo;
function buyProduct(no){
	productNo = no;
	
	let url = '${path}/buy/gen/token'
	// 1. id로 cardNo, cvc 확인해서 토큰 발급받기
	$.ajax({ 
		url :  url
		, type : "get"
		, success : function(token){
			//setCookie("token", result, 5);
			//let token = getCookie("token")
			openPasswordModal(token.result)
		}
		, error : function(){
			alert("Ajax Error")
		}
	});
}

function openPasswordModal(token){
	
	let url = '${path}/shopping/buy';
	
	$('#buyPWModal').modal('show')
	
	$('#productBuy').on("click", function(){
		$.ajax({ 
			url :  url
			, type : "post"
			, data : {
				productNo : productNo
				, token : token
			}
			, success : function(result){
				console.log(result)
				$('#buyPWModalBody').hide();
				$('#buyResultModalBodyMSG').text(result);
				$('#buyResultModalBody').show();
				//$('#buyPWModal').modal('hide');
				//location.href='${path}/';
			}
			, error : function(){
				alert("Ajax Error")
			}
		});
		
	})
	

	
	

	
}


function setCookie(cookie_name, value, miuntes) {
	const exdate = new Date();
	exdate.setMinutes(exdate.getMinutes() + miuntes);
	const cookie_value = escape(value)
			+ ((miuntes == null) ? '' : '; expires=' + exdate.toUTCString());
	document.cookie = cookie_name + '=' + cookie_value;
}
function getCookie(cookie_name) {
	var x, y;
	var val = document.cookie.split(';');

	for (var i = 0; i < val.length; i++) {
		x = val[i].substr(0, val[i].indexOf('='));
		y = val[i].substr(val[i].indexOf('=') + 1);
		x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
		if (x == cookie_name) {
			console.log(y)
			return unescape(y); // unescape로 디코딩 후 값 리턴
		}
	}
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
	<div class="modal fade" id="buyPWModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalSignTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	    
	      <div id = "buyPWModalBody">
		      <div class="modal-body p-0">
		        <div class="card card-plain">
		          <div class="card-header pb-0 text-left">
		              <h3 class="font-weight-bolder text-primary text-gradient">결제 비밀번호</h3>
		              <p class="mb-0">결제 비밀번호를 입력하세요.</p>
		          </div>
		          <div class="card-body pb-3">
		            <form role="form text-left">
		              <div class="input-group mb-3">
		                <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호 숫자 네자리를 입력하세요" aria-label="Email" aria-describedby="email-addon">
		              </div>
		              <div class="text-center">
		                <button type="button" id="productBuy" class="btn bg-gradient-primary btn-lg btn-rounded w-100 mt-4 mb-0">구매하기</button>
		              </div>
		            </form>
		          </div>
		        </div>
		      </div>
	      </div>
	      <div id = "buyResultModalBody" style="display: none">
	      	<div class="modal-body p-0">
		        <div class="card card-plain">
		          <div class="card-header pb-0 text-left">
		              <h3 class="font-weight-bolder text-primary text-gradient">결제 완료</h3>
		              <p class="mb-0" id="buyResultModalBodyMSG">결제 결과를 안내드립니다.</p>
		          </div>
		          <div class="card-body pb-3">
		            <h4 class="text-gradient text-danger mt-4" id="buyResultModalBodyMSG"></h4>
		            <div class="text-center">
		                <a type="button" href="${path }/charge" class="btn bg-gradient-primary btn-lg btn-rounded w-100 mt-4 mb-0">충전하기</a>
		              </div>
		          </div>
		        </div>
		      </div>
	      </div>
	      
	      
	    </div>
	  </div>
	</div>
    
    
    
<!-- Start container -->
    <div class="container-fluid py-4">
    
    
      <!-- row start -->
      <div class="row">
        
      <!-- row mt-4 start -->
      <div class="bg-gradient-default row mt-4 ">
        <div class="col-lg-4 mb-lg-0 mb-4">
        
        
          <div class="card">
			<div class="card-header p-0 mx-3 mt-3 position-relative z-index-1">
				<span class="text-gradient text-primary text-uppercase text-sm font-weight-bold my-2">상품</span>
			</div>

			<div class="card-body pt-2">
			
				<div class="row">
					<div class="col-4">
						<a href="javascript:;" class="d-block"> 
							<img src="${product.img }" class="img-fluid border-radius-lg" style="text-align: -webkit-center;">
						</a>
					</div>
					<div class="col-8 mt-5">
						<div class="d-flex align-items-end flex-column justify-content-center">
						  <span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2 opacity-6">${product.brand }</span>
		                  <h5 class="mb-0 text-xl">${product.name }</h5>
		                  <p class="card-description mb-4">${product.price } ${product.currency }</p>
		                </div>
					</div>
					<div class="col-12">
						<c:if test="${ myPrice ge curPrice}">
              				<a href="${path }/charge" type="button" class="btn bg-gradient-info btn-lg w-100">즉시 충전하기</a>
             			</c:if>
              			<%-- <a href="${path }/shopping/buy/${product.no}"  --%>
              			<a href="javascript:buyProduct('${product.no}')" 
              				type="button" class="btn bg-gradient-info btn-lg w-100">즉시 구매하기</a>
	              	</div>
				</div>
				
			</div>
		  </div>
        </div>
        <div class="col-lg-8">
          <div class="card z-index-2">
            <div class="card-header pb-0">
              <!-- <span class="text-gradient text-primary text-uppercase text-xs font-weight-bold my-2">가격비교</span> -->
			  <p class="card-description mb-4">실시간 환율로 더 유리한 환율 조건을 확인하세요!</p>
            </div>
            <div class="card-body p-3">
            
            
	          
	          
	          
            
		      	<div class="row">
			      	<div class="col-6">
						<h5 class="ms-2 mb-0"> 
							<span class="badge badge-pill badge-lg bg-gradient-success">현재 환율로 구매 시</span>
							<span>약 
								<code>
									<c:set var="curPrice" value="${ vo.transferSendRate * product.price}"/>
									<fmt:formatNumber type="number" maxFractionDigits="2" value="${ curPrice} " /> 
								</code>
							￦
							</span>
						</h5>
<c:if test="${not empty dto}">
						<h5 class="ms-2 mt-4 mb-0"> 
							<span class="badge badge-pill badge-lg bg-gradient-success">보유 외화로 구매 시</span>
							
			              		<span>약 
									<code>
										<c:set var="myPrice" value="${ dto.krAmount / dto.feAmount * product.price * -1}"/>
										<fmt:formatNumber type="number" maxFractionDigits="2" value="${ myPrice} " /> 
									</code>
								￦
								</span>
		              	</h5>
</c:if>

					</div>
              	</div>
			  
              <!-- <p class="text-sm">
                <i class="fa fa-arrow-up text-success"></i>
                <span class="font-weight-bold">4% more</span> in 2021
              </p> -->
              
              <div class="row">
              	<div class="col-12">
<c:if test="${not empty dto}">              	
              		<h5 class="text-end">
              		약 
              			<code>
              				<c:if test="${ myPrice gt curPrice}">
	              				<c:set var="priceDifference" value="${ myPrice - curPrice}"/>
              				</c:if>
              				<c:if test="${ myPrice le curPrice}">
	              				<c:set var="priceDifference" value="${ curPrice - myPrice}"/>
              				</c:if>
              				<fmt:formatNumber type="number" maxFractionDigits="2" value="${ priceDifference} " /> 
              			</code> 
              		￦ 절약 가능
              		</h5>
</c:if>
              	</div>
              </div>
              
              <hr class="mb-4 mt-4">
              <div class="row">
		      	<div class="col-12">
					<h5 class="ms-2 mb-0"> 
						<span class="badge badge-pill badge-lg bg-gradient-success">글로벌 페이 이용 시</span>
						<span>
						카드 수수료 (약 2.5%)
						</span>
					</h5>
				</div>
             	</div>
			<div class="row">
             		<div class="col-12">
					<h5 class="text-end">
						<span>
						약 
							<code>
								<c:set var="cardCommission" value="${curPrice * 0.025 }"/>
								<fmt:formatNumber type="number" maxFractionDigits="2" value="${cardCommission } " /> 
							</code>
						￦ 절약 가능
						</span>
					
					</h5>
				</div>
			</div>
		      	
		      	
		      	
            
            <div class="row mt-3" style="display: table-flex">
			      	<div class="col-6">
			             <div class="card mb-3">
				            <div class="card-body p-3">
				              <div class="chart">
				                <canvas id="shopping-profit-chart" class="chart-canvas" height="300px"></canvas>
				              </div>
				            </div>
				          </div>
				    </div>
				    <div class="col-6">
			             <div class="card mb-3" style="height: 95%">
				            <div class="card-body p-3 bg-gradient-dark border-radius-lg">
			              		<h3 class="text-center mt-8 text-white">
									총
										<code>
											<c:if test="${not empty priceDifference }">
												<c:set var="totalProfit" value="${cardCommission + priceDifference }"/>
											</c:if>
											<c:if test="${empty priceDifference }">
												<c:set var="totalProfit" value="${cardCommission }"/>
											</c:if>
											<fmt:formatNumber type="number" maxFractionDigits="2" value="${totalProfit } " /> 
										</code>
									￦ <br>절약 가능
								</h3>
				            </div>
				          </div>
				    </div>
			</div>
		      	
		      	
		      	<!-- 자바스크립트에서 사용할 변수 -->
		      	<input type="hidden" id="curPrice" value='<c:out value="${curPrice }"/>'>
		      	<input type="hidden" id="totalProfit" value='<c:out value="${totalProfit }"/>'>
		      	
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