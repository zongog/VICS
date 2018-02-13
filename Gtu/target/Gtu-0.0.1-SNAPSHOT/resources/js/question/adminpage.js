/*
* 작성자 : 고보원
* 개발 시작일 : 2018-01-26
* 추가해야할 사항: 질문 번호 버튼 클릭시 항목의 하위 항목이 동시에 지정되도록 하기
* 스크롤할 때마다 이상해짐
* */

var datagrid;
var SBGridProperties = {};
var count = 0;
var data=[//대 질문
    //{version_title: '',q_number:'1' ,content : '1번 질문을 입력해 주세요', key2 : 'YES', key3 : 'NO',key4 : '삭제',doc:'1번 질문에 대한 서류를 입력해 주세요'}
];

$(document).ready(function(){
    SBGridProperties.parentid = 'admin';
    SBGridProperties.id = 'datagrid';
    SBGridProperties.jsonref = 'data';
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
