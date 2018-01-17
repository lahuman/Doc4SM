<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT</title>
<script type="text/javascript">
	 
	 
	 $(function(){
		 <%if(!"".equals(Utils.getRequestValue(request.getParameter("TYPE")))){%>
		 	changeForm("<%=request.getParameter("TYPE")%>", <%=Utils.getRequestValue(request.getParameter("param"))%>);
		 <%}else{%>
		 	changeForm('event');
		 <%}%>
	 });
	 
	 function makeForm2Json(){
		return getForm2Json($('#ff').serializeArray());
	}
	 
	 function goProcessForm(type){
			$("#ff").attr("action", "/admin/event/addEventForm.do");
			$("#param").val(makeForm2Json());
			$("#ff").submit();
		}
	 
	 function changeForm(type, data){
		$("#TYPE").val(type);
		$("#formArea").load("/admin/event/pop/"+type+"Form.do",{"param":getForm2Json($('#ff').serializeArray())}, function(){
			setTimeout(function(){
				$('#SERVICE_ID').combobox('reload', '/admin/service/serviceList.json?USE_YN=Y');
				if($("#TYPE").val() == "event"){
					$('#EMERGENCY_CODE').combobox('reload', '/admin/code/codeList.json?CODE_MASTER=EMGC');
				}else{
					$('#MILESTONE_ID').combobox('reload', '/admin/milestone/comboList.json');
					$('#USER_ID').combobox('reload', '/admin/user/userList.json');
					$("#USER_ID").combobox('setValue', "<%=request.getAttribute("user_id")%>");
				}
				if(data){
					$('#ff').form('load', data);
				}else{
					//setData
					setFormData();
				}
				//카테고리 값을 셋팅 한다.
				if($('#SERVICE_ID').combobox('getValue') != "")
					$('#CATEGORY_ID').combobox('reload', '/admin/service/categoryList.json?SERVICE_ID='+$('#SERVICE_ID').combobox('getValue'));
			}, 1000);
		});
		
	 }
	
	 function dgOnChange(newValue, oldValue) {
		 var tr = $(this).closest('tr.datagrid-row');
		 var index = parseInt(tr.attr('datagrid-row-index'));
     }
	 function getCategory(){
		 if($('#SERVICE_ID').combobox('getValue') != "" && $('#SERVICE_ID').combobox('getValue') != undefined && !isNaN($('#SERVICE_ID').combobox('getValue'))){
			 $('#CATEGORY_ID').combobox('setValue','');
			 $('#CATEGORY_ID').combobox('reload', '/admin/service/categoryList.json?SERVICE_ID='+$('#SERVICE_ID').combobox('getValue'));
		 }
	 }
	 

	 function submitForm(){
		 if($('#ff').form('validate')){
			 var array = [];
			 if($("#TYPE").val() == "event"){
				 array = ["SERVICE_ID", "CATEGORY_ID", "EMERGENCY_CODE"];
			 }else{
				 array = ["SERVICE_ID", "CATEGORY_ID", "USER_ID"];
			 }
			
			 
			 if($("#TYPE").val() == "call"){
				 if($("#REQ_DT").datebox('getValue') - $("#END_DT").datebox('getValue') >= 0 ){
					 alert("종료일이 시작일보다 큽니다.");
					 return;
				 }
			 }
			 if(checkComboBox(array)){
				 alert("데이터를 확인하여 주세요.");
				 return;
			 }

			 
			 //submit
			 callAjax2Json("/admin/event/addEvent.do",{"param":getForm2Json($('#ff').serializeArray())}, success );
		 }
	 }
	 
	 function cleanForm(){
		 var typeVal = $("#TYPE").val();
		 $('#ff').form('clear');
		 $("#TYPE").val(typeVal);
	 }
	 
	 function success(data, textStatus, jqXHR ){
			if(data.STATUS == "SUCCESS"){
				alert("등록 되었습니다.");
				cleanForm();
			}else{
				$.messager.alert('ERROR',data.MESSAGE,'error');
			}
		}
	 
		function deleteFile(type){
			$("#"+type).val("- 삭제 -");
		}
		function downloadFile(type){
			if("- 삭제 -" == $("#"+type).val() || "-" == $("#"+type).val()){
				alert('첨부 파일이 없습니다.');
				return;
			}
			location.href="/admin/event/attattachFile.do?REQ_CODE="+$("#REQ_CODE").val()+"&TYPE="+type;
		}
		var fileType = "";
		function uploadFile(type){
			fileType = type;
			popupWindow = window.open(
	    			"/admin/event/pop/doFileUpload.do?REQ_CODE="+$("#REQ_CODE").val()+"&TYPE="+type,'uploadFilePop','height=200,width=300,left=300,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
		}
		
		function setFileName(fileName){
			$("#"+fileType).val(fileName);
		}
	 
</script>

</head>
<body>
	 <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Event <small>업무 추가</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="New Event" style="width:800px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post">
				    	<input type="hidden" name="param" id="param" />
				    	<select  id="TYPE" name="TYPE"  style="width:300px;"  onchange="goProcessForm(this.value)">
				    		<option value="event">요청</option>
				    		<option value="call">단순요청</option>
				    	</select>
					    <div id="formArea">
					    	
					    </div>
				    </form>
				    <div style="text-align:center;padding:5px">
				    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">저장</a>
				    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="cleanForm()">초기화</a>
				    </div>
				    </div>
				</div>
				
				
			</div>
		</div>
	</div>
</body>
</html>