<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">
<style type="text/css">
body {
	padding: 5% 5%;
}

body {
	background: #EEF7E9;
}
</style>
</head>
<body>
	<div align="center">
		<img width=900 height="300" src="resources/img/aaa.PNG"> <br>
		<form action="login.do" method="post">
			<table border=0 width=900 height="20">
				<tr>
					<table border=0 width=300 height=20%>
						<tr>

							<td><input id="id" name="id" class="form-control"
								type="text" value="" placeholder="아이디"></td>
						</tr>
					</table>
				</tr>
			</table>
			<table border=0 width=900 height="20">
				<tr>
					<table border=0 width=300 height=20%>
						<tr>
							<td><input id="pw" name="pw" class="form-control"
								type="password" value="" placeholder="비밀번호."
								style="ime-mode: disabled"></td>
						</tr>

					</table>
				</tr>
			</table>
			<table border=0 width=900 height="20">
				<tr>
					<table border=0 width=300 height=20%>
						<tr>
							<td><select id="role" name="role" class="form-control">
									<option value="CPA" selected>CPA
									<option value="EA" selected>EA
									<option value="Veteran" selected>Veteran</option>
							</select></td>
						</tr>

					</table>
				</tr>
			</table>
			<h3></h3>
			<input class="btn btn-success" type="submit" value="로그인">
		</form>
		<h3></h3>
		<h3></h3>
		<a class="bar" href="${pageContext.request.contextPath}/findid.do">ID찾기</a> <span class="bar">| </span><a href="${pageContext.request.contextPath}/findpw.do">PW찾기</a>
		<span class="bar">| </span><a
			href="${pageContext.request.contextPath}/join.do">회원가입</a>
	</div>
	<br>
</body>
</html>
