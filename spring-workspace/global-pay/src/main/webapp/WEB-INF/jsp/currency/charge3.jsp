<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 충전 3단계 -->
<div class="row" id="ThirdStep">
		<div class="card h-100">
		<div class="card-header pb-0 p-3">
			<div class="row">
				<div class="col-6 d-flex align-items-center">
					<h4 class="font-weight-bolder">3단계 : 충전 완료</h4>
				</div>
			</div>
		</div>
		
		<div class="card-body pt-4 p-3">
             <ul class="list-group">
             
               <li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
                 <div class="d-flex flex-column">
		            
		            <div class="d-flex">
		              <h6 class="mb-0 me-5 opacity-7">충전 금액</h6>
		              <h6 class="mb-0">+ ${chargeHistory.feAmount } &nbsp; ${chargeHistory.currencyEn }
		              </h6>
		            </div>
		            <hr class="horizontal dark">
		            <div class="d-flex">
		              <h6 class="mb-0 me-5 opacity-7">외화 잔액</h6>
		              <h6 class="mb-0">${chargeCurrency.afterBalance }&nbsp; ${chargeHistory.currencyEn }
		              </h6>
		            </div>
		            
		            <hr class="horizontal dark">
		            <div class="d-flex">
		              <h6 class="mb-0 me-5 opacity-7">출금 계좌</h6>
		              <h6 class="mb-0">${chargeHistory.accountBank } &nbsp;${chargeHistory.accountNum }
		              </h6>
		            </div>
		            <hr class="horizontal dark">
		            <div class="d-flex">
		              <h6 class="mb-0 me-5 opacity-7">출금 금액</h6>
		              <h6 class="mb-0">${chargeHistory.krAmount } 원 </h6>
		            </div>
		                   
                 </div>
                 <div class="ms-auto text-end">
                   <a class="btn btn-link text-danger text-gradient px-3 mb-0" href="javascript:;"><i class="far fa-bullet-list-67 me-2"></i>전체 거래 내역 보기</a>
                 </div>
               </li>
             </ul>
		</div>
	</div>
</div>



    

