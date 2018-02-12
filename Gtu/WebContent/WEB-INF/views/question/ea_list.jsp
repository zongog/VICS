<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/common.jsp"%>
<title>EA질의서 관리</title>
<!-- sbSubtotal Module -->
<script type="text/javascript" src="./sbSubtotal_v2.5.js"></script>

<script type="text/javascript">
		/*현재 날짜*/
		var dt = new Date();  
		var month = dt.getMonth()+1;  
		var day = dt.getDate();  
		var year = dt.getFullYear();			
		
		var datagrid; 
		var SBGridProperties;
		var grid_data= {key1: 'asd'};
		
		$(document).ready(function(){
			__createElements();
			
		})	
		
		function __createElements (){
			
			SBGridProperties={};
			SBGridProperties.parentid 			= 'SBGridArea';
			SBGridProperties.id		  			= 'datagrid';
			SBGridProperties.jsonref  			= 'grid_data';
			
			
			
			SBGridProperties.extendlastcol = 'scroll';
			SBGridProperties.selectmode='byrow';
			
			SBGridProperties.columns = [
				{caption : ['번호'],		ref : '번호입니다.',		width : '80px',	  style : 'text-align:center',	type : 'output'},
				{caption : ['질의서 개정 제목'],		ref : '질의서 개정제목입니다.',width : '600px',  style : 'text-align:center',	type : 'output'},
				{caption : ['Veteran'],	ref : '베테랑입니다.',	width : '120px',	style : 'text-align:center',	type : 'output'},
				{caption : ['등록일'],		ref : '등록일입니다.',		width : '200px',	style : 'text-align:center',	type : 'output'},
			];

			datagrid = _SBGrid.create(SBGridProperties);
			datagrid.addEventListener("onclick","questionDetailPage","","");
		}
	
		//내림차순
		function sortColumn1() {
			datagrid.sortColumn(0,"desc");
		};
		
		// 새로만들기 버튼 클릭 시 화면 이동
		function createQuestionPage(){
	
			location.href="${pageContext.request.contextPath}/eaDetail.do";
		}
		
		// 그리드 클릭 시 detail 페이지로 화면 이동
		function questionDetailPage(){
			if(datagrid.getMouseRow()==0)
				return;
			location.href="${pageContext.request.contextPath}/selectQuestionDetail.do?version_id="+datagrid.getCellData(datagrid.getMouseRow(), 0);
		}
		
</script>
</head>
<body>
<%@ include file="/views/layout/menu.jsp"%>
	<div>
		<h1 align="left">EA질의서 관리 게시판</h1>
	</div>
	<div id="SBGridArea" align="center" style="width : 900px; height : 300px"></div>
	
	<button onclick="location.href='${pageContext.request.contextPath}/ea.detail'">등록하기</button></a>
</body>

</html>