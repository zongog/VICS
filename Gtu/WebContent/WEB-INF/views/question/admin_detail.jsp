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
    <link href="${pageContext.request.contextPath}/resources/SBGrid/css/SBGrid_BOWON.css" rel="stylesheet" type="text/css">
	
	<%@ include file="/WEB-INF/views/layout/common.jsp"%>
	<script type="text/javascript">
	var datagrid;
	var SBGridProperties = {};
	var count = 0;
	var data= ${questionListJson};

	$(document).ready(function(){
	    SBGridProperties.parentid = 'admin';
	    SBGridProperties.id = 'datagrid';
	    SBGridProperties.jsonref = data;
	    SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';//데이터가 없을 때
	    SBGridProperties.rowheight = '35';// 데이터 측 높이
	    SBGridProperties.rowheader = 'seq';//번호 헤더
	    SBGridProperties.extendlastcol = 'scroll';//마지막 열 그리드 크기에 맞게 확장
	    SBGridProperties.selectmode = 'byrow';//한 줄씩 선택
	    SBGridProperties.columns = [
	        {caption : ['질문번호'], ref : "q_number", width:'100px', style : 'text-align:left;',type : 'output'},
	        {caption : ['질문항목'],  ref : "content",  width :'300px',  style : 'text-align:left;', type : 'textarea'},
	        {caption : ['하위 YES 질문 생성'],ref : 'key2',	width : '160px',style : 'text-align:center',type : 'output', renderer:function(objGrid, nRow, nCol, strValue, objRowData) {
	                return '<input type="button" class="form-control" value="YES" onclick="yesQuestion()" style="width:70px; margin-left: 25%" >';
	            }},
	        {caption : ['하위 NO 질문 생성'],ref : 'key3',	width : '160px',style : 'text-align:center',type : 'output',renderer:function(objGrid, nRow, nCol, strValue, objRowData) {
	            return '<input type="button" class="form-control" value="NO" onclick="noQuestion()" style="width:70px; margin-left: 25%">';
	        }},
	        {caption : ['질문삭제'],ref : 'key4',	width : '100px',style : 'text-align:center',type : 'output',renderer:function(objGrid, nRow, nCol, strValue, objRowData) {
	            return '<input type="button" class="form-control" value="X" onclick="deleteQuestion()" style="width:50px; margin-left: 25%">';
	        }},
	        {caption : ['필요서류'],ref : 'doc',width : '200px',style : 'text-align:center',type : 'textarea'},
	    ];
	    //그리드 생성
	    datagrid = _SBGrid.create(SBGridProperties);

	});


	//[저장]
	function saveQuestions() {
		console.log('version_title is ',$('#version_title').val());
		if($('#version_title').val()===undefined){
			alert('제목을 입력해 주세요');
			return;
		}
		
		var totalData = {
				'main':JSON.stringify(data),
				'version_title':$('#version_title').val()
		}
		
	    $.ajax({
	        url : 'createQuestion.do',
	        type: 'POST',
	        data: JSON.stringify(totalData),
	        // dataType: 'json',
	        contentType: "application/json; charset=UTF-8",
	        async: false,
	        success: function(){
	            location.href="questionList.do";
	        },
	        error:function (request,error) {
	            alert('\n[실패]\ncode:'+request.status+'\n'+'error:'+error);
	        }
	    });
	}

	//[EA 페이지 전환]
	function showIndex() {
	    sessionStorage.data=JSON.stringify(data);
	    location.href="http://localhost:63342/SBGridProject/EAPage.html?_ijt=i9ti7m51ha72i0rd3u02nu37n5";//페이지 이동
	}
	//[질문등록]
	function yesQuestion() {
	    var nRow = datagrid.getRow(); // 버튼을 눌렀을 때 해당 행의 index
	    var questionNumCol = 1; //질문번호 : 1열
	    var questionCol = 2; //질문항목 : 2열
	    var num = datagrid.getCellData(nRow,questionNumCol);//질문번호(버튼을 눌렀을 때 특정 셀에 대한 정보를 가져옴)
	    var data=//삽일할 행의 기본 데이터
	        {q_number: '',content : '', key2 : 'YES', key3 : 'NO',key4 : '삭제',doc:'필요서류 기재'};
	    //중복검사
	    if(isRegisteredQuestion(nRow+1,datagrid.getCellData(nRow,questionNumCol)+'.1')){
	        alert('해당 질문이 이미 존재합니다');
	    }
	    else{
	        datagrid.insertRow(datagrid.getRow(),'below',data);//바로 아래에 삽입
	        datagrid.setCellData(nRow+1, questionNumCol,num+'.1');//질문 번호 수정
	        datagrid.setCellData(nRow+1,questionCol,num+'번 질문에 대한 YES');//질문항목 수정
	        datagrid.setCellData(nRow+1,6,num+'.1번 질문에 대한 서류를 입력해 주세요');
	        datagrid.refresh(false);
	    }

	}
	//[질문등록]
	function noQuestion() {
	    var nRow = datagrid.getRow(); // 버튼을 눌렀을 때 해당 행의 index
	    var questionNumCol = 1; //질문번호 : 1열
	    var questionCol = 2; //질문항목 : 2열
	    var num = datagrid.getCellData(nRow,questionNumCol); //질문번호(버튼을 눌렀을 때 특정 셀에 대한 정보를 가져옴)
	    var data= //삽일할 행의 기본 데이터
	        {q_number:'',content : '', key2 : 'YES', key3 : 'NO',key4 : '삭제',doc:'필요서류 기재'};
	    //이미 .2 (noQuestion)이 삽입되어 있다면
	    if(isRegisteredQuestion(nRow+1,datagrid.getCellData(nRow,questionNumCol)+'.2')){
	        alert('해당 질문이 이미 존재합니다');
	    }
	    else{//.2 (noQuestion)이 삽입되어 있지 않다면
	        if(datagrid.getCellData(nRow+1,1) === datagrid.getCellData(nRow,1)+'.1'){//NO
	            // 다음 줄에 .1이 이미 있으면 즉, (Yes)가 이미 눌러져 있을 경우
	            // NO는 YES 이후에 삽입되어야 함
	            // YES의 모든 하위항목이 끝나는 (.1이 끝나는 곳) 바로 뒤에 삽입해야 함  ->점심 후에 ㄱㄱ
	            var insertPosition = searchInsertPosition(nRow+1,num+'.1')-1;
	            console.log('삽일할 위치는 '+insertPosition+'입니다');
	            datagrid.insertRow(insertPosition,'below',data); // 2줄 아래에 삽입
	            datagrid.setCellData(insertPosition+1, questionNumCol,num+'.2');//질문번호 수정
	            datagrid.setCellData(insertPosition+1,questionCol,num+'번 질문에 대한 NO');//질문항목 수정
	            datagrid.setCellData(insertPosition+1,6,num+'.2번 질문에 대한 서류를 입력해 주세요');
	            datagrid.refresh(false);
	        }
	        else{//OK
	            // YES 에 대한 질문이 없다면 그냥 등록
	            console.log('비교',datagrid.getCellData(nRow+1,1),datagrid.getCellData(nRow,1)+'.1');
	            datagrid.insertRow(datagrid.getRow(),'below',data);//바로 아래에 삽입
	            datagrid.setCellData(nRow+1, questionNumCol,num+'.2');//질문 번호 수정
	            datagrid.setCellData(nRow+1,questionCol,num+'번 질문에 대한 NO');//질문항목 수정
	            datagrid.setCellData(nRow+1,6,num+'.2번 질문에 대한 서류를 입력해 주세요');
	            datagrid.refresh(false);
	        }
	    }
	}

	//[질문 등록]
	// checkNumber[(ex)1.1.1] 가 questionNumber[(ex)1.1] 의 하위 번호인지 확인
	function insertCheck(questionNumber,checkNumber){
	    console.log('questionNumber :'+questionNumber+'& checkNumber :'+checkNumber);
	    var reg = new RegExp('^'+questionNumber);
	    if (reg.test(checkNumber)) {
	        return true;
	    } else {
	        return false;
	    }
	}

	//[질문 등록]
	// 그리드 상에서 하위 번호가 아닐 때까지 찾는다. 하위 번호가 아니면 해당 행의 index 반환
	function searchInsertPosition(startRow,questionNumber){
	    for(var i=startRow; i<datagrid.getRows(); i++){
	        if(insertCheck(questionNumber,datagrid.getCellData(i,1))){// 하위 번호이면 nothing

	        }
	        else return i;// 하위 번호가 아니면 return
	    }
	    return datagrid.getRows();
	}

	//[질문 등록]
	// 이미 등록되어 있는 질문인지 확인 2018-01-31-11:46 AM
	function isRegisteredQuestion(startRow,questionNumber){
	    for(var i = startRow;i<datagrid.getRows();i++){
	        if(datagrid.getCellData(i,1)=== questionNumber) return true;
	    }
	    return false;
	}
	//[질문 삭제]
	function deleteQuestion() {
	    //행 삭제
	    //사전 작업
	    var deleteCode = confirm("확인을 누르시면 하위 질문도 모두 삭제 됩니다.\n정말로 삭제 하시겠습니까?");
	    if(deleteCode === true){
	        var deleteNum = 1;
	        var questionNumCol = 1; //질문번호 : 1열
	        var row = datagrid.getRow();
	        var isDelete = false;
	        var questionNumber = datagrid.getCellData(row,questionNumCol);//셀의 데이터 ex)1.1

	        while(true) {//search
	            //계속 checkNumber 의 행이 row 로 고정인가?
	            //지울 때마다 지운 행 밑의 행들 index 는 -1 된다.
	            var checkNumber = datagrid.getCellData(row,questionNumCol);
	            isDelete = deleteCheck(questionNumber,checkNumber);
	            if(isDelete){
	                console.log(questionNumber+'를 클릭하여'+checkNumber+'를 지웁니다');
	                datagrid.deleteRow(row);
	                datagrid.refresh(false);
	            }
	            else{
	                break;
	            }
	        }
	    }
	    else{
	    }
	}

	//[질문 등록]
	function createQuestion(){
	    var data =
	        {q_number:(++count).toString(),content : count+'번 질문을 입력해 주세요', key2 : 'YES', key3 : 'NO',key4 : '삭제',doc:count+'번 질문에 대한 서류를 입력해 주세요'};
	    datagrid.addRow(true,data);
	    var nRow = datagrid.getRows()-1;
	    datagrid.setRowStyleEx(nRow, 'background:#F3F3F3;font-weight:bold','all');
	}
	//[연계 질문 삭제]
	function deleteCheck(questionNumber,checkNumber){
	    var reg = new RegExp('^'+questionNumber);
	    if (reg.test(checkNumber)) {
	        return true;
	    } else {
	        return false;
	    }
	}

	
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
<!-- <body style="padding: 20px">
%@ include file="/WEB-INF/views/layout/header.jsp"%>-->
<!-- %@ include file="/WEB-INF/views/layout/header.jsp"%>-->
		<!-- Main Navigation ================================================================================= -->
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
<div><p>질의서 제목 : </p> <input type="text" id="version_title" name="version_title" class="form-control" style="margin-left:30px; width: 500px" value="${version_title}"></div><br>
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