<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/common.jsp"%>
<title>Veteran질의서 관리</title>

<script type="text/javascript">
		/*현재 날짜*/
/* 		var dt = new Date();  
		var month = dt.getMonth()+1;  
		var day = dt.getDate();  
		var year = dt.getFullYear();			
		 */
		var datagrid; 
		var SBGridProperties;
		var grid_data;
		
		$(document).ready(function(){
			grid_data= ${answerdata};

			__createElements();
		})	
		
		function __createElements (){
			
			SBGridProperties={};
			SBGridProperties.parentid 			= 'SBGridArea';
			SBGridProperties.id		  			= 'datagrid';
			SBGridProperties.jsonref  			= 'grid_data';
			
			SBGridProperties.extendlastcol = 'scroll';
			SBGridProperties.selectmode='byrow';
			SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';
			SBGridProperties.emptyrecordsfontstyle = "color:#004e3d; font-size:20px; font-weight bold;";
			SBGridProperties.rowheader = 'seq';
			
			SBGridProperties.columns = [
				{caption : ['질의서 버전 번호'],		ref : 'VERSION_ID',		width : '120px',	  style : 'text-align:center',	type : 'output'},
				{caption : ['질의서 버전 제목'],		ref : 'VERSION_TITLE',width : '400px',  style : 'text-align:center',	type : 'output'},
				{caption : ['담당EA'],	ref : 'NAME',	width : '120px',	style : 'text-align:center',	type : 'output'},
				{caption : ['담당EA 시리얼 번호'],	ref : 'INTERVIEWER_EA_ID',	width : '120px',	style : 'text-align:center',	type : 'output', hidden : true},
				{caption : ['등록일'],		ref : 'QUESTION_DATE',		width : '200px',	style : 'text-align:center',	type : 'output'}
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
	        if(datagrid.getCellData(datagrid.getMouseRow(), 1) == null)
	       		return;
			location.href="${pageContext.request.contextPath}/questionAnswerDetail.do?version_id="+datagrid.getCellData(datagrid.getMouseRow(), 1)+"&interviewer_ea_id="+datagrid.getCellData(datagrid.getMouseRow(), 4);
		}
		
		
</script>
</head>
<body>
<%@ include file="/views/layout/menu.jsp"%>
	<div>
		<h1 align="left">Veteran 질의서 게시판</h1>
	</div>
	<div id="SBGridArea" align="center" style="width : 1200px; height : 300px"></div>
	
</body>

</html>