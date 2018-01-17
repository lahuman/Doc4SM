<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT</title>
<script type="text/javascript">

		 
	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
	 }
	 function connectPopup(){
    	var row = $('#dg').datagrid('getSelected');  
        if (row && $('#dg').datagrid('getSelected').REQ_CODE != undefined){
        		popupWindow = window.open(
        			"/admin/event/pop/processEvent.do?REQ_CODE="+row.REQ_CODE,'popUpWindow','height=500,width=660,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
        }else{
			$.messager.alert('INFO',"처리할 이벤트를 선택 하세요.",'info');
		}
	}

	 
	 function commentPopup(){
    	var row = $('#dg').datagrid('getSelected');  
        if (row && $('#dg').datagrid('getSelected').REQ_CODE != undefined){
        		popupWindow = window.open(
        			"/admin/event/pop/commentList.do?REQ_CODE="+row.REQ_CODE,'popUpWindow','height=500,width=660,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
        }else{
			$.messager.alert('INFO',"상세업무를 추가할 이벤트를 선택 하세요.",'info');
		}
	}
	 
		function accept(){
			if (endEditing()){
				 var row = $('#dg').datagrid('getSelected');  
		            if (row){  
		            	var rows = $('#dg').datagrid('getChanges');
	        			if(rows.length != 0 ){
			                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
			                    if (r){  
		            				callAjax2Json("/admin/event/changeStatus.do",makeParam(rows), success );
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
		
	var useYnDt = [{"txt":"O", "val":"Y"},{"txt":"X", "val":"N"}];
	 $(function(){
		$('#PROC_USER').combobox('reload', '/admin/user/userList.json');
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
		/* 날짜 제한 삭제
		var toDate = new Date();
		$('#REQ_DT').datebox('setValue', toDate.yyyymmdd());
		*/
		$("#dg").datagrid({
			title:"이벤트 관리"
			, pagination:"true"
			, width:800
			, height:600
			, iconCls: 'icon-edit'
			, singleSelect: true
			, toolbar: '#tb'
			, onDblClickCell: onClickRow
			, url: '/admin/event/list.json'
			, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
			, columns:[[
			            {field:'REQ_CODE',title:"접수번호", width:80, sortable:true,align:'center'}
			            ,{field:'PROCES_TYPE',title:"구분", width:60, align:'center'}
			            , {field:'CATEGORY_NM',title:"카테고리", width:80, align:'center'}
			            , {field:'REQ_TITLE',title:"제목",width:300}
			            , {field:'USER',title:"요청자", width:60, align:'center'}
			            , {field:'REQ_DT',title:"요청일", width:80,align:'center', formatter:formatDate,sortable:true}
			            , {field:'PROC_USER',title:"처리자", width:60, align:'center'}
			            , {field:'SCHEDULE_DT',title:"처리예정일", width:80,align:'center', formatter:formatDate}
			            , {field:'COMPLETE_DT',title:"처리일", width:80,align:'center', formatter:formatDate}
			            , {field:'SETTLE', title:"결제", width: 80, align:'center', editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}}
			            , {field:'FTP', title:"FTP", width: 80, align:'center', editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}}
			            , {field:'HELPDESK', title:"HELPDESK", width: 80, align:'center', editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}}
			            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
			            , {field:'MILESTONE',title:"마일스톤",width:100}
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
            <h2><i class="fa fa-desktop color"></i> Event <small>업무관리</small></h2>
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
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">처리</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="commentPopup()">일일업무</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
						<!-- 
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">영향 시설 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="connectPopup()">CAB</a>-
						 -->
					    &nbsp;년월 : <input class="easyui-datebox" name="REQ_DT" id="REQ_DT" style="width:70px;">
					    &nbsp;처리자: 
					  <input class="easyui-combobox" id="PROC_USER" name="PROC_USER" data-options="valueField:'USER_ID',textField:'NAME'" style="width:60px;" />
					  &nbsp;	     구분:
			            <select class="easyui-combobox" panelHeight="auto" style="width:60px" id="PROC_TYPE" name="PROC_TYPE">
			                <option value="0">진행중</option>
			                <option value="1">완료</option>
							<option value="">ALL</option>
			                <option value="EV00">접수-처리</option>
			                <option value="EV01">서비스</option>
			                <option value="EV02">변경</option>
			                <option value="EV03">장애</option>
			            </select>
			            	제목: <input type="text" class="easyui-validatebox textbox" name="REQ_TITLE" id="REQ_TITLE"  style="width:90px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
			        </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>