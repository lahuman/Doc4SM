<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SERVICE</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/service/process.do",makeParam(rows), success );
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
	 
	 function dgOnChange(newValue, oldValue) {
		 var tr = $(this).closest('tr.datagrid-row');
		 var index = parseInt(tr.attr('datagrid-row-index'));
     }
	
	 function getContract(){
		 if (endEditing()){
			var row = $('#dg').datagrid('getSelected');  
            if (row && $('#dg').datagrid('getSelected').ID != undefined){
            	//callAjax2Json("/admin/company/contractList.do", "COMPANY_ID="+row.COMPANY_ID, showContractList);
            		popupWindow = window.open(
//            		popupWindow = window.showModalDialog(
            			"/admin/pop/category.do?SERVICE_ID="+row.ID,'popUpWindow','height=310,width=480,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
            }else{
    			$.messager.alert('INFO',"카테고리 관리할 서비스을 선택 하세요.",'info');
    		}
		}
	 }
	 
	 function showContractList(data, textStatus, jqXHR ){
				//data setting
				if(data){
					var row = $('#dg').datagrid('getSelected');
					$("#ftitle").text(row.SERVICE_NAME);
				}
				$('#dlg').dialog('open').dialog('setTitle','서비스 구분');
			
		}
	 function saveContract(){
		 callAjax2Json("/admin/service/processCategory.do", $("#fm").serializeArray(), success);
	 }
	 
	 
	 var useYnDt = [{"txt":"사용", "val":"Y"},{"txt":"미사용", "val":"N"}];
	 var userList = {};
	 $(function(){
		 callAjax2Json("/admin/user/userList.json", "", function(data){
			 userList = data;
		 
			$("#dg").datagrid({
				title:"서비스 관리"
				, pagination:"true"
				, width:800
				, height:600
				, iconCls: 'icon-edit'
				, singleSelect: true
				, toolbar: '#tb'
				, url: '/admin/service/list.json'
				, onDblClickCell: onClickRow
				, columns:[[
				            {field:'ID',title:"KEY", hidden:true}
				            , {field:'NAME',title:"서비스명", width:300,editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
				            , {field:'USER_ID' ,title:"관리자",width:80,
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
				            , {field:'USER',title:"사용자", width:80,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
				            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
				            , {field:'MODIFY_DT',title:"변경일", width:80,align:'center', formatter:formatDate}
				            , {field:'USE_YN', title:"사용 여부", width: 80, align:'center', editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}} 
				   ]]
			});
		 });
	 });
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> SERVICE <small>서비스 관리</small></h2>
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">서비스 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="getContract()">카테고리 관리</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
				</div>
			</div>
		</div>
	</div>
</body>
</html>