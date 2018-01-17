<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CALL</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/user/call/process.do",makeParam(rows), success );
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
	 
	 var useYnDt = [{"txt":"사용", "val":"Y"},{"txt":"미사용", "val":"N"}];
	 var userList = {};
	 var categoryList = {};
	 var milestoneList = {};
	 $(function(){
		 callAjax2Json("/user/milestone/comboList.json", "", function(milestoneData){
			 milestoneList= milestoneData;
		 callAjax2Json("/user/service/serviceCategoryList.json", "", function(categoryData){
			categoryList = categoryData;
			$('#PROC_USER').combobox('reload', '/user/user/userList.json');
			 callAjax2Json("/user/user/userList.json", "", function(data){
				 userList = data;
				$("#dg").datagrid({
					title:"CALL 관리"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/user/call/list.json'
					, queryParams: {"param":getForm2Json($('#ff').serializeArray())}
					, onDblClickCell: onClickRow
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'CATEGORY_ID' ,title:"서비스명",width:150,
							 		 formatter:function(value,row){  
							 			for(var i=0; i<categoryList.length; i++){
											if (categoryList[i].CATEGORY_ID== value) return categoryList[i].SERVICE_CATEGORY_NM;
										}  
				                       return value;   
				                      },  
				                      editor:{  
				                          type:'combobox',  
				                          options:{  
				                              valueField:'CATEGORY_ID',  
				                              textField:'SERVICE_CATEGORY_NM',  
				                              data:categoryList,  
				                              required:true,
				                              onChange:dgOnChange
				                          }  
				                      }}
					            , {field:'USER_ID' ,title:"처리자",width:80,
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
					            , {field:'USER',title:"요청자", width:80,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
					            , {field:'CONTENTS',title:"내용", width:250,editor:{type:'validatebox',options:{required:true, validType:'maxLength[500]'}}}
					            , {field:'START_DT',title:"시작일시",width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
					            , {field:'END_DT',title:"종료일시", width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
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
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
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
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Call <small>단순 업무 관리</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">CALL 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
						     &nbsp;&nbsp;
						     년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
						     &nbsp;&nbsp;처리자: 
					  <input class="easyui-combobox" id="PROC_USER" name="PROC_USER" data-options="valueField:'USER_ID',textField:'NAME'" style="width:100px;" />
					  &nbsp;&nbsp;  
				            	내용: <input type="text" class="easyui-validatebox textbox" name="CONTENTS" id="CONTENTS"  style="width:200px">
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>