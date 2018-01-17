<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MEETING</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/meet/process.do",makeParam(rows), success );
		                    }  
		                });  
           			}
	            }
		}
	}
	function addMeeting(){
		var row = $('#dg').datagrid('getSelected');  
		var url = "/admin/meet/pop/form.do";
        if (row && $('#dg').datagrid('getSelected').ID != undefined){
        	url +="?ID="+row.ID;
        }
		popupWindow = window.open(
    			url,'popUpWindow','height=500,width=660,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
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

	 $(function(){
				$("#dg").datagrid({
					title:"MEETING 관리"
					, pagination:"true"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, onDblClickCell: onClickRow
					, url: '/admin/meet/list.json'
					, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'TITLE',title:"회의제목", width:250,align:'center'}
					            , {field:'MEET_DT',title:"회의일",width:100,align:'center'}
					            , {field:'STIME',title:"시작시간", width:80,align:'center'}
					            , {field:'ETIME',title:"종료시간", width:80,align:'center'}
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
					            , {field:'MODIFY_DT',title:"수정일", width:100,align:'center', formatter:formatDate}
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
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> MEETING <small>회의록</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="addMeeting()">회의록 추가&수정</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
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