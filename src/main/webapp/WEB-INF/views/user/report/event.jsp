<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>REPORT</title>
<script type="text/javascript">

	function report(){
		var row = $('#dg').datagrid('getSelected');
        if (row && $('#dg').datagrid('getSelected').REQ_CODE != undefined){
        	if($('#dg').datagrid('getSelected').PROCES_TYPE == "요청" ){
    			$.messager.alert('INFO',"처리 되지 않은 요청은 개발 저장을 할 수 없습니다.",'info');
        	}else{
        		location.href = "/files/event.do?REQ_CODE="+row.REQ_CODE;
        	}
        }else{
			$.messager.alert('INFO',"출력할 이벤트를 선택 하세요.",'info');
		}
	} 	 
	function reportList(){
		location.href="/files/eventListReport.do?param="+getForm2Json($('#ff').serializeArray());
	}
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	
	 $(function(){
		 $('#PROC_USER').combobox('reload', '/user/user/userList.json');
		 $('#REQ_DT').datebox({
			    validType:'monthDate[]'
				, parser:function(s){
					if (!s) return new Date();
					var y = parseInt(s.substring(0,4),10);
					var m = parseInt(s.substring(4,6),10);
					if (!isNaN(y) && !isNaN(m) ){
						return new Date(y,m-1);
					} else {
						return new Date();
					}
				}
				, formatter:function(date){
					var y = date.getFullYear();
					var m = date.getMonth()+1;
					return y+''+(m<10?('0'+m):m);
				}
			});
		var toDate = new Date();
		$('#REQ_DT').datebox('setValue', toDate.yyyymmdd());
						
		$("#dg").datagrid({
			title:"Event Report"
			, pagination:"true"
			, width:800
			, height:600
			, iconCls: 'icon-edit'
			, singleSelect: true
			, toolbar: '#tb'
			, url: '/user/event/list.json'
			, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
			, columns:[[
			             {field:'REQ_CODE',title:"접수번호", width:80, sortable:true}
			            ,{field:'PROCES_TYPE',title:"구분", width:50}
			            , {field:'CATEGORY_NM',title:"카테고리", width:80}
			            , {field:'REQ_TITLE',title:"제목",width:300}
			            , {field:'USER',title:"요청자", width:60}
			            , {field:'REQ_DT',title:"요청일", width:80,align:'center', formatter:formatDate,sortable:true}
			            , {field:'PROC_USER',title:"처리자", width:60}
			            , {field:'COMPLETE_DT',title:"처리일", width:80,align:'center', formatter:formatDate}
			            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
			             
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
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Event <small>업무 출력</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="report()">개별 저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="reportList()">대장 저장</a>-
						<!-- 
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">영향 시설 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">CAB</a>-
						 -->
					   &nbsp;&nbsp;년월 : <input class="easyui-datebox" name="REQ_DT" id="REQ_DT" style="width:90px;">
					    &nbsp;&nbsp;처리자: 
					  <input class="easyui-combobox" id="PROC_USER" name="PROC_USER" data-options="valueField:'USER_ID',textField:'NAME'" style="width:80px;" />
					  &nbsp;&nbsp;	     구분:
			            <select class="easyui-combobox" panelHeight="auto" style="width:60px" id="PROC_TYPE" name="PROC_TYPE">
							<option value="">ALL</option>
							<option value="1">완료</option>
			                <option value="0">요청</option>
			                <option value="EV01">서비스</option>
			                <option value="EV02">변경</option>
			                <option value="EV03">장애</option>
			            </select>
			            	제목: <input type="text" class="easyui-validatebox textbox" name="REQ_TITLE" id="REQ_TITLE"  style="width:100px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
			        </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>