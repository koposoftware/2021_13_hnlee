<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>


				<tbody class="transaction_history">
                    <c:forEach var="rvo" items="${refund }">
	                    <tr>
	                      <td class="align-middle text-center" style="width: 5%">
	                        <div class="d-flex px-2 py-1">
				              <div>
				              	<img class="px-2" src="${path }/resources/assets/img/flag/32/${rvo.nationCodeVO.nationEnInitial }/${rvo.nationCodeVO.nationEn }.png" />
				              </div>
				              <div class="d-flex flex-column justify-content-center">
				                <h6 class="mb-0 text-sm">${rvo.currencyEn }</h6>
				                <!-- <p class="text-xs text-secondary mb-0">john@creative-tim.com</p> -->
				              </div>
				            </div>
					                        
	                      </td>
	                      <td class="align-middle text-center">
	                      	  <span class="text-xs">환불</span>
	                             
	                      </td>
	                      
	                      
	                      
	                      <td class="align-middle text-center">
	                      	<div class="d-flex align-items-center" style="place-content: center;">
			                    <button class="btn btn-icon-only btn-rounded btn-outline-danger mb-0 me-3 btn-sm d-flex align-items-center justify-content-center">
			                    	<i class="fas fa-arrow-down" aria-hidden="true"></i>
			                    </button>
			                    <div class="d-flex flex-column">
			                      <h6 class="mb-1 text-danger text-md">
	                          		<span class="mb-0 ">${rvo.feAmount }</span>
	                      			<span class="mb-0 ">${rvo.nationCodeVO.currencyCode }</span>
			                      </h6>
			                      <span class="text-xs"> ${rvo.krAmount } ￦</span>
			                    </div>
			                  </div>
	                      </td>
	                      
	                      <td class="align-middle text-center">
	                      	<span class="text-xs">${rvo.regDate }</span>
	                      </td>
	                      
	                      <td class="align-middle text-center">
	                      	<span class="text-xs">${rvo.afterBalance } ${rvo.nationCodeVO.currencyCode } </span>
				          </td>
	                      
	                    </tr>
                    </c:forEach>
 
                    
                  </tbody>                    
                   