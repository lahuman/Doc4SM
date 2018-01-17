<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEETING</title>
<script type="text/javascript">
	
	function report(){
		var row = $('#dg').datagrid('getSelected');
        if (row && $('#dg').datagrid('getSelected').ID != undefined){
    		location.href = "/files/meeting.do?ID="+row.ID;
        }else{
			$.messager.alert('INFO',"출력할 회의록을 선택 하세요.",'info');
		}
	} 
	
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }

	 $(function(){
				$("#dg").datagrid({
					title:"MEETING 출력"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
				//	, onDblClickCell: onClickRow
					, url: '/user/meet/list.json'
					, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'TITLE',title:"회의제목", width:250,align:'center'}
					            , {field:'MEET_DT',title:"회의일",width:100,align:'center'}
					            , {field:'STIME',title:"시작시간", width:80,align:'center'}
					            , {field:'ETIME',title:"종료시간", width:80,align:'center'}
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
					            , {field:'MODIFY_DT',title:"수정일", width:100,align:'center', formatter:formatDate}
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
            <h2><i class="fa fa-desktop color"></i> MEETING <small>회의록 출력</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="report()">출력</a>-
						                &nbsp;&nbsp;&nbsp;&nbsp; 
						        년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
					  &nbsp;&nbsp; 
				            	내용: <input type="text" class="easyui-validatebox textbox" name="TITLE" id="TITLE"  style="width:200px">
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>