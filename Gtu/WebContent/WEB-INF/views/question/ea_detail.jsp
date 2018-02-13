<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
	<%@ include file="/WEB-INF/views/layout/common.jsp"%>
    <link href="${pageContext.request.contextPath}/resources/SBGrid/css/SBGrid_BOWON.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function selectReport(version_title){
			console.log(version_title);
				$.ajax({
			        url : "getReport.do?title="+version_title,
			        type: "GET",
			        // dataType: "string",
			        contentType: "application/json; charset=UTF-8",
			        success: function(response){
			            //데이터
			           console.log(response);
			           JSON.parse(response);
			        },
			        error:function (request,error) {
			           alert('\n[실패]\ncode:'+request.status+'\n'+'error:'+error);
			        }
			    });
		}
	</script>
</head>
<body style="padding: 20px">
	<%@ include file="/views/layout/menu.jsp"%>
    <div>
        <h2 style="text-align: center">질의서 선택 및 베테랑 선택화면</h2>
    </div>
    
    <table class="table">
			<tr>
				<th>질의서를 선택하세요.</th>
				<td>
					<select Name="version_title" onChange="selectReport(this.options[this.selectedIndex].value)">
					<option>선택</option>
						<c:forEach var="tuple" items="${questionList}"  varStatus="status">
						<option value="${tuple.version_title}">${tuple.version_title}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>을 입력해 주세요</th>
				<td>
					<input type="text">
				</td>
				<th>베테랑 이름을 입력해 주세요</th>
				<td>
					<input type="text">
				</td>
			</tr>
		</table>
   <div>출력 확인</div>
    <div id="EA" style="width : 720px; height : 700px" ></div>
    <div>
        <button id="save" onclick="saveAll()">저장하기</button>
        <button id="next" onclick="veteranPage()">Veteran 페이지로 이동</button>
    </div>
</body>
</html>
