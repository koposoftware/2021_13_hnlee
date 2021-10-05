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
  <script src="${pageContext.request.contextPath }/resources/assets/js/plugins/chartjs.min.js"></script>
</head>
<script type="text/javascript">
// 전역변수
let currencyEn;

$(document).on('ready', function(){
	
	
});
function drawProfitChart(labels, data1, data2){
	
	$("#mixed-chart-profit").remove();
	var canvasHtml = '<canvas id="mixed-chart-profit" class="chart-canvas" height="300px"></canvas>';
	$("#canvas_container").append(canvasHtml);
	
	// Mixed chart
	var profitChart = document.getElementById("mixed-chart-profit").getContext("2d");
    var gradientStroke1 = profitChart.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

	var chart =  new Chart(profitChart, {
	    data: {
	      labels: labels,
	      datasets: [{
	          type: "bar",
	          label: "환율 차이",
	          weight: 5,
	          tension: 0.4,
	          borderWidth: 0,
	          pointBackgroundColor: "#3A416F",
	          borderColor: "#3A416F",
	          backgroundColor: '#3A416F',
	          borderRadius: 4,
	          borderSkipped: false,
	          data: data1,
	          maxBarThickness: 15,
	        },
	      ],
	    },
	    options: {
	      responsive: true,
	      maintainAspectRatio: false,
	      plugins: {
	        legend: {
	          display: false,
	        }
	      },
	      interaction: {
	        intersect: false,
	        mode: 'index',
	      },
	      scales: {
	        y: {
	          grid: {
	            drawBorder: false,
	            display: true,
	            drawOnChartArea: true,
	            drawTicks: false,
	            borderDash: [7, 7]
	          },
	          ticks: {
	            display: true,
	            padding: 10,
	            color: '#b2b9bf',
	            font: {
	              size: 20,
	              family: "Open Sans",
	              style: 'normal',
	              lineHeight: 2
	            },
	          }
	        },
	        x: {
	          grid: {
	            drawBorder: false,
	            display: true,
	            drawOnChartArea: true,
	            drawTicks: true,
	            borderDash: [5, 5]
	          },
	          ticks: {
	            display: true,
	            color: '#b2b9bf',
	            padding: 10,
	            font: {
	              size: 11,
	              family: "Open Sans",
	              style: 'normal',
	              lineHeight: 2
	            },
	          }
	        },
	      },
	    },
	  });
}



function showEarnings(value){
	
	currencyEn = value;
	$.ajax({ 
		url :  "${path}/card/profit"
		, type : "post"
		, data : {
			currencyEn : currencyEn
		}
		, success : profitPage
		, error : function(){
			alert("Ajax Error")
		}
	});
}

