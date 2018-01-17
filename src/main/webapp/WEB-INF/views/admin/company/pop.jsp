<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CONSTRACT</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/company/processContract.do",makeParam(rows), success );
		                    }  
		                });  
           			}
	            }
		}
	}

	function makeParam(rows){
		return {"param":JSON.stringify(rows)};
	}
	function success(data, textStatus, jqXHR ){
		if(data.STATUS == "SUCCESS"){
			$('#dlg').dialog('close');
			$('#dg').datagrid('reload');  
		}else{
			$.messager.alert('ERROR',data.MESSAGE,'error');
		}
	}
	 

	 function validateGrid(rows){
		 for(var i=0; i<rows.length; i++){
			 if(rows[i].START_DT.length != 8 || !isNumber(rows[i].START_DT)){
				 return returnWrong(rows[i].CONTRACT_INFO +"\"의 시작일이 잘못 되었습니다\n확인 하세요.");
			 }else  if(rows[i].END_DT.length != 8  || !isNumber(rows[i].END_DT)){
				 return returnWrong("\"["+rows[i].ID+"]"+rows[i].NAME +"\"의 종료일이 잘못 되었습니다\n확인 하세요.");
			 }else if(rows[i].START_DT > rows[i].END_DT){
				 return returnWrong(rows[i].CONTRACT_INFO +"\"의 시작일이 종료일 보다 큽니다.\n확인 하세요.");
			 }
		 }

		 return true;
	 }
	 
	 function returnWrong(str){
		 $.messager.alert('INFO',str,'warning');
		 return false;
	 }
	 
	 
	 $(function(){
			$("#dg").datagrid({
				title:"계약 관리"
					, width:480
					, height:300
					, url:"/admin/company/contractList.json?COMPANY_ID=<%=request.getParameter("COMPANY_ID")%>"
					, iconCls: 'icon-edit'
					, toolbar: '#tb'
					, singleSelect: true
					, onDblClickCell: onClickRow
					, columns:[[
					            {field:'COMPANY_ID',title:"KEY", hidden:true}
					            , {field:'CONTRACT_INFO',title:"계약내용", width:150,editor:{type:'validatebox',options:{required:true, validType:'maxLength[100]'}}}
					            , {field:'START_DT',title:"시작일",width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDate[]'}}}
					            , {field:'END_DT',title:"종료일", width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDate[]'}}}
					            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
					   ]]
				});
	 });
	 
	 function appendVal(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{"COMPANY_ID":'<%=request.getParameter("COMPANY_ID")%>'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
	 function deleteRow(){
		 var row = $('#dg').datagrid('getSelected');
		 if(row){
			 var index = $('#dg').datagrid('getRowIndex', row) ;
			 alert(index);
			 $('#dg').datagrid('deleteRow', index);
		 }
	 }
</script>

</head>
<body>
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg"></table>
				<div id="tb" style="height:auto;">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendVal()">계약 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="deleteRow()">삭제</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
				</div>
			</div>
		</div>
	</div>
</body>
</html>