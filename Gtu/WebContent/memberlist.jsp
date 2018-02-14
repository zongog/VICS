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
<title>회원관리</title>


</head>
<body>
	<%@ include file="/views/layout/menu.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<h1>회원 관리</h1>
				<div align="right"></div>
				<table class="table table-hover table-condensed">
					<colgroup>
						<col width="100" align="center">
						<col width="100">
						<col width="100">
						<col width="10">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th>Role</th>
							<th>사용자 ID</th>
							<th>사용자 이름</th>
							<th></th>
							<th>승인여부</th>
							<th>탈퇴</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${member}" var="member">
							<tr>
								<td class="spanTitle">${member.role}</td>
								<td><span class="spanTitle">${member.id}</span></td>
								<td><span class="spanTitle">${member.name}</span></td>
								<td><c:choose>
										<c:when test="${member.permission eq '0'}">
											<td><a class="btn btn-xs btn-info btnPlay"
									href="permission.do?id=${member.id}&role=${member.role}">미승인</a></td>
										</c:when>
										<c:otherwise>
											<td><span class="spanTitle">승인</span></td>
										</c:otherwise>
									</c:choose></td>
								<td><a class="btn btn-xs btn-info btnPlay"
									href="deletemember.do?id=${member.id}">탈퇴</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

</body>
</html>