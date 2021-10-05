<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>   
 
		<div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="${path }/admin">
                            	<h6>하나 글로벌 페이</h6>
                           		<h7 class="text-center" style="background: aliceblue;">관리자센터</h7>
                            </a>
                            
                            <s:authorize access="isAuthenticated()"> 
                            	<a type="button" class="btn btn-sm rounded-pill btn-info" href="${path }/logout">로그아웃</a>
                            </s:authorize>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                         <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>환율 관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">환율 리스트</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">충전 내역 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">환불 내역 관리</a>
                                </li>
                            </ul>
                         </li>
                         
                         
                         <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>쇼핑 관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">상품 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">파트너사 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/pay">결제 내역 관리</a>
                                </li>
                            </ul>
                         </li>
                         
                         <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-stack"></i>
                                <span>회원 관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">일반회원 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">파트너 관리</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="${path }/admin/currency">관리자 관리</a>
                                </li>
                            </ul>
                         </li>
                        

                    </ul>
                </div>
                <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
            </div>
        </div>