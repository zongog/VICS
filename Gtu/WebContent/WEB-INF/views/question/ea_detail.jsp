<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
	<%@ include file="/WEB-INF/views/layout/common.jsp"%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/question/ea_detail.js"></script>
    <link href="${pageContext.request.contextPath}/resources/SBGrid/css/SBGrid_BOWON.css" rel="stylesheet" type="text/css">
</head>
<body style="padding: 20px">
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
    <div>
        <h2 style="text-align: center">Veteran 질의서(EA용)</h2>
    </div>
    <div id="EA" style="width : 720px; height : 700px" ></div>
    <div>
        <button id="save" onclick="saveAll()">저장하기</button>
        <button id="next" onclick="veteranPage()">Veteran 페이지로 이동</button>
    </div>
</body>
</html>