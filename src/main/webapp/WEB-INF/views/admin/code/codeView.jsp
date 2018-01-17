<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CODE</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/code/process.do",makeParam(rows), success );
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
		 for(var i=0; i<rows.length; i++){
			 if(rows[i].CODE_MASTER == undefined || "" == rows[i].CODE_MASTER ){
				 return returnWrong("코드 마스터 명칭을 확인 하세요.");
			 }
		 }
		 return true;
	 }
	 
	 function returnWrong(str){
		 $.messager.alert('INFO',str,'warning');
		 return false;
	 }
	 
	 function dgOnChange(newValue, oldValue) {
		 var tr = $(this).closest('tr.datagrid-row');
		 var index = parseInt(tr.attr('datagrid-row-index'));
     }
	 
	 var codeMasters = {};
	 $(function(){
		callAjax2Json("/admin/code/comboCodeMaster.json", "", function(data){
			codeMasters = data;
			
			$("#dg").datagrid({
				title:"코드 마스터"
				, pagination:"true"
				, width:800
				, height:600
				, iconCls: 'icon-edit'
				, singleSelect: true
				, toolbar: '#tb'
				, url: '/admin/code/list.json'
				, onDblClickCell: onClickRow
				, columns:[[
				            {field:'CODE_MASTER' ,title:"코드",width:150,
						 		 formatter:function(value,row){  
			                          return row.CODE_MASTER;  
			                      },  
			                      editor:{  
			                          type:'combobox',  
			                          options:{  
			                              valueField:'CODE_MASTER',  
			                              textField:'CODE_MASTER',  
			                              data:codeMasters,  
			                              required:true,
			                              onChange:dgOnChange
			                          }  
			                      }}
				            , {field:'CODE',title:"CODE", width:100, align:'center', editor:{type:'validatebox',options:{required:true, validType:'codeCheck[4]'}}}
				            , {field:'NAME',title:"코드명", width:250,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
				            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
				            , {field:'MODIFY_DT',title:"변경일", width:100,align:'center', formatter:formatDate}
				            , {field:'STATUS', title:"상태", width: 80, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}} 
				   ]]
			})
		});
	 });
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Code <small>소분류</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg"></table>
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