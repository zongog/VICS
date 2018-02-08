<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<%@ include file="/views/layout/common.jsp"%>
<link href="resources/css/bootstrap_modify.css" rel="stylesheet"
	type="text/css" />
<title>소셜보드</title>
<!-- 제품위치 설정을 하는 제품 상대경로입니다. SBGrid 폴더의 상위까지 설정합니다. -->
<script type="text/javascript">
	var SBpath = "resources/";
</script>

<!-- 그리드를 표시하기 위한 CSS -->
<link type="text/css" href="resources/SBGrid/css/SBGrid.css"
	rel="stylesheet">
<link type="text/css" href="resources/SBGrid/css/SBGrid_Default.css"
	rel="stylesheet">
<style type="text/css"></style>

<!-- SBGrid 제품 설정 -->
<script src="resources/SBGrid/SBGrid_Lib.js" type="text/javascript"></script>
<script src="resources/SBGrid/SBGrid_min.js" type="text/javascript"></script>
<style type="text/css">
.col-lg-12 {
	margin: 0;
	padding: 0;
}

.containers {
	margin: 0;
	width: 100%;
}

#nav {
	float: center;
	list-style: none;
	margin: 0;
	padding: 0;
	height: 100px;
	width: 100%;
	background: #C5E0B4;
}

#nav li {
	float: left;
	margin: 25px 0px 0px 5px;
}

#nav li a {
	color: #FFFFFF;
	display: block;
	font-size: 35px;
	padding: 5px 15px;
}

#nav li a:hover, #nav li.active a {
	background: green;
	color: #ffffff;
	text-decoration: none;
}

nav li {
	position: relative;
	border-bottom: 1px solid #d6d6d6;
}

nav li a {
	display: block;
	padding: 15px 20px;
	font-size: 13px;
	font-weight: bold;
	color: #363636;
}

nav li a:hover {
	background: #f0f0f0;
}

nav li a:before {
	content: '';
	display: block;
	width: 4px;
	height: 44px;
	position: absolute;
	left: 0;
	top: 0;
	background: #5bc0de;
}
</style>

</head>
<body>

	<!-- Main Navigation ================================================================================= -->
	<%@ include file="/views/layout/menu.jsp"%>
	<!-- Header ========================================================================================== -->
	<div class="container">
		<div class="col-lg-12">
			<div class="jumbotron">
				<h2>${categoryDetail.categoryName }</h2>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 col-lg-12">
			<ul id="nav">
				<li><a href="noticAll.do">[공지사항]</a></li>
				<li><a href="#">[질의서 관리]</a></li>
				<li class="active"><a href="findAllQnA.do">[QnA 게시판]</a></li>
				<li><a href="#">[회원 관리]</a></li>
			</ul>
		</div>
	</div>
	<!-- Container ======================================================================================= -->
	<div class="container">
		<div class="row">

			<div class="col-sm-9 col-lg-9">
				<div>
					<h3>공지사항</h3>
				</div>

				<div class="panel panel-default containers">
					<div class="panel-heading">글제목 : ${qna.title }</div>
					<div class="panel-body">
						<div class="post">
							<strong>저자명 : 관리자</strong> &nbsp;<span class="text-muted">${qna.qnadate }</span>

							<a href="findNoticeByid.do?id=${qna.qna_id }"
								class="glyphicon glyphicon-cog pull-right" style="padding: 10px">수정</a>
							<a href="deletenotice.do?id=${qna.qna_id }"
								class="glyphicon glyphicon-trash pull-right"
								style="padding: 10px">삭제</a>
						</div>
						<br>
						<p style="padding: 20px">${qna.content }</p>
					</div>
				</div>
				<c:forEach var="comment" items="${list }">
					<table class="table" style="font-size: 13px; padding: 20px;">
						<tr>
							<td><strong>${comment.member }</strong></td>
							<td class="text-right">${comment.answer_date }<a
								class="glyphicon glyphicon-trash" href="#"></a>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<p class="txt">${comment.content }<br><br>
								
								<a href="#">댓글달기</a>
								
								</p>
							</td>
					</table>
				</c:forEach>
			</div>
		</div>
		<div class="panel-footer">
			<div class="write_area">
				<form action="registanswer.do">
					<input type="hidden" name="qna_id" value="${qna.qna_id }">
					<input type="hidden" name="member" value="관리자">
					<textarea class="input_write_comment" name="content"
						placeholder="댓글쓰기"></textarea>
					<input type="submit" class="comment_submit" value="전송">

				</form>
			</div>
		</div>
		<br>
		<div class="text-center">
			<a href="findAllQnA.do">
				<button type="button" class="btn btn-default">목록</button>
			</a>
		</div>
	</div>
</body>
</html>