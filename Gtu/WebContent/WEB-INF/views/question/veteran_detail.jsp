<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%@ include file="/WEB-INF/views/layout/common.jsp"%>
<title>veteran detail page</title>
<script type="text/javascript">
	var datagrid;
	var datagrid2;
	var SBGridProperties = {};
	var SBGridProperties2 = {};
	var data=${veteranAnswerJson}
	var data2=[//�� ����(init �Լ� �Ŀ�)
	];
	$(document).ready(function(){
	    // Gird 1
	    // ������ �׸���
	    // data = JSON.parse(sessionStorage.data);
	    // console.log('[VeteranPage]'+JSON.stringify(data));
	    SBGridProperties.parentid = 'Veteran';
	    SBGridProperties.id = 'datagrid';
	    SBGridProperties.jsonref = 'data';
	    SBGridProperties.emptyrecords = '�����Ͱ� �������� �ʽ��ϴ�.';
	    SBGridProperties.rowheader = 'seq';
	    SBGridProperties.extendlastcol = 'scroll';
	    SBGridProperties.selectmode = 'byrow';
	    SBGridProperties.rowheight = '35';// ������ �� ����
	    SBGridProperties.columns = [
	        {caption : ['������ȣ'], ref : "q_number", width:'100px', style : 'text-align:left',type : 'output'},
	        {caption : ['�����׸�'],  ref : "content",  width :'300px',  style : 'text-align:center;', type : 'output'},
	        {caption : ['����'],ref : 'y',	width : '145px',style : 'text-align:center',	type : 'output'},
	        {caption : ['����'],ref : 'n',	width : '145px',style : 'text-align:center',	type : 'output'},
	        {caption : ['��俩��'],ref : 'binary_answer',width : '0px',style : 'text-align:center',type : 'output'},
	        {caption : ['�ʿ伭��'],ref : 'doc',width : '200px',style : 'text-align:center',type : 'output'}
	    ];
	
	    //Grid2
	    //���ռ��� �׸���
	    for(var i=0; i<data.length;i++){
	        if(data[i].doc ==='') continue;
	        data2.push({document : data[i].doc});
	    }
	    console.log(data2);
	    SBGridProperties2.parentid = 'documentGrid';
	    SBGridProperties2.id = 'datagrid2';
	    SBGridProperties2.jsonref = 'data2';
	    SBGridProperties2.emptyrecords = '�����Ͱ� �������� �ʽ��ϴ�.';
	    SBGridProperties2.rowheader = 'seq';
	    SBGridProperties2.extendlastcol = 'scroll';
	    SBGridProperties2.selectmode = 'byrow';
	    SBGridProperties2.columns = [
	        {caption : ['���ռ���'],ref : 'document',style : 'text-align:center',type : 'output'}
	    ];
	
	    //�׸��� �����ϱ�
	    datagrid = _SBGrid.create(SBGridProperties);
	    datagrid2 = _SBGrid.create(SBGridProperties2);
	
	    var answerCol = 5;
	    //for�� �־ �� �����Ű�� ����! -> OK
	    for(var nRow=1;nRow<datagrid.getRows();nRow++){
	    	datagrid.setCellData(nRow,3,"YES");
	    	datagrid.setCellData(nRow,4,"NO");
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
</script>
</head>
<body style="padding: 20px">
<%@ include file="/views/layout/menu.jsp"%>
    <div>
        <h2 style="text-align: center">Veteran ���Ǽ� Ȯ��(Veteran��)</h2>
    </div>
    <div>
        <div id="Veteran" style="width : 1020px; height : 700px; float : left; margin-right: 30px" ></div>
        <div id="documentGrid" style="width:400px; height:700px; float:left;"></div>
        <!--<textarea id="document" style="float:left;width : 400px; height : 700px;"></textarea>-->
    </div>


</body>
</html>