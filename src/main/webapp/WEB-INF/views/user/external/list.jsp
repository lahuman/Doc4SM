<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EXTERNAL</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/user/external/process.do",makeParam(rows), success );
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
	 var companyList = {};
	 var workCodeList= {};
	 var infraList= {};
	 var milestoneList = {};
	 var successData = [{"VAL":"P", "TXT":"대기"}, {"VAL":"Y", "TXT":"성공"},{"VAL":"N", "TXT":"실패"},{"VAL":"C", "TXT":"취소"}];
	 $(function(){
		 callAjax2Json("/user/milestone/comboList.json", "", function(milestoneData){
			 milestoneList= milestoneData;
		 callAjax2Json("/user/code/codeList.json?CODE_MASTER=EWCD", "", function(workData){
			 workCodeList = workData;
			 callAjax2Json("/user/infra/comboInfraList.json", "", function(infraData){
				 infraList = infraData;
				 
				 callAjax2Json("/user/company/companyList.json", "", function(companyData){
					 companyList = companyData;
					
					 callAjax2Json("/user/user/userList.json", "", function(data){
						 userList = data;
						$("#dg").datagrid({
							title:"외부작업 관리"
							, pagination:"true"
							, width:800
							, height:600
							, iconCls: 'icon-edit'
							, singleSelect: true
							, toolbar: '#tb'
							, url: '/user/external/list.json'
							, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
							, onDblClickCell: onClickRow
							, columns:[[
							            {field:'ID',title:"작업번호"}
							            , {field:'WORK_CODE' ,title:"작업구분",width:80,
									 		 formatter:function(value,row){  
									 			for(var i=0; i<workCodeList.length; i++){
													if (workCodeList[i].CODE== value) return workCodeList[i].NAME;
												}  
						                       return value;   
						                      },  
						                      editor:{  
						                          type:'combobox',  
						                          options:{  
						                              valueField:'CODE',  
						                              textField:'NAME',  
						                              data:workCodeList,  
						                              required:true,
						                              onChange:dgOnChange
						                          }  
						                      }}
							            , {field:'WORK_NAME',title:"업무명", width:200,editor:{type:'validatebox',options:{required:true, validType:'maxLength[200]'}}}
							            , {field:'COMPANY_ID' ,title:"외부업체",width:100,
									 		 formatter:function(value,row){  
									 			for(var i=0; i<companyList.length; i++){
													if (companyList[i].ID== value) return companyList[i].COMPANY_NAME;
												}  
						                       return value;   
						                      },  
						                      editor:{  
						                          type:'combobox',  
						                          options:{  
						                              valueField:'ID',  
						                              textField:'COMPANY_NAME',  
						                              data:companyList,  
						                              required:true,
						                              onChange:dgOnChange
						                          }  
						                      }}
							            , {field:'WORKER',title:"작업자", width:80,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
							            , {field:'USER',title:"기상청담당자", width:80,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
							            , {field:'MANAGER_ID' ,title:"업무담당자",width:80,
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
							            , {field:'WORK_ST',title:"작업시작",width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
							            , {field:'WORK_ET',title:"작업종료",width:80,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
							            , {field:'SUCCESS',title:"반영",width:50,aling:'center', 
									 		 formatter:function(value,row){  
									 			for(var i=0; i<successData.length; i++){
													if (successData[i].VAL== value) return successData[i].TXT;
												}  
						                       return value;   
						                      },  
						                      editor:{  
						                          type:'combobox',  
						                          options:{  
						                              valueField:'VAL',  
						                              textField:'TXT',  
						                              data:successData,  
						                              required:true,
						                              onChange:dgOnChange
						                          }  
						                      }}
							            , {field:'INFRA_ID' ,title:"대상시스템",width:150,
									 		 formatter:function(value,row){  
									 			if(value != ""){
										 			var resultTitle = "";
										 			var val = (value+"").split(",");
										 			for(var f=0; f<val.length; f++)
											 			for(var i=0; i<infraList.length; i++){
															if (infraList[i].ID== val[f]) resultTitle += infraList[i].USE_TITLE+",";
														}  
									 				return resultTitle.substring(0, resultTitle.length-1);
									 			}
						                       return value;   
						                      },  
						                      editor:{  
						                          type:'combobox',  
						                          options:{  
						                              valueField:'ID',  
						                              textField:'USE_TITLE',  
						                              data:infraList,  
						                              required:true,
						                              multiple:true,
						                              multiline:true,
						                              onChange:dgOnChange
						                          }  
						                      }}					        	            
							            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
							            , {field:'MILESTONE_ID' ,title:"마일스톤",width:150,
									 		 formatter:function(value,row){  
									 			for(var i=0; i<milestoneList.length; i++){
													if (milestoneList[i].ID== value) return milestoneList[i].TITLE;
												}  
						                       return value;   
						                      },  
						                      editor:{  
						                          type:'combobox',  
						                          options:{  
						                              valueField:'ID',  
						                              textField:'TITLE',  
						                              data:milestoneList,  
						                              onChange:dgOnChange
						                          }  
						                      }}
							            , {field:'STATUS', title:"삭제", width: 80, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}}
							             
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
		 	});
		 });
	 });
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> External <small>외부 작업 관리</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">외부 작업 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
						                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				            	 년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
						                &nbsp;&nbsp;
				            	업무명: <input type="text" class="easyui-validatebox textbox" name="WORK_NAME" id="WORK_NAME"  style="width:150px">
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>