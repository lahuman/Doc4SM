<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>EVENT</title>
<script type="text/javascript">


var isProcess = false;
	$(function(){
		 <%if(!"".equals(Utils.getRequestValue(request.getParameter("PROC_TYPE")))){%>
		 	changeForm("<%=request.getParameter("PROC_TYPE")%>", <%=Utils.getRequestValue(request.getParameter("param"))%>);
		 <%}else if(!"".equals(Utils.getRequestValue(request.getParameter("REQ_CODE")))){%>
		 	callAjax2Json("/user/event/read.json", {"param":JSON.stringify({REQ_CODE:"<%=request.getParameter("REQ_CODE")%>"})}, function(data){
				changeForm(data.PROC_TYPE, data);
			 });	 
		 
		 <%}else{%>
		 changeForm('EV00');
		 <%}%>
		$(document).on("click","input[name=REQ_TYPE]", function(){
				changeForm('EV00');	
		});
	});
	function onChangePeriod(){
		if($("#PROC_TYPE").val() == "EV02" || $("#PROC_TYPE").val() == "EV00"){
			//변경
			 if($("#WORK_ST").datebox('getValue') - $("#WORK_ET").datebox('getValue') < 0 ){
				 $("#SERVICE_STOP_TIME").val( setDifferentMnutes($("#WORK_ST").datebox('getValue'), $("#WORK_ET").datebox('getValue')));
			 }
		}else if($("#PROC_TYPE").val() == "EV03"){
			//장애
			 if($("#OBSTACLE_ST").datebox('getValue') - $("#OBSTACLE_ET").datebox('getValue') < 0 ){
				 $("#SERVICE_OBSTACLE_TIME").val( setDifferentMnutes($("#OBSTACLE_ST").datebox('getValue'), $("#OBSTACLE_ET").datebox('getValue')));
			 }
		}
		
		if($("#RECEIPT_DT").datebox('getValue') - $("#COMPLETE_DT").datebox('getValue') < 0 ){
			 $("#SPEND_TIME").val( setDifferentMnutes($("#RECEIPT_DT").datebox('getValue'), $("#COMPLETE_DT").datebox('getValue')));
		 }
	}
	 function setDifferentMnutes(startTime, endTime){
		   // 시작일시 
		   var startDate = new Date(parseInt(startTime.substring(0,4), 10),
		             parseInt(startTime.substring(4,6), 10)-1,
		             parseInt(startTime.substring(6,8), 10),
		             parseInt(startTime.substring(8,10), 10),
		             parseInt(startTime.substring(10,12), 10),
		             00
		            );
		            
		   // 종료일시 
		   var endDate   = new Date(parseInt(endTime.substring(0,4), 10),
		             parseInt(endTime.substring(4,6), 10)-1,
		             parseInt(endTime.substring(6,8), 10),
		             parseInt(endTime.substring(8,10), 10),
		             parseInt(endTime.substring(10,12), 10),
		             00
		            );

		   // 두 일자(startTime, endTime) 사이의 차이를 구한다.
		   var dateGap = endDate.getTime() - startDate.getTime();
		   
		   // 두 일자(startTime, endTime) 사이의 간격을 "분"으로 표시한다.
		   return Math.floor(dateGap / (1000 * 60 ));       
	 }
	function makeForm2Json(){
		return getForm2Json($('#ff').serializeArray());
	}
	function goProcessForm(type){
		$("#ff").attr("action", "/user/event/pop/processEvent.do");
		$("#param").val(makeForm2Json());
		$("#ff").submit();
	}
	
	function changeForm(type, modifyData){
		$("#formArea").load("/user/event/pop/"+type+"Form.do",{"param":makeForm2Json()}, function(){
			setTimeout(function(){
				$('#SERVICE_ID').combobox('reload', '/user/service/serviceList.json?USE_YN=Y');
				$('#EMERGENCY_CODE').combobox('reload', '/user/code/codeList.json?CODE_MASTER=EMGC');
				$('#PROC_USER').combobox('reload', '/user/user/userList.json');
				$('#INFRA_ID').combobox('reload', '/user/infra/comboInfraList.json');
				$('#MILESTONE_ID').combobox('reload', '/user/milestone/comboList.json');
				$('#PROC_USER').combobox('setValues', '<%=request.getAttribute("user_id") %>');
				
				if(modifyData){
					$('#ff').form('load', modifyData);
					var infraIds = (modifyData["INFRA_ID"]+"").split(",");
					if(infraIds != "undefined" )
						$('#INFRA_ID').combobox("setValues", infraIds);
				}else{
					//setData
					setFormData();
				}
				//카테고리 값을 셋팅 한다.
				if($('#SERVICE_ID').combobox('getValue') != "")
					$('#CATEGORY_ID').combobox('reload', '/user/service/categoryList.json?SERVICE_ID='+$('#SERVICE_ID').combobox('getValue'));
				
				//요청 종류가 있을 경우
				if($("input[name=REQ_TYPE]:checked").size() > 0){
					if($("input[name=REQ_TYPE]:checked").val() == "S"){
						$("#changeArea,#obstacleArea").hide();
					}else if($("input[name=REQ_TYPE]:checked").val() == "C"){
						$("#obstacleArea").hide();
					}else if($("input[name=REQ_TYPE]:checked").val() == "O"){
						$("#changeArea").hide();
					}
				}
			}, 1000);
		});
	}
	
	
	function submitForm(){
		 if($('#ff').form('validate')){
			 var array = ["SERVICE_ID", "CATEGORY_ID", "EMERGENCY_CODE", "PROC_USER", "INFRA_ID"];
			 if($("#PROC_TYPE").val() == "EV00" || $("#PROC_TYPE").val() == "EV01"){
				 array = ["SERVICE_ID", "CATEGORY_ID", "EMERGENCY_CODE", "PROC_USER"];	 
			 }
			 if(checkComboBox(array)){
				 alert("데이터를 확인하여 주세요.");
				 return;
			 }
			 //시간
			 if($("#PROC_TYPE").val() != "EV00"){
				 if($("#RECEIPT_DT").datebox('getValue') - $("#COMPLETE_DT").datebox('getValue') >= 0 ){
					 alert("접수일이 완료일 보다 큽니다.");
					 return;
				 }
				 if($("#PROC_TYPE").val() == "EV02"){
					 if($("#WORK_ST").datebox('getValue') - $("#WORK_ET").datebox('getValue') >= 0 ){
						 alert("작업시작일이 작업종료일 보다 큽니다.");
						 return;
					 }
					 
				 }
				 if($("#PROC_TYPE").val() == "EV03"){
					 if($("#OBSTACLE_ST").datebox('getValue') - $("#OBSTACLE_ET").datebox('getValue') >= 0 ){
						 alert("장애 시작일이 장애 종료일 보다 큽니다.");
						 return;
					 }
				 }	 
			 }
			 
			 
			 //submit
			 callAjax2Json("/user/event/processEvent.do",{"param":getForm2Json($('#ff').serializeArray())}, success );

			
		 }
	}
	
	function cleanForm(){
		 var typeVal = $("#PROC_TYPE").val();
		 var id = $("#REQ_CODE").val();
		 $('#ff').form('clear');
		 $("#REQ_CODE").val(id);
		 $("#PROC_TYPE").val(typeVal);
	}

	function success(data, textStatus, jqXHR ){
		if(data.STATUS == "SUCCESS"){
			alert("처리 되었습니다.");
			opener.loadGrid();
			self.opener = self;
			window.close();
		}else{
			$.messager.alert('ERROR',data.MESSAGE,'error');
		}
	}
	function getCategory(){
		if($('#SERVICE_ID').combobox('getValue') != "" && $('#SERVICE_ID').combobox('getValue') != undefined && !isNaN($('#SERVICE_ID').combobox('getValue'))){
			 $('#CATEGORY_ID').combobox('setValue','');
			 $('#CATEGORY_ID').combobox('reload', '/user/service/categoryList.json?SERVICE_ID='+$('#SERVICE_ID').combobox('getValue'));
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
		location.href="/user/event/attattachFile.do?REQ_CODE="+$("#REQ_CODE").val()+"&TYPE="+type;
	}
	var fileType = "";
	function uploadFile(type){
		fileType = type;
		popupWindow = window.open(
    			"/user/event/pop/doFileUpload.do?REQ_CODE="+$("#REQ_CODE").val()+"&TYPE="+type,'uploadFilePop','height=200,width=300,left=300,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
	}
	
	function setFileName(fileName){
		$("#"+fileType).val(fileName);
	}
</script>

</head>
<body>
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="Process Event" style="width:600px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post" >
				    	<input type="hidden" name="REQ_CODE" id="REQ_CODE">
				    	<input type="hidden" name="param" id="param">
				    	<select  id="PROC_TYPE" name="PROC_TYPE"  style="width:300px;"  onchange="goProcessForm(this.value)">
				    		<option value="EV00">접수-처리</option>
				    		<option value="EV01">서비스</option>
				    		<option value="EV02">변경</option>
				    		<option value="EV03">장애</option>
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