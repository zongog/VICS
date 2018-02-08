<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="resources/css/bootstrap_modify.css" rel="stylesheet" type="text/css" />
<style>
.navbar-brands {
    float: left;
    padding: 40px 1px;
    font-size: 16px;
    line-height: 11px;
}

.navbar-brandss {
    float: left;
    padding: 60px 10px;
    font-size: 16px;
    line-height: 11px;
}
</style>

<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">
           	<img width = "240" height = "80" src="resources/images/VICS.png"></a>
        </div>
        	<h2 class="navbar-brands">${loginedUser.name}님 환영합니다.</h2>
            <a class="navbar-brandss" href="${pageContext.request.contextPath}/logout.do"> [로그아웃]</a>
            <a class="navbar-brandss" href="#">[정보수정]</a>
    </div>
    
</div>