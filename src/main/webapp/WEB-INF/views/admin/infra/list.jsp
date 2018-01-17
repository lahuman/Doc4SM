<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>INFRA</title>
<script type="text/javascript">

function accept(){
	if (endEditing()){
		 var row = $('#dg').datagrid('getSelected');  
            if (row){  
            	var rows = $('#dg').datagrid('getChanges');
    			if(rows.length != 0){
	                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
	                    if (r){  
            				callAjax2Json("/admin/infra/updateManager.do",makeParam(rows), success );
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

	function infraPopup(){
			var urlStr = "/admin/infra/pop/addInfra.do"
            var row = $('#dg').datagrid('getSelected');  
            if (row && $('#dg').datagrid('getSelected').ID != undefined){
            	urlStr+="?ID="+row.ID;
            }
            popupWindow = window.open(
        			urlStr,'popUpWindow','height=660,width=880,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
	}

	function connectPopup(){
    	var row = $('#dg').datagrid('getSelected');  
        if (row && $('#dg').datagrid('getSelected').ID != undefined){
        		popupWindow = window.open(
        			"/admin/infra/pop/connectInfra.do?ID="+row.ID,'popUpWindow','height=600,width=800,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
        }else{
			$.messager.alert('INFO',"관리할 정보을 선택 하세요.",'info');
		}
	}
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 
	 function dgOnChange(newValue, oldValue) {
		 var tr = $(this).closest('tr.datagrid-row');
		 var index = parseInt(tr.attr('datagrid-row-index'));
     }
	
	 var userList = {};
	 $(function(){
		 
		 		$('#DIVISION').combobox('reload', '/admin/code/codeList.json?CODE_MASTER=HWSW');
		 		callAjax2Json("/admin/user/userList.json", "", function(data){
					 userList = data;
				$("#dg").datagrid({
					title:"Infra 관리"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/admin/infra/list.json'
					, onDblClickCell: onClickRow
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'DIVISION' ,title:"구분",width:80,sortable:true, align:'center'}
					            , {field:'USE_TITLE' ,title:"용도",width:200,sortable:true, align:'center', editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
					            , {field:'OWN_GROUP',title:"소유기관", width:70, align:'center', editor:{type:'validatebox',options:{required:true, validType:'maxLength[25]'}}}
					            , {field:'OFFER_USER',title:"책임자", width:70, align:'center', editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
					            , {field:'MARK_NAME' ,title:"담당자",width:80,
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
					            , {field:'MODEL_NAME',title:"모델명",width:80,align:'center', editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
					            , {field:'SERVICE_STATUS',title:"상태",width:70,align:'center'}
					            , {field:'EMERGENCY_TYPE',title:"중요도",width:70,align:'center',sortable:true}
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center',formatter:formatDate}
					            , {field:'MODIFY_DT',title:"수정일", width:100,align:'center',formatter:formatDate}
					             
					   ]]
				});
				$("#ff").attr("onsubmit", "return false;");
				$("input[type=text]").keyup(function(event){
				    if(event.keyCode == 13){
				    	loadGrid();
				    }
				    return false;
				});
		 	});
	 });
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Infra <small>시설 관리</small></h2>
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
				 	<div style="margin-bottom:5px">
			            <form id="ff" method="post">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="infraPopup()">Infra 추가/수정</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">관련 구성 요소</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
			                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 구분:
			            <select class="easyui-combobox" panelHeight="auto" style="width:100px" id="DIVISION" name="DIVISION" data-options="valueField:'CODE',textField:'NAME'" >
						
			            </select>
			            	용도: <input type="text" class="easyui-validatebox textbox" name="USE_TITLE" id="USE_TITLE"  style="width:150px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
			            </form> 
			        </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>