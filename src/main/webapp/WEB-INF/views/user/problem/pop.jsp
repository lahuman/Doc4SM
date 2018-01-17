<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PROBLEM-EVENT</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/user/problem/reationProcess.do",makeParam(rows), success );
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
	 function dgOnChange(newValue, oldValue) {
		 var tr = $(this).closest('tr.datagrid-row');
		 var index = parseInt(tr.attr('datagrid-row-index'));
     }	
	 var eventList = {};
	 var conditionList = {};
	 
	 $(function(){
		 callAjax2Json("/user/code/codeList.json?CODE_MASTER=PBLM", "", function(conditionData){
			 conditionList = conditionData;
			 callAjax2Json("/user/problem/eventList.json?YEAR="+(new Date).getFullYear() , "", function(eventData){
				 eventList = eventData;
				$("#dg").datagrid({
					title:"문제 연관 이벤트 관리"
						, width:780
						, height:500
						, url:"/user/problem/reationList.json?PROBLEM_ID=<%=request.getParameter("PROBLEM_ID")%>"
						, iconCls: 'icon-edit'
						, toolbar: '#tb'
						, singleSelect: true
						, onDblClickCell: onClickRow
						, columns:[[
						            {field:'PROBLEM_ID',title:"KEY", hidden:true}
						            , {field:'ID',title:"ID", width:50}
						            , {field:'EVENT_REQ_CODE' ,title:"이벤트 정보",width:150,
								 		 formatter:function(value,row){  
								 			for(var i=0; i<eventList.length; i++){
												if (eventList[i].REQ_CODE== value) return eventList[i].REQ_TITLE;
											}  
					                       return value;   
					                      },  
					                      editor:{  
					                          type:'combobox',  
					                          options:{  
					                              valueField:'REQ_CODE',  
					                              textField:'REQ_TITLE',  
					                              data:eventList,  
					                              required:true,
					                              onChange:dgOnChange
					                          }  
					                      }}
						            , {field:'CONDITION' ,title:"문제상태",width:100,
								 		 formatter:function(value,row){  
								 			for(var i=0; i<conditionList.length; i++){
												if (conditionList[i].CODE== value) return conditionList[i].NAME;
											}  
					                       return value;   
					                      },  
					                      editor:{  
					                          type:'combobox',  
					                          options:{  
					                              valueField:'CODE',  
					                              textField:'NAME',  
					                              data:conditionList,  
					                              required:true,
					                              onChange:dgOnChange
					                          }  
					                      }}
						            , {field:'ETC',title:"특이사항", width:100,editor:{type:'validatebox',options:{validType:'maxLength[100]'}}}
						            , {field:'CONTENTS',title:"내용", width:200,editor:{type:'validatebox',options:{validType:'maxLength[500]'}}}
						            , {field:'PROC_DT',title:"처리일",width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
						            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
						            , {field:'MODIFY_DT',title:"변경일", width:80,align:'center', formatter:formatDate}
						            , {field:'DEL_YN', title:"삭제", width: 50, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}}
						   ]]
					});
			 });
		 });
	 });
	 
	 function appendVal(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{"PROBLEM_ID":'<%=request.getParameter("PROBLEM_ID")%>'});
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendVal()">이벤트 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>