
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MILESTONE</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/user/milestone/process.do",makeParam(rows), success );
		                    }  
		                });  
           			}
	            }
		}
	}

	 function loadGrid(){
		 	$('#dg').datagrid('load',{"param":getForm2Json($('#ff').serializeArray())});
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
	
	 function milestoneRelation(){
		 if (endEditing()){
			var row = $('#dg').datagrid('getSelected');  
            if (row && $('#dg').datagrid('getSelected').ID != undefined){
            		popupWindow = window.open(
            			"/user/pop/milestoneRelation.do?MILESTONE_ID="+row.ID,'popUpWindow','height=510,width=810,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
            }else{
    			$.messager.alert('INFO',"관리할 마일스톤을 선택 하세요.",'info');
    		}
		}
	 }
	 
	 
	 function saveContract(){
		 callAjax2Json("/user/company/processContract.do", $("#fm").serializeArray(), success);
	 }
	 
	 var useYnDt = [{"txt":"종료", "val":"Y"},{"txt":"진행중", "val":"N"}];
	 $(function(){
			$("#dg").datagrid({
				title:"마일스톤 관리"
				, pagination:"true"
				, width:800
				, height:600
				, iconCls: 'icon-edit'
				, singleSelect: true
				, toolbar: '#tb'
				, url: '/user/milestone/list.json'
				, queryParams:{"param":getForm2Json($('#ff').serializeArray())}
				, onDblClickCell: onClickRow
				, columns:[[
				            {field:'ID',title:"ID", width:30, align:'center'}
				            , {field:'TITLE',title:"마일스톤", width:250,align:'center',editor:{type:'validatebox',options:{required:true, validType:'maxLength[200]'}}}
				            , {field:'LEFT_DAY',title:"남은일", width:50, align:'center'}
				            , {field:'PERCENT',title:"진행현황", width:60, align:'center'}
				            , {field:'MILESTONE_ST',title:"시작일",width:80,align:'center',editor:{type:'datebox', options:{required:true }}}
				            , {field:'MILESTONE_ET',title:"종료일",width:80,align:'center',editor:{type:'datebox', options:{required:true }}}
				            , {field:'STATUS', title:"상태", width: 50, align:'center',
				            	formatter:function(value,row){  
						 			for(var i=0; i<useYnDt.length; i++){
										if (useYnDt[i].val== value) return useYnDt[i].txt;
									}  
			                       return value;   
			                      },  editor:{type:'combobox',options:{editable:false, valueField:'val', textField:"txt", data:useYnDt, required:true}}}
				            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
				            , {field:'MODIFY_DT',title:"변경일", width:100,align:'center', formatter:formatDate}
				            , {field:'DEL_YN', title:"삭제여부", width: 70, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}} 
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
            <h2><i class="fa fa-desktop color"></i> MILSTONE <small>마일스톤 관리</small></h2>
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">마일스톤 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="milestoneRelation()">연관 이벤트 확인</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
					 &nbsp;&nbsp;&nbsp;
					 년도: <input type="text" class="easyui-validatebox textbox" name="YEAR" id="YEAR"  style="width:50px">
					 &nbsp;&nbsp;&nbsp; 
					 	제목: <input type="text" class="easyui-validatebox textbox" name="TITLE" id="TITLE"  style="width:200px">
			            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
			        </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>