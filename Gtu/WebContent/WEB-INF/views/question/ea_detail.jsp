<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
	<%@ include file="/WEB-INF/views/layout/common.jsp"%>
    <!-- <link href="${pageContext.request.contextPath}/resources/SBGrid/css/SBGrid_BOWON.css" rel="stylesheet" type="text/css"> -->
	<script type="text/javascript">

	var datagrid;
	var SBGridProperties = {};
	var data=[//대 질문(init 함수 후에)
	];
	var data_R;
	$(document).ready(function(){
	    SBGridProperties.parentid = 'EA';
	    SBGridProperties.id = 'datagrid';
	    SBGridProperties.jsonref = 'data';
	    SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';
	    //SBGridProperties.rowheader = 'seq';
	    SBGridProperties.extendlastcol = 'scroll';
	    SBGridProperties.selectmode = 'byrow';//한 줄씩 선택
	    SBGridProperties.rowheight = '40';// 데이터 측 높이
	    SBGridProperties.columns = [
	        {caption : ['질문번호'], ref : "head", width:'100px', style : 'text-align:left',type : 'output'},
	        {caption : ['질문항목'],  ref : "key1",  width :'300px',  style : 'text-align:center;', type : 'output'},
	        {caption : ['응답'],ref : 'key2',	width : '145px',style : 'text-align:center',type : 'output', renderer:function(objGrid, nRow, nCol, strValue, objRowData) {
	            return '<input type="button" class="form-control"  value="YES" onclick="answerYes()" style="width:70px; height: 30; margin-left: 25%" >';
	        } },
	        {caption : ['응답'],ref : 'key3',	width : '160px',style : 'text-align:center',type : 'output', renderer:function(objGrid, nRow, nCol, strValue, objRowData) {
	            return '<input type="button" class="form-control" value="NO" onclick="answerNo()" style="width:70px; height: 30; margin-left: 25%" >';
	        }},
	        {caption : ['대답여부'],ref : 'key4',width : '0px',style : 'text-align:center',type : 'output' ,hidden : true},
	        {caption : ['필요서류'],ref : 'doc',width : '0px',style : 'text-align:center',type : 'output',hidden : true}
	    ];
	    //그리드 생성하기
	    datagrid = _SBGrid.create(SBGridProperties);
	});

	function init(data_R){
		console.log('data length is ',data.length);
		var length= data.length;
        for(var n=0; n<length; n++){
     	   data.splice(0,1);
        }
	    var dataNumber = data_R.length;
	    for (j=0; j<dataNumber; j++){
	        if(!isBigQuestion(data_R[j].head)){//대질문만 PICK
	            console.log(data_R[j].head);
	            var headNum = data_R[j].head;
	            var doc = data_R[j].doc;
	            var tmp = {head:headNum,key1:data_R[j].key1,key2:'YES',key3:'NO',key4:'0',doc:doc};
	            console.log(tmp);
	            data.push(tmp);//대질문만 data에 포함시킴 초기에 data에는 대질문만 들어있음
	        }
	    }
	    console.log('init finish',data);
	}

	function isBigQuestion(checkNumber){//대질문 판별
	    var reg = new RegExp('.(\.).');
	    if (reg.test(checkNumber)){
	        return true;//대질문이 아닙니다.
	    } else{
	        return false;//대질문 입니다.
	    }
	}

	//input : 특정 질문 번호
	// -> 질문 번호에 매핑되는 질문 찾기
	function searchQuestion(questionNumber){
	    var dataNumber = data_R.length;
	    for(i=0;i<dataNumber; i++){
	        if(data_R[i].head === questionNumber){
	            return data_R[i].key1;
	        }
	    }
	}

	function answerYes() {
	    var nRow = datagrid.getRow(); // 버튼을 눌렀을 때 해당 행의 index
	    var questionNumCol = 0; //질문번호 : 1열
	    var questionCol = 2; //질문항목 : 2열
	    var questionNumber = datagrid.getCellData(nRow,questionNumCol);
	    var questionContent = searchQuestion(questionNumber+'.1');
	    var answerCol = 4;

	    //응답하기
	    datagrid.setCellData(nRow, answerCol,'1');
	    datagrid.setCellStyle('background-color', nRow, 2, nRow, 2, '#85e0ff');
	    datagrid.setCellStyle('font-weight', nRow, 2, nRow, 2, 'bold');
	    datagrid.setCellStyle('border', nRow, 2, nRow, 2, '3px solid blue');
	    datagrid.setCellStyle('background-color', nRow, 3, nRow, 3, '#ffffff');
	    datagrid.setCellStyle('font-weight', nRow, 3, nRow, 3, 'normal');
	    datagrid.setCellStyle('border', nRow, 3, nRow, 3, '1px solid #B2BAD2');

	    if(questionContent === undefined){//하위 질문이 없을 때는 아무것도 안하고 종료
	    }
	    else{//하위 질문이 있을 때
	        var tmp = {head:questionNumber+'.1',key1:questionContent,key2:'YES',key3:'NO',key4:'0'};
	        if(datagrid.getCellData(nRow+1,questionNumCol) === questionNumber+'.1'){
	            //YES 가 이미 있는 경우 아무것도 안함
	        }
	        else if(datagrid.getCellData(nRow+1,questionNumCol) === questionNumber+'.2'){
	            // NO 에서 YES 로 수정하는 경우
	            datagrid.setCellData(nRow+1, questionNumCol,questionNumber+'.1');//질문 번호 수정
	            datagrid.setCellData(nRow+1,questionCol,questionContent);//질문항목 수정'
	            // 연계 질문 다 삭제
	            deleteQuestion(questionNumber+'.2',nRow,'1');//questionNumber+'.2'와 연계된 질문 다 삭제
	            datagrid.setCellStyle('background-color', nRow+1, 2, nRow+1, 2, '#ffffff');
	            datagrid.setCellStyle('font-weight', nRow+1, 2, nRow+1, 2, 'normal');
	            datagrid.setCellStyle('border', nRow+1, 2, nRow+1, 2, '1px solid #B2BAD2');
	            datagrid.setCellStyle('background-color', nRow+1, 3, nRow+1, 3, '#ffffff');
	            datagrid.setCellStyle('font-weight', nRow+1, 3, nRow+1, 3, 'normal');
	            datagrid.setCellStyle('border', nRow+1, 3, nRow+1, 3, '1px solid #B2BAD2');

	        }
	        else{
	            //하위에 .1과 .2가 없는 경우 즉, 대답을 하지 않은 경우
	            datagrid.insertRow(nRow,'below',tmp);//바로 아래에 삽입
	            datagrid.setCellData(nRow+1, questionNumCol,questionNumber+'.1');//질문 번호 수정
	            datagrid.setCellData(nRow+1,questionCol,questionContent);//질문항목 수정
	        }
	    }
	    datagrid.refresh(false);
	}
	function answerNo() {
	    var nRow = datagrid.getRow(); // 버튼을 눌렀을 때 해당 행의 index
	    var questionNumCol = 0; //질문번호 : 1열
	    var questionCol = 1; //질문항목 : 2열
	    var questionNumber = datagrid.getCellData(nRow,questionNumCol);
	    var questionContent = searchQuestion(questionNumber+'.2');
	    var answerCol = 4;
	    //응답하기
	    datagrid.setCellData(nRow, answerCol,'2');
	    datagrid.setCellStyle('background-color', nRow, 2, nRow, 2, '#ffffff');
	    datagrid.setCellStyle('font-weight', nRow, 2, nRow, 2, 'normal');
	    datagrid.setCellStyle('border', nRow, 2, nRow, 2, '1px solid #B2BAD2');
	    datagrid.setCellStyle('background-color', nRow, 3, nRow, 3, '#85e0ff');
	    datagrid.setCellStyle('font-weight', nRow, 3, nRow, 3, 'bold');
	    datagrid.setCellStyle('border', nRow, 3, nRow, 3, '3px solid blue');
	    if(questionContent === undefined){//하위 질문이 없을 때는 아무것도 안하고 종료
	        //단 NO 에서 YES 로 바뀌면 하위 다 지워야 함
	        console.log('0번');
	        if(datagrid.getCellData(nRow+1,questionNumCol)===questionNumber+'.1'){
	            // 연계 질문 다 삭제
	            //questionNumber+'.1'와 연계된 질문 다 삭제
	            deleteQuestion(questionNumber+'.1',nRow,'2');
	        }
	    }
	    else{//하위 질문이 있을 때
	        var tmp = {head:questionNumber+'.2',key1:questionContent,key2:'YES',key3:'NO',key4:'0'};
	        if(datagrid.getCellData(nRow+1,questionNumCol) === questionNumber+'.2'){
	            //NO 가 이미 있는 경우 아무것도 안함
	            console.log('1번');
	        }
	        else if(datagrid.getCellData(nRow+1,questionNumCol) === questionNumber+'.1'){
	            console.log('2번');
	            // YES 에서 NO 로 수정하는 경우
	            // 이게 왜 안먹히지?
	            datagrid.setCellData(nRow+1, questionNumCol,questionNumber+'.2');//질문 번호 수정
	            datagrid.setCellData(nRow+1,questionCol,questionContent);//질문항목 수정
	            // 연계 질문 다 삭제
	            deleteQuestion(questionNumber+'.1',nRow,'1');//questionNumber+'.1'와 연계된 질문 다 삭제
	            datagrid.setCellStyle('background-color', nRow+1, 2, nRow+1, 2, '#ffffff');
	            datagrid.setCellStyle('font-weight', nRow+1, 2, nRow+1, 2, 'normal');
	            datagrid.setCellStyle('border', nRow+1, 2, nRow+1, 2, '1px solid #B2BAD2');
	            datagrid.setCellStyle('background-color', nRow+1, 3, nRow+1, 3, '#ffffff');
	            datagrid.setCellStyle('font-weight', nRow+1, 3, nRow+1, 3, 'normal');
	            datagrid.setCellStyle('border', nRow+1, 3, nRow+1, 3, '1px solid #B2BAD2');
	        }
	        else{
	            console.log('3번');
	            //하위에 .1과 .2가 없는 경우 즉, 대답을 하지 않은 경우
	            datagrid.insertRow(nRow,'below',tmp);//바로 아래에 삽입
	            datagrid.setCellData(nRow+1, questionNumCol,questionNumber+'.2');//질문 번호 수정
	            datagrid.setCellData(nRow+1,questionCol,questionContent);//질문항목 수정
	        }
	    }
	    datagrid.refresh(false);
	}


	function veteranPage(){
	    console.log(data);//대답한 항목들은 다 data에 있음
	    //주석 풀어야 함
	    for(var i=0; i<data.length;i++){
	        for(var j=0; j<data_R.length; j++){
	            if(data_R[j].head === data[i].head){
	                data[i].doc = data_R[j].doc;
	            }
	        }
	    }
	    console.log('FINAL : ',JSON.stringify(data));
	    sessionStorage.data=JSON.stringify(data);
	    location.href="http://localhost:63342/SBGridProject/VeteranPage.html?_ijt=td9gfflgdvfqfjlckeidhk8io1";//페이지 이동
	}



	//YES 에서 NO로 혹은 NO 에서 YES 로 답이 바뀔 때,
	//이전 답에 연계된 질문들 모두 삭제
	//questionNumber -> questionNumber 로 시작하는 질문들을 삭제하기(단, questionNumber 질문은 삭제 x)
	//row -> questionNumber 질문이 위치한 행의 index
	//version : '1' -> YES에서 NO로 답이 바뀔 때 NO에 대한 질문이 등록되어 있는 경우
	//version : '2' -> YES에서 NO로 답이 바뀔 때 NO에 대한 질문이 등록되어 있지 않은 경우
	function deleteQuestion(questionNumber,row,version) {
	    //행 삭제
	    var questionNumCol = 1; //질문번호 : 1열
	    var isDelete = false;
	    var checkNumber;
	    while(true) {//search
	        //계속 checkNumber 의 행이 row 로 고정인가?
	        //지울 때마다 지운 행 밑의 행들 index 는 -1 된다.
	        if(version === '1'){
	            checkNumber = datagrid.getCellData(row+2,questionNumCol);
	        }
	        if(version === '2'){
	            checkNumber = datagrid.getCellData(row+1,questionNumCol);
	        }
	        isDelete = deleteCheck(questionNumber,checkNumber);
	        if(isDelete){
	            console.log(checkNumber+'를 지웁니다');
	            if(version === '1'){
	                console.log('[V1]datagrid.deleteRow('+row+2+');')
	                datagrid.deleteRow(row+2);
	            }
	            if(version === '2'){
	                console.log('[V2]datagrid.deleteRow('+row+1+');')
	                datagrid.deleteRow(row+1);
	            }
	            datagrid.refresh(false);
	        }
	        else{
	            break;
	        }
	    }
	}
	//questionNumber 로 시작하는 질문을 정한다.
	//questionNumber 로 시작하는 checkNumber : true
	function deleteCheck(questionNumber,checkNumber){
	    var reg = new RegExp('^'+questionNumber);
	    if (reg.test(checkNumber)) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	
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
		           var obj = JSON.parse(response);
		           console.log('version title is',obj[0].version_title);
		           console.log('version length is',obj.length);
		           console.log('version length2 is',Object.keys(obj).length);
		           var objArray = new Array();

		           for(var i=0; i<Object.keys(obj).length; i++){
		        	   var tmp = new Object();
		        	   tmp.head = obj[i].q_number;
		        	   tmp.key1 = obj[i].content;
		        	   tmp.key2 = 'YES';
		        	   tmp.key3 = 'NO';
		        	   tmp.key4 = '0';
		        	   tmp.doc = '서류 미등록'
		        	   console.log('tmp is ',tmp);
		        	   objArray.push(tmp);
		           }
		           console.log(objArray);
		           //data_R = JSON.parse(sessionStorage.data);
		   	       data_R = objArray;
		   	       init(data_R);
		   	       datagrid.refresh(false);
		        },
		        error:function (request,error) {
		           alert('\n[실패]\ncode:'+request.status+'\n'+'error:'+error);
		        }
		    });
	}
	

	function saveAll(){//저장은 알아서 되니까
		var EA = $('#ea_name').val();
		var VETERAN = $('#veteran_name').val();
		if(EA === ''){
			alert('EA 이름을 입력해 주세요');
			return;

		}
		else if(VETERAN === ''){
			alert('VETERAN 이름을 입력해 주세요');
			return;
		}
	    
		else{
			//alert('EA 이름은 '+EA+'입니다\nVeteran 이름은 '+VETERAN+'입니다');
			var totalData = {
					'main':JSON.stringify(data),
					'EA':EA,
		    		'VETERAN':VETERAN
			}
			
		    $.ajax({
		        url : 'saveEA.do',
		        type: 'POST',
		        data: JSON.stringify(totalData),
		        contentType: "application/json; charset=UTF-8",
		        async: false,
		        success: function(){
		            location.href="eaList.do";
		        },
		        error:function (request,error) {
		            alert('\n[실패]\ncode:'+request.status+'\n'+'error:'+error);
		        }
		    });
		}
	}
	
	</script>
	
</head>
<body style="padding:50px">
	<%@ include file="/views/layout/menu.jsp"%>
	<br><br>
    <div style="float:left">
	       질의서를 선택하세요 : <select class = "form-control" style = "width:300px" name="version_title" onChange="selectReport(this.options[this.selectedIndex].value)">
		<option>선택</option>
			<c:forEach var="tuple" items="${questionList}"  varStatus="status">
			<option value="${tuple.version_title}">${tuple.version_title}</option>
			</c:forEach>
		</select>
		<br>
		EA 이름을 입력해 주세요 : <input type="text" class = "form-control"style = "width:300px" id='ea_name'> 베테랑 이름을 입력해 주세요 : <input type="text" id='veteran_name' class = "form-control"style = "width:300px">
		<br>
		<button id="save" onclick="saveAll()" class = "form-control" style="width: 150px; height:70px; font-family: HY나무B;font-size: 1em; background-color: #d3bec8;margin-right: 20px">저장하기</button><br>
    </div>
	
    <div id="EA" style="width : 720px; height : 700px; float:left; margin-left: 300px" ></div>
    <div>
        <button id="next" onclick="veteranPage()" class = "form-control">Veteran 페이지로 이동</button>
    </div>
</body>
</html>
