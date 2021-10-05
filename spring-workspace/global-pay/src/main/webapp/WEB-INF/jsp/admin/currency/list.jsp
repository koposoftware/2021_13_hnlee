<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                            <h3>하나은행 환율</h3>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">환율 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">환율 리스트</li>
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
                                        <th>환전번호</th>
                                        <th>국가명</th>
                                        <th>화폐단위</th>
                                        <th>매매기준율</th>
                                        <th>송금보낼때 환율</th>
                                        <th>등록일시</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="vo" items="${list }">
	                                    <tr>
	                                        <td>${vo.no }</td>
	                                        <td>${vo.nationCodeVO.nationKr }</td>
	                                        <td>${vo.currencyEn }</td>
	                                        <td>${vo.buyBasicRate }</td>
	                                        <td>${vo.transferSendRate }</td>
	                                        <td>${vo.regDate }</td>
	                                        <td>
	                                            <span class="badge bg-success">수정하기</span>
	                                        </td>
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