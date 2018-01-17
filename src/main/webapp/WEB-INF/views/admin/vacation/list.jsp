<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VACATION</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/vacation/process.do",makeParam(rows), success );
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
	
	 
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 
	 var userList = {};
	 var vacationKind = {};
	 $(function(){
			$('#VACATION_USER').combobox('reload', '/admin/user/userList.json');
			callAjax2Json("/admin/code/codeList.json?CODE_MASTER=VACA", "", function(vacationData){
				vacationKind = vacationData;
			 callAjax2Json("/admin/user/userList.json", "", function(data){
				 userList = data;
				$("#dg").datagrid({
					title:"휴가 관리"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/admin/vacation/list.json'
					, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
					, onDblClickCell: onClickRow
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'VACATION_USER' ,title:"휴가자",width:70,
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
					            , {field:'AGENT_USER' ,title:"대행자",width:70,
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
					            , {field:'VACATION_KIND' ,title:"휴가 종류",width:80,
							 		 formatter:function(value,row){  
							 			for(var i=0; i<vacationKind.length; i++){
											if (vacationKind[i].CODE== value) return vacationKind[i].NAME;
										}  
				                       return value;   
				                      },  
				                      editor:{  
				                          type:'combobox',  
				                          options:{  
				                              valueField:'CODE',  
				                              textField:'NAME',  
				                              data:vacationKind,  
				                              required:true,
				                              onChange:dgOnChange
				                          }  
				                      }}
					            , {field:'DETAIL',title:"세부내용", width:180,editor:{type:'validatebox',options:{required:true, validType:'maxLength[100]'}}}
					            , {field:'START_DT',title:"시작일시",width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDate[]'}}}
					            , {field:'END_DT',title:"종료일시", width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDate[]'}}}
					            , {field:'VACATION_DT', title:"휴일수", width: 80, align:'center'}
					            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
					            , {field:'STATUS', title:"삭제", width: 50, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}}
					             
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
	 });
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> VACATION <small>휴가 관리</small></h2>
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
					<form id="ff" method="post">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">휴가 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
						                &nbsp;&nbsp;
						                년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
						                &nbsp;&nbsp;휴가자: 
					  <input class="easyui-combobox" id="VACATION_USER" name="VACATION_USER" data-options="valueField:'USER_ID',textField:'NAME'" style="width:100px;" />
					  &nbsp;&nbsp; 
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>