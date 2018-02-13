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
	<div class="container">
    <div class="row">

        <div class="col-sm-9 col-lg-9">
            <div>
                <h3>공지사항</h3>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                   글제목 : ${notice.title }
                </div>
                <div class="panel-body">
                    <div class="post">
                         <strong>저자명 : 관리자</strong>
                         &nbsp;<span class="text-muted">${notice.n_date }</span>
                         &nbsp;<span class="text-muted">${notice.hits }</span>

                         <a href="findNoticeByid.do?id=${notice.id }" class="glyphicon glyphicon-cog pull-right" style="padding:10px">수정</a>
                         <a href="deletenotice.do?id=${notice.id }" class="glyphicon glyphicon-trash pull-right" style="padding:10px">삭제</a>
                    </div>
                    <br>
                    <p style="padding:20px"> ${notice.content } </p>
                </div>
            </div>

            <div class="text-center">
                <a href="noticAll.do">
                    <button type="button" class="btn btn-default">목록</button>
                </a>
            </div>
        </div>
    </div>
    </div>
</body>
</html>