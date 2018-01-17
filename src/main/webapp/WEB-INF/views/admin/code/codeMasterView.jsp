<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CODE MASTER</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/codeMaster/process.do",makeParam(rows), success );
		                    }  
		                });  
           			}
	            }
		}
	}

	function makeParam(rows){
		 
		//return "param="+JSON.stringify(rows);
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
		 return true;
	 }
	 
	 function returnWrong(str){
		 $.messager.alert('INFO',str,'warning');
		 return false;
	 }
	 
	var codeMaster = undefined;
	function endEdit(rowIndex, rowData, changes){
		if(codeMaster != undefined && changes.CODE_MASTER != undefined){
			alert("코드는 수정할수 없습니다.");
			reject();
		}
	}
	function beginEdit(rowIndex, rowData){
		codeMaster = rowData.CODE_MASTER;
	}
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Code Master <small>대분류</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg" class="easyui-datagrid" title="코드마스터" style="width:800px;height:600px"
					data-options="
						iconCls: 'icon-edit',
						singleSelect: true,
						toolbar: '#tb',
						url: '/admin/codeMaster/list.json',
						onDblClickCell: onClickRow,
						onAfterEdit: endEdit,
						onBeforeEdit: beginEdit
					" pagination="true"
					>
				<thead>
					<tr>
						<th data-options="field:'CODE_MASTER',width:100, align:'center', editor:{type:'validatebox',options:{required:true, validType:'codeCheck[4]'}}">CODE_MASTER</th>
						<th data-options="field:'NAME',width:250,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}">코드명</th>
						<th data-options="field:'REGISTER_DT',width:100,align:'center', formatter:formatDate">등록일</th>
						<th data-options="field:'MODIFY_DT',width:100,align:'center', formatter:formatDate">수정일</th>
						<th data-options="field:'STATUS', width: 80, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}">선택삭제</th>
					</tr>
				</thead>
			</table>
			<div id="tb" style="height:auto;">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">코드 추가</a>-
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
			</div>
			</div>
		</div>
	</div>
</body>
</html>