<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">

<head>
	<jsp:include page="/WEB-INF/jsp/inc/admin/head-content.jsp"/>
	<link rel="stylesheet" href="${path }/resources/assets/manager/vendors/simple-datatables/style.css">
</head>

<body>
    <div id="app">
        <jsp:include page="/WEB-INF/jsp/inc/admin/sidebar.jsp"/>
        
        
        
        
        
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last mb-3">
                            <h3>하나페이 결제 내역</h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">쇼핑 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">결제 내역 수수료</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <section class="section">
                    <div class="card">
                        <div class="card-header">
                        </div>
                        <div class="card-body">
                            <table class="table table-striped" id="table1">
                                <thead>
                                    <tr>
                                        <th>결제 번호</th>
                                        <th>결제 일자</th>
                                        <th>화페</th>
                                        <th>결제</th>
                                        <th>할인</th>
                                        <th>원가</th>
                                        <th>수수료</th>
                                        <th>카드 번호</th>
                                        <th>회원 ID</th>
                                        <th>결제 가맹점</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="vo" items="${list }">
	                                    <tr>
	                                        <td>${vo.no }</td>
	                                        <td>${vo.regDate }</td>
	                                        <td>${vo.currencyEn }</td>
	                                        <td>
	                                        	<fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.feAmount }" /> ${vo.currencyCode }
	                                        </td>
	                                        <td>
	                                        	<fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.discountAmount }" /> ${vo.currencyCode }
	                                        </td>
	                                        <td>
	                                        	<fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.price }" /> ${vo.currencyCode }
	                                        </td>
	                                        <td>
	                                        	<fmt:formatNumber type="number" maxFractionDigits="2" value="${vo.feAmount * 0.025}" /> ${vo.currencyCode }
	                                        </td>
	                                        <td>${vo.cardNo }</td>
	                                        <td>${vo.memberId }</td>
	                                        <td>${vo.shopName }</td>
	                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </section>
            </div>


            
            
            <jsp:include page="/WEB-INF/jsp/inc/admin/footer.jsp"/>
            
        </div>
    </div>
    
    
    <jsp:include page="/WEB-INF/jsp/inc/admin/script.jsp"/>
    <script src="${path }/resources/assets/manager/vendors/simple-datatables/simple-datatables.js"></script>
    <script>
        // Simple Datatable
        let table1 = document.querySelector('#table1');
        let dataTable = new simpleDatatables.DataTable(table1);
    </script>
    
</body>

</html>