<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VERSION-MANAGE</title>
<script type="text/javascript">

	function showDetail(){
		var row = $('#dg').datagrid('getSelected');  
	    if (row && $('#dg').datagrid('getSelected').SVN_VERSION != undefined){
	    		popupWindow = window.open(
	    			"/admin/version/pop/showDetail.do?REVISON="+row.SVN_VERSION,'popUpWindow','height=450,width=600,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no')
	    }else{
			$.messager.alert('INFO',"확인할 정보를 선택 하세요.",'info');
		}
	}

	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/version/process.do",makeParam(rows), success );
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
	 
	 var kindCd = [{"txt":"내부", "val":"I"},{"txt":"외부", "val":"O"}];
	 $(function(){
			$("#dg").datagrid({
				title:"VERSION 관리"
				, pagination:"true"
				, width:800
				, height:600
				, iconCls: 'icon-edit'
				, singleSelect: true
				, toolbar: '#tb'
				, url: '/admin/version/manage.json'
				, onDblClickCell: onClickRow
				, columns:[[
				            {field:'KIND_CD', title:"작업구분", width: 70, align:'center', formatter:function(value,row){  
					 			for(var i=0; i<kindCd.length; i++){
									if (kindCd[i].val== value) return kindCd[i].txt;
								}  
		                       return value;   
		                      },  
		                      editor:{  
		                          type:'combobox',  
		                          options:{  
		                              valueField:'val',  
		                              textField:'txt',  
		                              data:kindCd,  
		                              required:true,
		                              onChange:dgOnChange
		                          }  
		                      }}
				            , {field:'ID',title:"요청번호", width:100,align:'center',editor:{type:'validatebox',options:{required:true, validType:'maxLength[15]'}}}
				            , {field:'USE_TITLE',title:"대상", width:200,align:'center'}
				            , {field:'SVN_VERSION',title:"SVN 버젼", width:60,editor:{type:'validatebox',options:{required:true, validType:'maxLength[10]'}}}
				            , {field:'VERSION',title:"버젼정보", width:60,editor:{type:'validatebox',options:{required:true, validType:'maxLength[10]'}}}
				            , {field:'AUTHOR',title:"등록자", width:50,editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
				            , {field:'REGISTER_DT',title:"등록일", width:80,align:'center', formatter:formatDate}
				            , {field:'MODIFY_DT',title:"수정일", width:80,align:'center', formatter:formatDate}
				            , {field:'STATUS', title:"삭제", width: 50, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}}
				             
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
            <h2><i class="fa fa-desktop color"></i> VERSION <small>버젼 관리</small></h2>
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
					<form id="ff" method="post" >
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">VERSION 추가</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
						                             &nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="showDetail()">변경 내역 보기</a>-
						                &nbsp;&nbsp;&nbsp;
				            	대상 시스템: <input type="text" class="easyui-validatebox textbox" name="USE_TITLE" id="USE_TITLE"  style="width:200px">
				            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="loadGrid()">검색</a>
				    </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>