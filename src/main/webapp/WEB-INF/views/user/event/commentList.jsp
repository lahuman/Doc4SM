<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT-COMMENT</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/user/event/commentChange.do",makeParam(rows), success );
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

	 var userList = {};
	 $(function(){
		 callAjax2Json("/user/user/userList.json", "", function(data){
			 userList = data;
				$("#dg").datagrid({
					title:"업무 상세 관리"
						, width:780
						, height:500
						, url:"/user/event/commentList.json?REQ_CODE=<%=request.getParameter("REQ_CODE")%>"
						, iconCls: 'icon-edit'
						, toolbar: '#tb'
						, singleSelect: true
						, onDblClickCell: onClickRow
						, columns:[[
						            {field:'COMMENT_ID',title:"KEY", hidden:true}
						            , {field:'REQ_CODE',title:"접수번호", width:80}
						            , {field:'COMMENT',title:"업무상세", width:200,editor:{type:'validatebox',options:{required:true, validType:'maxLength[400]'}}}
						            , {field:'USER' ,title:"처리자",width:80,
								 		 formatter:function(value,row){  
								 			for(var i=0; i<userList.length; i++){
												if (userList[i].USER_ID== value) return userList[i].NAME;
											}  
					                       return value;   
					                      },  
					                      editor:{  
					                          type:'combobox',  
					                          options:{  
					                              valueField:'USER_ID',  
					                              textField:'NAME',  
					                              data:userList,  
					                              required:true,
					                              onChange:dgOnChange
					                          }  
					                      }}
						            , {field:'REQ_DT',title:"처리일",width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDate[]'}}}
						            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
						            , {field:'MODIFY_DT',title:"변경일", width:80,align:'center', formatter:formatDate}
						            , {field:'STATUS', title:"삭제", width: 50, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}}
						   ]]
					});
			 });
		 });
	 
	 function appendVal(){
			if (endEditing()){
				$('#dg').datagrid('appendRow',{"REQ_CODE":'<%=request.getParameter("REQ_CODE")%>', 'USER':'<%=request.getAttribute("user_id")%>'});
				editIndex = $('#dg').datagrid('getRows').length-1;
				$('#dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendVal()">업무상세 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
				</div>
			</div>
		</div>
	</div>
</body>
</html>