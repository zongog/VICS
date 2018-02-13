<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="resources/css/bootstrap_modify.css" rel="stylesheet" type="text/css" />

<div class="navbar navbar-default navbar-fixed-top">
    <div class="container" style="margin-left: 0; margin-right: 0">
        <div class="navbar-header">
            <a class="navbar-brand" style="margin-left: 0px;" href="#">
           	<img width=500 height="90" alt="VICS" src="resources/images/VICS.png"></a>
        </div>
        	<h2 class="navbar-brands">${name}님 환영합니다.</h2>
            <a class="navbar-brandss" href="#"> [로그아웃]</a>
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
			  <li role="presentation"><a href="${pageContext.request.contextPath}/notice.do">공지사항</a></li>
			  <li role="presentation"><a href="${pageContext.request.contextPath}/questionList.do">질의서 관리</a></li>
			  <li role="presentation"><a href="#">QnA 게시판</a></li>
			  <li role="presentation"><a href="#">회원 관리</a></li>
			</ul>
		</div>
	</div>