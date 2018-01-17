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
	    if (row && $('#dg').datagrid('getSelected').ID != undefined){
			location.href = "/files/infra.do?ID="+row.ID+"&YEAR="+$("#YEAR").val();;
	    }else{
			$.messager.alert('INFO',"출력할 인프라를 선택 하세요.",'info');
		}
	}
	
	function reportList(){
		location.href = "/files/infraList.do?param="+getForm2Json($('#ff').serializeArray());
	}
	
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 $(function(){
		 $('#DIVISION').combobox('reload', '/user/code/codeList.json?CODE_MASTER=HWSW');
				$("#dg").datagrid({
					title:"Infra Report"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/user/infra/list.json'
					, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
					//, onDblClickCell: onClickRow
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'DIVISION' ,title:"구분",width:80,sortable:true, align:'center'}
					            , {field:'USE_TITLE' ,title:"용도",width:200,sortable:true, align:'center'}
					            , {field:'OWN_GROUP',title:"소유기관", width:70, align:'center'}
					            , {field:'OFFER_USER',title:"책임자", width:70, align:'center'}
					            , {field:'MARK_NAME',title:"담당자", width:70, align:'center'}
					            , {field:'MODEL_NAME',title:"모델명",width:80,align:'center'}
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
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Infra <small>시설 관리 출력</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="report()">시설정보저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="reportList()">시설대장저장</a>-
						               &nbsp;&nbsp;&nbsp;
						     년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
						               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 구분:
			            <select class="easyui-combobox" panelHeight="auto" style="width:100px" id="DIVISION" name="DIVISION" data-options="valueField:'CODE',textField:'NAME'" >
						
			            </select>
			            	용도: <input type="text" class="easyui-validatebox textbox" name="USE_TITLE" id="USE_TITLE"  style="width:200px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
			            </form> 
			        </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>