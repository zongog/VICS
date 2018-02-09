<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/common.jsp"%>
<title>EA화면</title>
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
		var grid_data= ${questionListJson};
		
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
				{caption : ['번호'],  ref : "version_id",  width :'100px',  style : 'text-align:center;', type : 'output'},
				{caption : ['질의서 개정제목'],  ref : "version_title",  width :'300px',  style : 'text-align:center;', type : 'output'}
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
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	<input type="button" value="새로 만들기" onclick="createQuestionPage()" >
	<div id="SBGridArea" style="width : 900px; height : 300px"></div>
</body>

</html>