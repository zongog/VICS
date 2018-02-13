<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<%@ include file="/views/layout/common.jsp"%>
<link href="resources/css/bootstrap_modify.css" rel="stylesheet"
	type="text/css" />
<title>소셜보드</title>

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
	<!-- Container ======================================================================================= -->
	<div class="containers">
		<div class="col-sm-9 col-lg-9">
			<div>
				<h1 align="left">글 작성</h1>
				<br><br>
			</div>
			<form action="registQnA.do" method="POST">
				<table class="table">
					<tr>
						<th>제목</th>
						<td><input id="loginId" name="title" class="form-control"
							type="text" value="" placeholder="제목을 입력해 주세요"></td>
					</tr>
										<tr>
						<th>작성자</th>
						<td><input id="loginId" name="member" class="form-control"
							type="text" value="${name }" placeholder=""></td>
					</tr>
										<tr>
					<th>비밀여부</th>
					<td><input type="radio" name="secret"  value="yes">공개
                        <input type="radio" name="secret"  value="no">비공개</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input id="password" name="attachment" class="form-control"
							type="file"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td> <textarea class="form-control" name="content" rows="10" id="textArea" placeholder="내용을 입력해 주세요"></textarea></td>
					</tr>

				</table>
				<br>
				<div align="center">
					<input class="btn btn-success" type="submit" value="등록"> <a
						class="btn btn-default" href="${pageContext.request.contextPath}/">취소</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>