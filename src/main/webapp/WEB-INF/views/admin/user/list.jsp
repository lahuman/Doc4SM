<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>USER</title>
<script type="text/javascript">
	function accept(){
		if (endEditing()){
			 var row = $('#dg').datagrid('getSelected');  
	            if (row){  
	            	var rows = $('#dg').datagrid('getChanges');
        			if(rows.length != 0 && validateGrid(rows)){
		                $.messager.confirm('Confirm','변경하신 내용을 저장 하시겠습니까?',function(r){  
		                    if (r){  
	            				callAjax2Json("/admin/user/process.do",makeParam(rows), success );
		                    }  
		                });  
           			}
	            }
		}
	}

	function makeParam(rows){
		 
		//return "param="+JSON.stringify(rows);
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
	
	 function getRole(){
		 if (endEditing()){
			var row = $('#dg').datagrid('getSelected');  
            if (row && $('#dg').datagrid('getSelected').USER_ID != undefined){
            	callAjax2Json("/admin/user/rolelist.json", "USER_ID="+row.USER_ID, showRoleList);
            }else{
    			$.messager.alert('INFO',"권한 관리할 계정을 선택 하세요.",'info');
    		}
		}
	 }
	 
	 function showRoleList(data, textStatus, jqXHR ){
				//data setting
				if(data){
					var row = $('#dg').datagrid('getSelected');
					$("#ftitle").text(row.NAME);
					var userListHtml = "<input type='hidden' name='USER_ID' value='"+row.USER_ID+"'/><div class='row-fluid'>";
					
					for(var i = 0; i<data.length; i++){
						if(i!= 0 && i%4 == 0){
							userListHtml += "</div><div class='row-fluid'>";
						}
						var isCheck = (data[i].USER_ID)?"checked='checked'":"";
						userListHtml += "<div class='span3'><label><input type='checkbox' name='ROLE_ID' value='"+data[i].ROLE_ID+"' "+isCheck+"/>"+data[i].DESCRIPTION+"</label></div>";
					}
					userListHtml += "</div>";
					$("#fm").html(userListHtml);
				}
				$('#dlg').dialog('open').dialog('setTitle','권한 목록');
			
		}
	 function saveRole(){
		 callAjax2Json("/admin/user/processRole.do", $("#fm").serializeArray(), success);
	 }


	 
	 var enableds  = [{"ENABLED":"0", "VALUE":"사용안함"},{"ENABLED":"1", "VALUE":"사용"}];
	 var ranks = {};
	 var companyList = {};
	 $(function(){
		callAjax2Json("/admin/code/allList.json", "CODE_MASTER=RANK", function(data){
			ranks = data.rows;
			callAjax2Json("/admin/company/companyList.json", "", function(companyData){
				 companyList = companyData;	
			$("#dg").datagrid({
				title:"사용자 관리"
				, pagination:"true"
				, width:800
				, height:600
				, iconCls: 'icon-edit'
				, singleSelect: true
				, toolbar: '#tb'
				, url: '/admin/user/list.json'
				, onDblClickCell: onClickRow
				, columns:[[
				            {field:'USER_ID',title:"KEY", hidden:true}
				            , {field:'LOGIN_ID',title:"아이디", width:100,editor:{type:'validatebox',options:{required:true, validType:'maxLength[50]'}}}
				            , {field:'PASSWORD',title:"비밀번호", width:100,editor:{type:'validatebox',options:{required:true, validType:'password'}}}
				            , {field:'NAME',title:"이름", width:100,editor:{type:'validatebox',options:{required:true, validType:'maxLength[15]'}}}
				            , {field:'USE_YN',title:"사용여부", width:100
								,formatter:function(value){
									for(var i=0; i<enableds.length; i++){
										if (enableds[i].ENABLED == value) return enableds[i].VALUE;
									}
									return value;  
			                      }
								,editor:{type:'combobox'
								,options:{required:true
										, data:enableds
										, valueField:'ENABLED'
										, textField:'VALUE'	
								}}}
				            , {field:'COMPANY_ID' ,title:"업체명",width:100,
						 		 formatter:function(value,row){  
						 			for(var i=0; i<companyList.length; i++){
										if (companyList[i].ID== value) return companyList[i].COMPANY_NAME;
									}  
			                       return value;   
			                      },  
			                      editor:{  
			                          type:'combobox',  
			                          options:{  
			                              valueField:'ID',  
			                              textField:'COMPANY_NAME',  
			                              data:companyList,  
			                              required:true,
			                              onChange:dgOnChange
			                          }  
			                      }}
				            , {field:'CHARGE_WORK',title:"담당업무", width:100,editor:{type:'validatebox',options:{required:true, validType:'maxLength[10]'}}}
				            , {field:'TEL',title:"전화번호", width:100,editor:{type:'validatebox',options:{required:true, validType:'onlyNumber[12]'}}}
				            , {field:'EMAIL',title:"이메일",width:100,editor:{type:'validatebox',options:{required:true, validType:'maxLength[100]'}}}
				            , {field:'POSITION',title:"직급",width:100
								,formatter:function(value){
									for(var i=0; i<ranks.length;i++){
										if (ranks[i].CODE== value) return ranks[i].NAME;
									}  
			                       return value;  
			                      }
								,editor:{type:'combobox'
								,options:{required:true
										, data:ranks
										, valueField:'CODE',
											textField:'NAME',
								}}}
				            , {field:'REGISTER_DT',title:"등록일", width:100,align:'center', formatter:formatDate}
				            , {field:'MODIFY_DT',title:"변경일", width:100,align:'center', formatter:formatDate}
				            , {field:'STATUS', title:"상태", width: 80, align:'center', editor:{type:'checkbox',options:{on:'D',off:''}}} 
				   ]]
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
            <h2><i class="fa fa-desktop color"></i> User <small>사용자 관리</small></h2>
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
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">사용자 추가</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="getRole()">권한 관리</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">저장</a>-
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">취소</a>-
				</div>
				
				  <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"  
			            closed="true" buttons="#dlg-buttons" modal="true"  iconCls='icon-save' title="권한설정">  
			        <form id="fm" method="post" novalidate>
			        </form>  
			    </div>  
			    
			    <div id="dlg-buttons">  
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRole()">저장</a>  
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">취소</a>  
			    </div>  
			</div>
		</div>
	</div>
</body>
</html>