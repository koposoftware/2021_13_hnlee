<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">

<head>
	<jsp:include page="/WEB-INF/jsp/inc/partner/head-content.jsp"/>
	
    <link rel="stylesheet" href="${path }/resources/assets/manager/vendors/summernote/summernote-lite.min.css">
	
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
                            <h3>단일 상품 등록 </h3>
                            <p class="text-subtitle text-muted">판매할 상품을 등록하세요
                            </p>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">상품 관리</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">상품 등록</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <section class="section">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">상품 등록 신청서</h4>
                                </div>
                                
                                
                                <form method="post">
                                	<s:csrfInput/>
	                                <div class="card-body">
	                                	<div class="row mb-4">
	                                		<div class="col-md-3">
	                                			<div class="form-group row align-items-center">
	                                                <div class="col-lg-4 col-3">
	                                                    <label class="col-form-label">판매처</label>
	                                                </div>
	                                                <div class="col-lg-8 col-9">
	                                                    <p class="form-control-static mb-0" id="staticInput">
	                                                    	<a href="${vo.partnerShopVO.site }" target="_blank">
	                                                    		${vo.partnerShopVO.shopName }
	                                                    	</a>
	                                                    	<input type="hidden" value="${vo.partnerShopVO.code }" name="shopCode">
	                                                    </p>
	                                                </div>
	                                            </div>
	                                            
	                                            <div class="form-group row align-items-center">
	                                                <div class="col-lg-4 col-3">
	                                                    <label class="col-form-label disabledInput">작성자</label>
	                                                </div>
	                                                <div class="col-lg-8 col-9">
	                                                    <p class="form-control-static mb-0" id="staticInput">${vo.id }</p>
	                                                    <input type="hidden" value="${vo.id }" name="sellerId">
	                                                </div>
	                                            </div>
	                                		
	                                		</div>
	                                		
	                                		
	                                		<div class="col-md-9">
	                                        	<div class="form-group mt-2 mb-4">
			                                        <label for="basicInput">상품 브랜드</label>
			                                        <input type="text" class="form-control" name="brand">
			                                    </div>
	                                        	
	                                        	<div class="form-group mb-4">
			                                        <label for="basicInput">상품명</label>
			                                        <input type="text" class="form-control" name="name">
			                                    </div>
	                                        	
	                                        	<div class="form-group mb-4">
			                                        <label for="basicInput">가격</label>
			                                        <input type="text" class="form-control" name="price">
			                                    </div>
			                                    
	                                        	<div class="form-group mb-4">
			                                        <label for="basicInput">외화 단위</label>
			                                        <div class="input-group mb-3">
	                                                    <select class="form-select" name="currency">
	                                                        <option selected="">선택하세요</option>
	                                                        <c:forEach items="${nations }" var="nation">
		                                                        <option value="${nation.currencyEn }">${nation.nationKr } : ${nation.currencyEn }</option>
	                                                        </c:forEach>
	                                                    </select>
	                                                </div>
			                                    </div>
			                                    
	                                        	<div class="form-group mb-4">
			                                        <label for="basicInput">판매 경로 URL</label>
			                                        <input type="text" class="form-control" name="url">
			                                    </div>
			                                    
	                                        	<div class="form-group mb-4">
			                                        <label for="basicInput">판매 이미지 URL</label>
			                                        <input type="text" class="form-control" name="img">
			                                    </div>
	                                        	
	                                        	<div class="form-group mb-4">
	                                        		<label for="basicInput">기타</label>
	                                        		<textarea id="summernote_product" name="etc"></textarea>
	                                        	</div>
	                                        	<button type="submit" class="btn btn-primary btn-block my-4 compose-btn">
			                                        등록 신청
			                                    </button>
	                                        </div>
	                                    </div>
	                                    
	                                </div>
	                                
	                                
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <jsp:include page="/WEB-INF/jsp/inc/partner/footer.jsp"/>
            
        </div>
    </div>
    
    
    <jsp:include page="/WEB-INF/jsp/inc/partner/script.jsp"/>
    <script src="${path }/resources/assets/manager/vendors/summernote/summernote-lite.min.js"></script>
    <script>
        $('#summernote_product').summernote({
            tabsize: 2,
            height: 200,
        });
    </script>
    
    
</body>

</html>