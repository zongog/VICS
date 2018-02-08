var datagrid;
var datagrid2;
var SBGridProperties = {};
var SBGridProperties2 = {};
var data=[//대 질문(init 함수 후에)
];
var data2=[//대 질문(init 함수 후에)
];
$(document).ready(function(){
    //Gird 1
    //설문지 그리드
    data = JSON.parse(sessionStorage.data);
    console.log('[VeteranPage]'+JSON.stringify(data));
    SBGridProperties.parentid = 'Veteran';
    SBGridProperties.id = 'datagrid';
    SBGridProperties.jsonref = 'data';
    SBGridProperties.emptyrecords = '데이터가 존재하지 않습니다.';
    SBGridProperties.rowheader = 'seq';
    SBGridProperties.extendlastcol = 'scroll';
    SBGridProperties.selectmode = 'byrow';
    SBGridProperties.rowheight = '35';// 데이터 측 높이
    SBGridProperties.columns = [
        {caption : ['질문번호'], ref : "head", width:'100px', style : 'text-align:left',type : 'output'},
        {caption : ['질문항목'],  ref : "key1",  width :'300px',  style : 'text-align:center;', type : 'textarea'},
        {caption : ['응답'],ref : 'key2',	width : '145px',style : 'text-align:center',	type : 'output'},
        {caption : ['응답'],ref : 'key3',	width : '160px',style : 'text-align:center',	type : 'output'},
        {caption : ['대답여부'],ref : 'key4',width : '0px',style : 'text-align:center',type : 'output'},
        {caption : ['필요서류'],ref : 'doc',width : '200px',style : 'text-align:center',type : 'output'}
    ];

    //Grid2
    //종합서류 그리드
    for(var i=0; i<data.length;i++){
        if(data[i].doc ==='') continue;
        data2.push({document : data[i].doc});
    }
    console.log(data2);
    SBGridProperties2.parentid = 'documentGrid';
    SBGridProperties2.id = 'datagrid2';
    SBGridProperties2.jsonref = 'data2';
    SBGridProperties2.emptyrecords = '데이터가 존재하지 않습니다.';
    SBGridProperties2.rowheader = 'seq';
    SBGridProperties2.extendlastcol = 'scroll';
    SBGridProperties2.selectmode = 'byrow';
    SBGridProperties2.columns = [
        {caption : ['종합서류'],ref : 'document',style : 'text-align:center',type : 'output'}
    ];

    //그리드 생성하기
    datagrid = _SBGrid.create(SBGridProperties);
    datagrid2 = _SBGrid.create(SBGridProperties2);

    var answerCol = 5;
    //for문 넣어서 다 적용시키기 내일! -> OK
    for(var nRow=1;nRow<datagrid.getRows();nRow++){
        if(datagrid.getCellData(nRow,answerCol) === '1'){
            //datagrid.selectRadio(nRow, 3);
            datagrid.setCellStyle('background-color', nRow, 3, nRow, 3, '#f8a5a5');
            datagrid.setCellStyle('font-weight', nRow, 3, nRow, 3, 'bold');
        }
        else if(datagrid.getCellData(nRow,answerCol) === '2'){
            //datagrid.selectRadio(nRow, 4);
            datagrid.setCellStyle('background-color', nRow, 4, nRow, 4, '#f8a5a5');
            datagrid.setCellStyle('font-weight', nRow, 4, nRow, 4, 'bold');
        }
    }
});


