<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VERSION</title>
<style type="text/css">
	.datagrid-header .datagrid-cell{
		line-height:normal;
		height:auto;
	}
</style>
<script type="text/javascript">

	function showDetail(){
		var row = $('#dg').datagrid('getSelected');  
	    if (row && $('#dg').datagrid('getSelected').REVISON != undefined){
	    		popupWindow = window.open(
	    			"/user/version/pop/showDetail.do?REVISON="+row.REVISON,'popUpWindow','height=450,width=600,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
	    }else{
			$.messager.alert('INFO',"확인할 정보를 선택 하세요.",'info');
		}
	}
	 
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 
	 $(function(){
				$("#dg").datagrid({
					title:"Version Manage"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, url: '/user/version/list.json'
					//, onDblClickCell: onClickRow
					, columns:[[
					            {field:'REVISON',title:"VERSION", width:80}
					            , {field:'AUTHOR',title:"작업자", width:100}
					            , {field:'COMMENT',title:"내용", width:470}
					            , {field:'DATE',title:"등록일",width:120, formatter:formatDateTime}
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
            <h2><i class="fa fa-desktop color"></i> SVN <small>형상 관리</small></h2>
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="showDetail()">상세보기</a>-
					  &nbsp;&nbsp;  
				            	위치지정: <input type="text" class="easyui-validatebox textbox" name="PATH" id="PATH"  style="width:200px">
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>