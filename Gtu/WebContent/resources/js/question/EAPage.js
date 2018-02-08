var datagrid;
var SBGridProperties = {};
var data=[//대 질문(init 함수 후에)
];
var data_R;
$(document).ready(function(){
    data_R = JSON.parse(sessionStorage.data);
    init(data_R);
    console.log('[EAPage]'+JSON.stringify(data));
    SBGridProperties.parentid = 'EA';
    SBGridProperties.id = 'datagrid';
    SBGridProperties.jsonref = 'data';
    SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';
    SBGridProperties.rowheader = 'seq';
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
    var questionNumCol = 1; //질문번호 : 1열
    var questionCol = 2; //질문항목 : 2열
    var questionNumber = datagrid.getCellData(nRow,questionNumCol);
    var questionContent = searchQuestion(questionNumber+'.1');
    var answerCol = 5;

    //응답하기
    datagrid.setCellData(nRow, answerCol,'1');
    datagrid.setCellStyle('background-color', nRow, 3, nRow, 3, '#85e0ff');
    datagrid.setCellStyle('font-weight', nRow, 3, nRow, 3, 'bold');
    datagrid.setCellStyle('border', nRow, 3, nRow, 3, '3px solid blue');
    datagrid.setCellStyle('background-color', nRow, 4, nRow, 4, '#ffffff');
    datagrid.setCellStyle('font-weight', nRow, 4, nRow, 4, 'normal');
    datagrid.setCellStyle('border', nRow, 4, nRow, 4, '1px solid #B2BAD2');

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
            datagrid.setCellStyle('background-color', nRow+1, 3, nRow+1, 3, '#ffffff');
            datagrid.setCellStyle('font-weight', nRow+1, 3, nRow+1, 3, 'normal');
            datagrid.setCellStyle('border', nRow+1, 3, nRow+1, 3, '1px solid #B2BAD2');
            datagrid.setCellStyle('background-color', nRow+1, 4, nRow+1, 4, '#ffffff');
            datagrid.setCellStyle('font-weight', nRow+1, 4, nRow+1, 4, 'normal');
            datagrid.setCellStyle('border', nRow+1, 4, nRow+1, 4, '1px solid #B2BAD2');

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
    var questionNumCol = 1; //질문번호 : 1열
    var questionCol = 2; //질문항목 : 2열
    var questionNumber = datagrid.getCellData(nRow,questionNumCol);
    var questionContent = searchQuestion(questionNumber+'.2');
    var answerCol = 5;
    //응답하기
    datagrid.setCellData(nRow, answerCol,'2');
    datagrid.setCellStyle('background-color', nRow, 3, nRow, 3, '#ffffff');
    datagrid.setCellStyle('font-weight', nRow, 3, nRow, 3, 'normal');
    datagrid.setCellStyle('border', nRow, 3, nRow, 3, '1px solid #B2BAD2');
    datagrid.setCellStyle('background-color', nRow, 4, nRow, 4, '#85e0ff');
    datagrid.setCellStyle('font-weight', nRow, 4, nRow, 4, 'bold');
    datagrid.setCellStyle('border', nRow, 4, nRow, 4, '3px solid blue');
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
            datagrid.setCellStyle('background-color', nRow+1, 3, nRow+1, 3, '#ffffff');
            datagrid.setCellStyle('font-weight', nRow+1, 3, nRow+1, 3, 'normal');
            datagrid.setCellStyle('border', nRow+1, 3, nRow+1, 3, '1px solid #B2BAD2');
            datagrid.setCellStyle('background-color', nRow+1, 4, nRow+1, 4, '#ffffff');
            datagrid.setCellStyle('font-weight', nRow+1, 4, nRow+1, 4, 'normal');
            datagrid.setCellStyle('border', nRow+1, 4, nRow+1, 4, '1px solid #B2BAD2');
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

function saveAll(){//저장은 알아서 되니까
    alert('저장이 완료되었습니다');
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