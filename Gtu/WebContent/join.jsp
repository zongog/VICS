<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">
<style type="text/css">
body {
	padding: 10% 10%;
}

body {
	background: #EEF7E9;
}
</style>
</head>
<body>

	<div align="center">
	<h3><img width=912 height="250" src="resources/img/joinpage.PNG"></h3>
	</div>
	<div align="center">
	<a href="${pageContext.request.contextPath}/joincpa.do"><img width=200 height="200" src="resources/img/CPA join.PNG"></a>
	　
	<a href="${pageContext.request.contextPath}/joinea.do"><img width=200 height="200" src="resources/img/EA join.PNG"></a>
	　
	<a href="${pageContext.request.contextPath}/joinveteran.do"><img width=200 height="200" src="resources/img/Veteran join.PNG"></a>
	<br>
	</div>
</body>
</html>
