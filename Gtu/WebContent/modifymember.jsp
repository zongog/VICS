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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

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

	<script>
		$(document)
				.ready(
						function() {
							//    alert('jquery test');
							/* 입력폼 유효성 관련 요구사항
							    1. 모든 폼은 공백 또는 "" 문자는 입력되면 안된다.
							    2. 비밀번호는 4자이상 입력하여야 한다.
							 */
							$('#idcheck')
									.click(
											function() {
												if ($('#id').val().length < 4) {
													alert('ID는 4자이상 이어야 합니다');
													$('#id').focus();
												} else {
													var url = "checkId.do?id="
															+ form.id.value;
													win = window
															.open(url,
																	"idCheck",
																	"width=400, height=400, left=100, top=100");
												}
											});
						});
	</script>
	<script>
		$(document)
				.ready(
						function() {
							//    alert('jquery test');
							/* 입력폼 유효성 관련 요구사항
							    1. 모든 폼은 공백 또는 "" 문자는 입력되면 안된다.
							    2. 비밀번호는 4자이상 입력하여야 한다.
							 */
							$('#submitbutton')
									.click(
											function() {
												if ($('#pw').val().length < 4) {
													alert('Password는 4자이상 이어야 합니다');
													$('#pw').focus();
												} else if ($('#id').val().length < 4) {
													alert('ID는 4자이상 이어야 합니다');
													$('#id').focus();
												} else if ($('#pw').val() != $(
														'#repeatpw').val()) {
													alert('Password와 Password 확인이 일치하지 않습니다.');
													$('#pw').focus();
												} else if ($('#name').val() == '') {
													alert('name을 입력하세요');
													$('#name').focus();
												} else if ($('#mail').val() == '') {
													alert('mail을 입력하세요');
													$('#mail').focus();
												} else if ($('#serial_number')
														.val() == '') {
													alert('CPA번호를 입력하세요');
													$('#serial_number').focus();
												} else {
													$('#form').submit();
												}
											});
						});
	</script>

	<h3>정보 수정</h3>
	<br>
	<form name="form" id="form"
		action="${pageContext.request.contextPath}/modifymember.do" method="post">
		<table class="table">
			<tr>
				<th>ID</th>

				<td><input id="id" name="id" class="form-control" type="text"
					value="${loginedUser.id}" placeholder="ID를 입력해주세요." readonly="readonly"></td>
			</tr>
			<tr>
				<th>Role</th>
				<td><input id="role" name="role" class="form-control"
					 value="${loginedUser.role}" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>Password</th>
				<td><input id="pw" name="pw" class="form-control"
					type="password" value="${loginedUser.pw}"
					placeholder="비밀번호를 입력해주세요."></td>
				<td><div id="passMsg" class="error"></div></td>

			</tr>
			<tr>
				<th>Password 확인</th>
				<td><input id="repeatpw" name="repeatpw" class="form-control"
					type="password" value="${loginedUser.pw}" placeholder="비밀번호 확인"></td>
			</tr>
			<tr>
				<th>Name</th>
				<td><input id="name" name="name" class="form-control"
					type="text" value="${loginedUser.name}" placeholder="이름을 입력해주세요."></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><input id="mail" name="mail" class="form-control"
					type="text" value="${loginedUser.mail}" placeholder="이메일을 입력해주세요."></td>
			</tr>
			<tr>
				<th>CPA 번호</th>
				<td><input id="serial_number" name="serial_number"
					class="form-control" type="text"
					value="${loginedUser.serial_number}" placeholder="CPA번호를 입력해주세요."></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><script>
					function fileCheck(obj) {
						document.getElementById('update_image_view').innerHTML = "<img src='" + obj + "'>";
					}
				</script> <input type="file" name="file" onchange="fileCheck(this.value);">
					<table width="80" height="80">
						<tr>
							<td align="center" id='update_image_view'>미리보기</td>
						</tr>
					</table></td>


			</tr>
		</table>
		<br>
		<div align="center">
			<input class="btn btn-success" id="submitbutton" type="button"
				value="수정"> <a class="btn btn-default"
				href="${pageContext.request.contextPath}/main">취소</a>
		</div>
	</form>
	<br>
</body>
</html>
