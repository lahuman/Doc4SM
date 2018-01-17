<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>INFRA</title>
<script type="text/javascript">
	 
	 $(function(){
		 callAjax2Json("/admin/code/codeList.json?CODE_MASTER=HWSW", "", function(data){
			 for(var i=0; i<data.length; i++){
				 var o = new Option(data[i]["NAME"], data[i]["CODE"]);
				/// jquerify the DOM object 'o' so we can use the html method
				//$(o).html("option text");
				$("#DIVISION").append(o);
			 }
			 
			 <%if(!"".equals(Utils.getRequestValue(request.getParameter("DIVISION")))){%>
			 	changeForm("<%=request.getParameter("PROC_TYPE")%>", <%=Utils.getRequestValue(request.getParameter("param"))%>);
			 <%}else if(!"".equals(Utils.getRequestValue(request.getParameter("ID")))){%>
			 	callAjax2Json("/admin/infra/read.json", {"param":JSON.stringify({ID:"<%=request.getParameter("ID")%>"})}, function(data){
					changeForm(data.DIVISION, data);
				 });	 
			 <%}else{%>
			 changeForm('H101');
			 <%}%>
		 });
		 
	 });
	 
	function goProcessForm(type){
		$("#ff").attr("action", "/admin/event/pop/addInfra.do");
		$("#param").val(makeForm2Json());
		$("#ff").submit();
	}
	
	 var isFirst = true;
	 function changeForm(type, modifyData){
		 if(type.indexOf("H1") != -1){
			 type = "H001";
		 }else{
			 type = "H002";
		 }
		$("#formArea").load("/admin/infra/pop/"+type+"Form.do",{"param":getForm2Json($('#ff').serializeArray())}, function(){
			
			setTimeout(function(){
				$('#SERVICE_STATUS').combobox('reload', '/admin/code/codeList.json?CODE_MASTER=SVST');
				$('#EMERGENCY_TYPE').combobox('reload', '/admin/code/codeList.json?CODE_MASTER=EMGC');
				$('#COMPANY_ID').combobox('reload', '/admin/company/companyList.json');
				$('#MARK_ID').combobox('reload', '/admin/user/userList.json');
				if(type == "H002"){
					$('#LICENSE').combobox('reload', '/admin/code/codeList.json?CODE_MASTER=LICE');
				}
				if(modifyData){
					$('#ff').form('load', modifyData);
				}else{
					//setData
					setFormData();
				}
			}, 1000);
		});
		
	 }
	

	 function submitForm(){
		 if($('#ff').form('validate')){
			 var array = ["SERVICE_STATUS", "COMPANY_ID", "MARK_ID"];
			
			 if(checkComboBox(array)){
				 alert("데이터를 확인하여 주세요.");
				 return;
			 }

			 //submit
			 callAjax2Json("/admin/infra/addInfra.do",{"param":getForm2Json($('#ff').serializeArray())}, success );
		 }
	 }
	 
	 function cleanForm(){
		 var typeVal = $("#DIVISION").val();
		 var id = $("#ID").val();
		 $('#ff').form('clear');
		 $("#ID").val(id);
		 $("#DIVISION").val(typeVal);
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
	 
</script>

</head>
<body>
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="<%=(!"".equals(Utils.getRequestValue(request.getParameter("ID"))))?"Modify":"New"%> Infra" style="width:800px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post">
				    	<input type="hidden" name="ID" id="ID">
				    	<input type="hidden" name="param" id="param">
				    	<select id="DIVISION" name="DIVISION"  style="width:300px;"  onchange="changeForm(this.value)">
				    	
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