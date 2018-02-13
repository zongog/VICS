<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">
<style type="text/css">
body {
	background: #EEF7E9;
}

body {
	padding: 5% 5%;
}

h1 {
	font-weight: bold;
	color: #70AD47;
}

h5 {
	color: #70AD47;
}
</style>
</head>
<body>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
		crossorigin="anonymous"></script>
	<!-- jquery를 사용하기위한 CDN주소 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<script>
		$(document).ready(function() {
			//    alert('jquery test');
			/* 입력폼 유효성 관련 요구사항
			    1. 모든 폼은 공백 또는 "" 문자는 입력되면 안된다.
			    2. 비밀번호는 4자이상 입력하여야 한다.
			 */
			var a = Math.floor(Math.random() * (900000)) + 100000;
			$('#mailsend').click(function() {
				if ($('#mail').val().length < 1) {
					alert('이메일을 입력해주세요');
				} else {
					alert($('#mail').val() + '로 메일을 보냅니다');
					alert('안녕하세요 VICS입니다. 인증번호는 ' + a + '입니다.');
					$("#random").val(a);
				}
			});

			$('#submitButton').click(function() {
				if ($('#name').val().length < 1) {
					alert('이름을 입력해주세요');
				} else if (a != $('#random').val()) {
					alert('인증번호가 다릅니다.');
				} else {
					alert('인증번호가 같습니다.');
					document.getElementById('findidbyname').submit();
				}
			});
		});
	</script>

	<div align="center">
		<img width=912 height="250" src="resources/img/aaa.PNG">


		<c:choose>
			<c:when test="${member eq null}">
				<h5>아이디 찾기를 위해 이메일로 본인확인을 진행해주세요</h5>
				<h5>가입할 때 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</h5>
				<table border=0 width=0 height="20">
				</table>
				<form action="${pageContext.request.contextPath}/findbynamemail.do"
					id="findidbyname" target="_self" method="GET">
					<table border=0 width=500 height="100">
						<tr>
							<td>이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td><input id="name" name="username" class="form-control"
								type="text" value="박준현"></td>
						</tr>
						<tr>
							<td>이메일 주소&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td><input id="mail" name="usermail" class="form-control"
								type="text" value="junpark25@naver.com"></td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td><input class="btn btn-default" type="button"
								id="mailsend" value="인증번호 받기"></td>
						</tr>
						<tr>
							<td>인증 번호 &nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td><input id="random" name="random" class="form-control"
								type="text" value="" placeholder="인증번호 6자리 입력"></td>
						</tr>
					</table>
					<table border=0 width=0 height="20">
					</table>
					<a class="btn btn-default" id="submitButton">다음</a>
				</form>
			</c:when>
			<c:otherwise>

			</c:otherwise>
		</c:choose>




		<c:forEach items="${member}" var="member" varStatus="sts">
			<tr>
				<td><h5>귀하의 아이디는 ${member.id} Role은 ${member.role}입니다.</h5></td>
			</tr>
			<tr>
				<td><a class="btn btn-default"
					href="${pageContext.request.contextPath}/">로그인창으로</a>
			</tr>
		</c:forEach>


		<br>
	</div>
</body>
</html>
