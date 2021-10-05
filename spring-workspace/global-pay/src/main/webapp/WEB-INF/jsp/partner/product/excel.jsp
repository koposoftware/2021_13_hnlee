<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">

<head>
	<jsp:include page="/WEB-INF/jsp/inc/partner/head-content.jsp"/>
	<link rel="stylesheet" href="${path }/resources/assets/manager/vendors/simple-datatables/style.css">
</head>

<body>
    <div id="app">
        <jsp:include page="/WEB-INF/jsp/inc/partner/sidebar.jsp"/>
        
        
        <div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>하나은행 환율</h3>
                            <p class="text-subtitle text-muted">For user to check they list</p>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">DataTable</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <section class="section">
                    <div class="card">
                        <div class="card-header">
                            환율 조회
                        </div>
                        <div class="card-body">
                            <table class="table table-striped" id="table_excel">
                                <thead>
                                    <tr>
                                        <th>구매링크</th>
                                        <th>이미지</th>
                                        <th>브랜드</th>
                                        <th>상품명</th>
                                        <th>화폐단위</th>
                                        <th>금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="vo" items="${list }">
	                                    <tr>
	                                        <td>${vo.url }</td>
	                                        <td>${vo.img }</td>
	                                        <td>${vo.brand }</td>
	                                        <td>${vo.name }</td>
	                                        <td>${vo.currency }</td>
	                                        <td>${vo.price }</td>
	                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="row">
                            	<div class="col-6">
		                            <button type="button" class="btn btn-secondary" style="width: 10rem;height: 3rem;" 
					  						onclick="history.back()">
					  						뒤로 가기
					  				</button>
				  				</div>
				  				<div class="col-6 float-end">
			                            <button type="button" class="btn btn-primary float-end" style="width: 10rem;height: 3rem;" onclick="registerInsert()">
						  						등록 신청
						  				</button>
					  				</form>
				  				</div>
			  				</div>
                        </div>
                    </div>

                </section>
            </div>


            
            
            <jsp:include page="/WEB-INF/jsp/inc/partner/footer.jsp"/>
            
        </div>
    </div>
    
    
    <jsp:include page="/WEB-INF/jsp/inc/partner/script.jsp"/>
    <script src="${path }/resources/assets/manager/vendors/simple-datatables/simple-datatables.js"></script>
    <script>
        // Simple Datatable
        let table_excel = document.querySelector('#table_excel');
        let dataTable = new simpleDatatables.DataTable(table_excel);
    </script>
    <script type="text/javascript">
		function registerInsert(){
			
			$.ajax({ 
				url :  "${pageContext.request.contextPath}/partner/product/upload-mass"
				, type : "post"
				, data : JSON.stringify(${json})
				, success : function(){
					alert("성공")
				}
				, error : function(){
					alert("Ajax Error")
				}
			});
		}
	</script>
    
</body>

</html>