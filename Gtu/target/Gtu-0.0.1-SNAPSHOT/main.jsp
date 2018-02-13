<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<%@ include file="/views/layout/common.jsp"%>
<link href="resources/css/bootstrap_modify.css" rel="stylesheet" type="text/css" />
<title>소셜보드</title>
	<!-- 제품위치 설정을 하는 제품 상대경로입니다. SBGrid 폴더의 상위까지 설정합니다. -->
	<script type="text/javascript">			
		var SBpath = "resources/";
	</script>

	<!-- 그리드를 표시하기 위한 CSS -->
	<link type="text/css" href="resources/SBGrid/css/SBGrid.css" rel="stylesheet">
	<link type="text/css" href="resources/SBGrid/css/SBGrid_Default.css" rel="stylesheet">
	<style type="text/css"></style>

	<!-- SBGrid 제품 설정 -->
	<script src="resources/SBGrid/SBGrid_Lib.js" type="text/javascript"></script> 
	<script src="resources/SBGrid/SBGrid_min.js" type="text/javascript"></script> 
	
	
	<script type="text/javascript">
	
		
		var grid_data = ${questionListJson};
		
		var datagrid; // 그리드를 담기위한 객체를 선언합니다.

		$(document).ready(function(){
			createElements();
		});
		
	
		function createElements(){
			var SBGridProperties = {}
			SBGridProperties.parentid = 'SBGridArea';  // [필수] 그리드 영역의 div id 입니다.            
			SBGridProperties.id = 'datagrid';          // [필수] 그리드를 담기위한 객체명과 동일하게 입력합니다.                
			SBGridProperties.jsonref = 'grid_data';    // [필수] 그리드의 데이터를 나타내기 위한 json data 객체명을 입력합니다.
			SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';
			SBGridProperties.emptyrecordsfontstyle = "color:#004e3d; font-size:20px; font-weight bold;";
			SBGridProperties.allowselection = false;
			
			SBGridProperties.width = '1200px';     // 위의 div id 영역(sbGridArea)에 그리드의 너비와 폭을 입력하지 않았을때 width 와 height 를 입력합니다.
			SBGridProperties.height = '300px';    // [그리드의 너비와 폭은 반드시 설정되어야 합니다]

			// 그리드의 여러 속성들을 입력합니다.
			SBGridProperties.extendlastcol = 'scroll';
			SBGridProperties.tooltip = true;
			SBGridProperties.ellipsis = true;
			SBGridProperties.backcoloralternate = '#FFF2FF';

			// [필수] 그리드의 컬럼을 입력합니다.  
			SBGridProperties.columns = [
				{caption : ['번호'],		ref : 'id',		width : '80px',	  style : 'text-align:center',	type : 'output'},
				{caption : ['제목'],		ref : 'title', width : '700px',  style : 'text-align:center',	type : 'output'},
				{caption : ['등록일'],	ref : 'n_date',		width : '200px',	style : 'text-align:center', format : {type:'date', rule:'yyyy-mm-dd', origin : 'yyyymmdd' }},
				{caption : ['조회수'],	ref : 'hits',  width : '130px',  style : 'text-align:center',	type : 'output'},
				{caption : ['첨부파일'],	ref : 'attachment',width : '130px',  style : 'text-align:center',	type : 'output'},
				
			];			
			datagrid = _SBGrid.create(SBGridProperties); // 만들어진 SBGridProperties 객체를 파라메터로 전달합니다.
			datagrid.bind('onclick', 'clickCellEvn');
		}
		
		function clickCellEvn(){
			location.href="noticedetail.do?id="+ datagrid.getRow();
		};	 
		
	</script>
<SCRIPT>
	function change(style) {

		if (style == "selectBox01") {
			view1.style.display = "inline"
			view2.style.display = "none"
			view3.style.display = "none"
		}
		if (style == "selectBox00") {
			view1.style.display = "none"
			view2.style.display = "none"
			view3.style.display = "none"
		}
		if (style == "selectBox02") {
			view1.style.display = "none"
			view2.style.display = "inline"
			view3.style.display = "none"
		}
		if (style == "selectBox03") {
			view1.style.display = "none"
			view2.style.display = "none"
			view3.style.display = "inline"
		}
	}
</SCRIPT>

<style type="text/css">
.col-lg-12{ margin:0; padding:0;}
.containers{ margin:0; width:100%;}


#nav { float: center; list-style: none; margin:0; padding:0; height: 100px; width:100%; background: #C5E0B4;  }
#nav li { float: left; margin: 25px 0px 0px 5px; }
#nav li a { color: #FFFFFF; display: block; font-size: 35px; padding: 5px 15px; }
#nav li a:hover, #nav li.active a { background: green; color: #ffffff; text-decoration: none; }




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
						<h1 align="left">공지사항</h1>
					</div>
							<div align="right"><select onChange="change(this.options[this.selectedIndex].value)">
									<option value="selectBox00">::: 검색조건 :::</option>
									<option value="selectBox01">제목</option>
									<option value="selectBox02">내용</option>
									<option value="selectBox03">번호</option>
								</select>
								<div id=view1 style="display: none;">
									<form action="findBet.do">
										<input type="hidden" name="betWay" value="${betWay }">
										<input size="50" type="text" name="betId" placeholder="제목으로검색"> 
										<input class="btn btn-xs btn-default" type="submit" value="검색">
									</form>
								</div>
								<div id=view2 style="display: none;">
									<form action="findBet.do">
									<input type="hidden" name="betWay" value="${betWay }"> 
										<input size="50" type="text" name="betOwner" placeholder="내용으로 검색"> <input
											class="btn btn-xs btn-default" type="submit" value="검색">
									</form>
								</div>
								<div id=view3 style="display: none;">
									<form action="findBet.do">
									<input type="hidden" name="betWay" value="${betWay }"> 
										<input size="50" type="text" name="title" placeholder="번호로 입력하세요"> <input
											class="btn btn-xs btn-default" type="submit" value="검색">
									</form>
				</div>
						</div><Br><br><Br>
					<div id="SBGridArea" align="center"></div>
			</div>
		</div>
		<a href="noticewrite.jsp"><button>글작성</button></a>

</body>
</html>