<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="resources/css/bootstrap_modify.css" rel="stylesheet" type="text/css" />

<div class="navbar navbar-default navbar-fixed-top">
    <div class="container" style="margin-left: 0; margin-right: 0">
        <div class="navbar-header">
            <a class="navbar-brand" style="margin-left: 0px;" href="#">
           	<img width=500 height="90" alt="VICS" src="resources/images/VICS.png"></a>
        </div>
        	<p class="navbar-brands">${loginedUser.name}님 환영합니다.</p>
            <a class="navbar-brandss" href="${pageContext.request.contextPath}/logout.do"> [로그아웃]</a>
            <a class="navbar-brandss" href="#">[정보수정]</a>
    </div>
</div>


<div class="containers">
	<div class="col-lg-12">
		<div class="jumbotron">
			<h2>${categoryDetail.categoryName}</h2>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-12 col-lg-12">
		<ul class="nav nav-pills">
		  <li role="presentation"><a href="${pageContext.request.contextPath}/noticAll.do">공지사항</a></li>
		  <c:if test="${loginedUser.role eq 'CPA'}">
		  <li role="presentation"><a href="${pageContext.request.contextPath}/questionList.do">CPA질의서 관리</a></li>
		  </c:if>
		  
		  <c:if test="${loginedUser.role eq 'EA'}">
		  <li role="presentation"><a href="${pageContext.request.contextPath}/eaList.do">EA질의서 관리</a></li>
		  </c:if>
		  
		  <c:if test="${loginedUser.role eq 'Veteran'}">
		   <li role="presentation"><a href="${pageContext.request.contextPath}/veteranList.do">Veteran질의서 관리</a></li>
		  </c:if>
		  
		  <li role="presentation"><a href="findAllQnA.do">QnA 게시판</a></li>
		  <li role="presentation"><a href="#">회원 관리</a></li>
		</ul>
	</div>
</div>
		