function profitPage(result){
	console.log(result)
	
	$('#selectedCurEn').text(currencyEn);
	$('#total').text(result.dto.curKrAmount);
	
	// 환율 그래프 띄우기
	
	// 차트 내용 설정
	let list = result.list
	
	let regDates = new Array();
	let transferSendRates = new Array();
	let buyBasicRates = new Array();
	let rateNos = new Array();
	let avgPrice = result.dto.avgPrice
	let differences = new Array();

	for(var i=0; i<list.length; i++){
		
    	regDates.push(list[i].regDate);
    	transferSendRates.push(list[i].transferSendRate);
    	buyBasicRates.push(list[i].buyBasicRate);
    	rateNos.push(list[i].no);
    	differences.push((list[i].transferSendRate - avgPrice).toFixed(2));
    	//differences.push((list[i].transferSendRate - avgPrice / avgPrice).toFixed(2) * 100);
	};
	
/* 	let len = json.length;
	curTransRate = transferSendRates[len - 1]
	curBasicRate = buyBasicRates[len - 1]
	curRateNo = rateNos[len - 1] */
	
	
	drawProfitChart(regDates, differences, transferSendRates)
	
	
	// 수익률 띄우기
	$('#avgPrice').text(result.dto.avgPrice);
	$('#profitLoss').text(result.dto.profitLoss);
	$('#totalPL').text(result.dto.totalPL);
	$('#profitLossRate').text(result.dto.profitLossRate);
	
	
	
	$('#profitBoardNull').replaceWith($('#profitBoard'));
	$('#profitBoard').show();
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
          <h6 class="font-weight-bolder mb-0">내 수익률</h6>
        </nav>
<!-- row start -->


		<div class="row mt-4">
			<div class="col-md-4 mt-4">
	          <div class="card z-index-2">
	            <!-- <div class="card-header pb-0">
	              <h6>보유 통화</h6>
	            </div> -->
	            <div class="card-body p-3">
				  <div class="table-responsive" style="overflow-y: auto;height: 550px;">
				    <table class="table align-items-center mb-0">
				      <thead>
				        <tr>
				          <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">국가명</th>
				          <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">통화코드</th>
				          <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">잔액</th>
				        </tr>
				      </thead>
				      <tbody>
				      	<c:forEach var="vo" items="${balances }">
					        <tr class="cursor-pointer balanceList" onclick="showEarnings('${ vo.currencyEn }')">
					          <td>
					            <div class="d-flex">
					              <div class="p-1">
					                <img src="${path }/resources/assets/img/flag/24/${vo.nationCodeVO.nationEnInitial }/${vo.nationCodeVO.nationEn }.png" />
					              </div>
					              <div class="my-auto">
					                <h6 class="mb-0 text-xs">${ vo.nationCodeVO.nationKr }</h6>
					              </div>
					            </div>
					          </td>
					          <td>
					            <p class="text-xs font-weight-bold mb-0">${ vo.currencyEn }</p>
					          </td>
					          <td>
					              <span class="text-dark text-xs font-weight-bold">${ vo.balance }</span>
					          </td>
					
					        </tr>
						</c:forEach>
				
				      </tbody>
				    </table>
				  </div>
	            </div>
	          </div>
	        </div>	
		
		
		
		
		
		
		
		
	        <div class="col-md-8 mt-4">
	          <div class="card z-index-2">
	          
	          	<div class="card-body p-3" id="profitBoardNull">
	          		<h6 class="text-center">오른쪽 잔액을 클릭하세요</h6>
	          	</div>
	          	
	            <div class="card-body p-3" id="profitBoard" style="display: none">
	            
	              <h4 class="ms-2 mt-4 mb-4"><span id="selectedCurEn"></span> 실시간 환율 차익 </h4>
	              <!-- Start 차트  -->
	              <div class=" border-radius-lg py-3 pe-1 mb-3">
					    <div class="chart">
					      <div id="canvas_container">
					      	<canvas id="mixed-chart-profit" class="chart-canvas" height="300px"></canvas>
					      </div>
					    </div>
	              </div>
	              <!-- End 차트 -->
	              
	              
	              <h4 class="ms-2 mt-4 mb-4"><span id="selectedCurEn"></span> 현재 수익률 </h4>
	              
	              <div class="container">

		              <div class="row text-lg p-3">
					    <div class="col col-lg-5 text-center">
					      	<span class="badge bg-gradient-warning" style="width: 100px">
								평균 가격
							</span>
					    </div>
					    <div class="col-md-4 text-end">
					      <h5 id="avgPrice">Variable width content</h5>
					    </div>
					    <div class="col col-lg-2">
					      <h5>￦</h5>
					    </div>
					  </div>


		              <div class="row text-lg p-3">
					    <div class="col col-lg-5 text-center">
					      	<span class="badge bg-gradient-warning" style="width: 100px">
								평균 손익
							</span>
					    </div>
					    <div class="col-md-4 text-end">
					      <h5 id="profitLoss">Variable width content</h5>
					    </div>
					    <div class="col col-lg-2">
					      <h5>￦</h5>
					    </div>
					  </div>


		              <div class="row text-lg p-3">
					    <div class="col col-lg-5 text-center">
					      	<span class="badge bg-gradient-warning" style="width: 100px">
								총 
								<span class="currencyCode"></span>
								손익
							</span>
					    </div>
					    <div class="col-md-4 text-end">
					      <h5 id="totalPL">Variable width content</h5>
					    </div>
					    <div class="col col-lg-2">
					      <h5>￦</h5>
					    </div>
					  </div>
					  
		              <div class="row text-lg p-3">
					    <div class="col col-lg-5 text-center">
					      	<span class="badge bg-gradient-warning" style="width: 100px">
								총 
								<span class="currencyCode"></span>
								수익률
							</span>
					    </div>
					    <div class="col-md-4 text-end">
					      <h5 id="profitLossRate">Variable width content</h5>
					    </div>
					    <div class="col col-lg-2">
					      <h5>%</h5>
					    </div>
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
  <!--   Core JS Files  end -->
  
</body>

</html>