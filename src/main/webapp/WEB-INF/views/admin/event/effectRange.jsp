<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT</title>
<script type="text/javascript">
function accept(){
	if (endEditing()){
		 var row = $('#dg').datagrid('getSelected');  
            if (row){  
            	var rows = $('#dg').datagrid('getRows');
    			if(rows.length != 0 ){
	                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
	                    if (r){  
            				callAjax2Json("/admin/infra/connectInfraProcess.do",makeParam(rows), success );
	                    }  
	                });  
       			}
            }
	}
}

function makeParam(rows){
	return {"param":JSON.stringify(rows), "ID":'<%=request.getParameter("ID")%>'};
}
	function success(data, textStatus, jqXHR ){
		if(data.STATUS == "SUCCESS"){
			$('#dlg').dialog('close');
			$('#dg').datagrid('reload');  
		}else{
			$.messager.alert('ERROR',data.MESSAGE,'error');
		}
	}
	 
	 $(function(){
				$("#dg").datagrid({
					title:"영향 범위"
					, width:800
					, height:600
					, iconCls: 'icon-edit'
					, singleSelect: true
					, toolbar: '#tb'
					, onDblClickCell: onClickRow
					, url: '/admin/infra/connectInfraList.json?ID=<%=request.getParameter("ID")%>'
					, columns:[[
					            {field:'ID',title:"KEY", hidden:true}
					            , {field:'JOIN_ID' ,title:"연관",editor:{type:'checkbox',options:{on:'1',off:'0'}}}
					            , {field:'DIVISION' ,title:"구분",width:50}
					            , {field:'USE_TITLE' ,title:"용도",width:200}
					            , {field:'OWN_GROUP',title:"소유기관", width:80}
					            , {field:'OFFER_USER',title:"책임자", width:80}
					            , {field:'MARK_NAME',title:"담당자", width:80}
					            , {field:'MODEL_NAME',title:"모델명",width:100,align:'center'}
					            , {field:'SERVICE_STATUS',title:"상태",width:100,align:'center'}
					            , {field:'EMERGENCY_TYPE',title:"중요도",width:100,align:'center'}
					            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center',formatter:formatDate}
					            , {field:'MODIFY_DT',title:"수정일", width:100,align:'center',formatter:formatDate}
					   ]]
				});
	 });
</script>

</head>
<body>
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg"></table>
				<div id="tb" style="height:auto;">
				 	<div style="margin-bottom:5px">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="accept()">관련 요소 저장</a>-
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
			        </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>