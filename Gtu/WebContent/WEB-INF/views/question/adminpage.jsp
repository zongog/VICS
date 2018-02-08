<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <!-- 
    <script language="javascript">
        var SBpath = "./";	//SBGrid v2.5 Library인 'SBGrid'폴더 상대경로
    </script>
    <script src="./SBGrid/SBGrid_Lib.js" type="text/javascript"></script>
    <script src="./SBGrid/SBGrid_min.js" type="text/javascript"></script>
    <link href="./SBGrid/css/SBGrid.css" rel="stylesheet" type="text/css">
     -->
	<%@ include file="/WEB-INF/views/layout/common.jsp"%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/question/adminpage.js"></script>
    <link href="${pageContext.request.contextPath}/resources/SBGrid/css/SBGrid_BOWON.css" rel="stylesheet" type="text/css">
    
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
<!-- body style="padding: 20px" -->
<body> 
<%@ include file="/views/layout/menu.jsp"%>
	<!-- Header ========================================================================================== -->
	<div class="containers">
		<div class="col-lg-12">
			<div class="jumbotron">
				<h2>${categoryDetail.categoryName }</h2>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 col-lg-12">
			<ul id="nav">
				<li><a href="noticAll.do">[공지사항]</a></li>
				<li class="active"><a href="questionList.do">[질의서 관리]</a></li>
				<li><a href="findAllQnA.do">[QnA 게시판]</a></li>
				<li><a href="#">[회원 관리]</a></li>
			</ul>
		</div>
	</div>
	<!-- Header ========================================================================================== -->
	
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Admin 가이드</h4>
            </div>
            <div class="modal-body">
                <h4>1.질문번호는 다음과 같은 규칙으로 부여됩니다.</h4><br>
                1 :  상위 질문에 대한 답변이 <b>YES</b>일 경우<br>
                2 :  상위 질문에 대한 답변이 <b>NO</b>일 경우
                    <h5>(예시)</h5>
                    1.1 : 1번 질문에 YES를 답했을 경우 생성되는 하위 질문 번호<br>
                    1.2 : 1번 질문에 NO를 답했을 경우 생성되는 하위 질문 번호<br>
                    2.1.2.1 : 2번 질문부터 Y -> N -> Y 를 답했을 경우 생성되는 하위 질문 번호<br><br><br>


                <h4>2.<b>[주의]</b>특정 질문을 삭제할 경우 하위 질문들도 다 같이 삭제됩니다.</h4>
                <h5>(예시)</h5>
                    질문이 1, 1.1, 1.1.1이 있을 경우 <br>
                    1을 삭제하게 되면 1.1과 1.1.1이 모두 삭제됩니다.<br>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<h2 style="text-align: center">Veteran 질의서 생성(Admin용)</h2>
<div><p>질의서 제목 : </p> <input type="text" id="version_title" name="version_title" class="form-control" style="margin-left:30px; width: 500px"></div><br>
<div>
    <button id="createQuestion" onclick="createQuestion()" style="width: 150px; height:70px; font-family: HY나무B; font-size: 1em; background-color: #8cd0d3; margin-right: 20px">대질문 생성</button>
    <button id="saveQuestions" onclick="saveQuestions()" style="width: 150px; height:70px; font-family: HY나무B; font-size: 1em; background-color: #e0ffcc; margin-right: 20px">저장</button>
    <button id="EAPage" onclick="showIndex()" style="width: 150px; height:70px; font-family: HY나무B;font-size: 1em; background-color: #d3bec8;margin-right: 20px">EA 페이지로 이동</button>
    <button id="help" class="btn btn-primary" data-toggle="modal" data-target="#myModal"  style="width: 150px; height:70px; font-family: HY나무B;font-size: 1em;">Admin 가이드</button>
    <br /> <br />
    <div id="admin" style="width : 1500px; height : 700px; font-family: HY나무B"></div>
</div>

</body>
</html>