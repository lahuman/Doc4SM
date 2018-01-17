<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CATEGORY</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/service/processCategory.do",makeParam(rows), success );
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
		 return true;
	 }
	 
	 function returnWrong(str){
		 $.messager.alert('INFO',str,'warning');
		 return false;
	 }
	 
	 
	 var useYnDt = [{"txt":"사용", "val":"Y"},{"txt":"미사용", "val":"N"}];
	 $(function(){
			$("#dg").datagrid({
				title:"카테고리 관리"
					, width:480
					, height:300
					, url:"/admin/service/categoryList.json?SERVICE_ID=<%=request.getParameter("SERVICE_ID")%>"
					, iconCls: 'icon-edit'
					, toolbar: '#tb'
					, singleSelect: true
					, onDblClickCell: onClickRow
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'NAME',title:"카테고리 명", width:150,editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
					            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
					            , {field:'MODIFY_DT',title:"수정일", width:80,align:'center', formatter:formatDate}
					            , {field:'USE_YN', title:"사용 여부", width: 80, align:'center', editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}}
					   ]]
				});
	 });
	 
	 function appendVal(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{"SERVICE_ID":'<%=request.getParameter("SERVICE_ID")%>'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
	 function deleteRow(){
		 var row = $('#dg').datagrid('getSelected');
		 if(row){
			 var index = $('#dg').datagrid('getRowIndex', row) ;
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendVal()">카테고리 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
				</div>
			</div>
		</div>
	</div>
</body>
</html>