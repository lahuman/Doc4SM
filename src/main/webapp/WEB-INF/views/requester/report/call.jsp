<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>REPORT</title>
<script type="text/javascript">
	
	 function report(){
		 location.href="/files/callReport.do?param="+getForm2Json($('#ff').serializeArray());
	 } 
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 
	 var useYnDt = [{"txt":"사용", "val":"Y"},{"txt":"미사용", "val":"N"}];
	 var userList = {};
	 var categoryList = {};
	 $(function(){
		 callAjax2Json("/requester/service/serviceCategoryList.json", "", function(categoryData){
			categoryList = categoryData;
			$('#PROC_USER').combobox('reload', '/requester/user/userList.json');
			 callAjax2Json("/requester/user/userList.json", "", function(data){
				 userList = data;
				$("#dg").datagrid({
					title:"CALL Report"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/requester/call/list.json'
					, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
					//, onDblClickCell: onClickRow
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
				                              required:true
				                          }  
				                      }}
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
				                              required:true
				                          }  
				                      }}
					            , {field:'USER',title:"사용자", width:80,editor:{type:'validatebox',options:{required:true, validType:'maxLength[20]'}}}
					            , {field:'CONTENTS',title:"내용", width:250,editor:{type:'validatebox',options:{required:true, validType:'maxLength[500]'}}}
					            , {field:'START_DT',title:"시작일시",width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
					            , {field:'END_DT',title:"종료일시", width:100,align:'center',editor:{type:'datebox', options:{required:true, validType:'defaultDateTime[]'}}}
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
					             
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
            <h2><i class="fa fa-desktop color"></i> Call <small>단순 업무 출력</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="report()">대장 저장</a>-
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