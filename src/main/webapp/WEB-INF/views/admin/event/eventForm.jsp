<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table cellpadding="5">
	<tr>
		<td style="width:100px">서비스:</td>
		<td style="width:200px">
			 <input class="easyui-combobox" id="SERVICE_ID" name="SERVICE_ID" data-options="required:true,valueField:'ID',textField:'NAME',onChange:getCategory" style="width:500px;"/>
		</td>
	</tr>
	<tr>
		<td>카테고리:</td>
		<td>
			<input class="easyui-combobox" id="CATEGORY_ID" name="CATEGORY_ID" data-options="required:true,valueField:'ID',textField:'NAME'" style="width:500px;" />
		</td>
	</tr>
	<tr>
		<td>요청내역:</td>
		<td><textarea class="easyui-validatebox textbox" name="REQ_TITLE" id="REQ_TITLE" data-options="required:true,validType:'maxLength[500]'" style="width:500px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>요청자:</td>
		<td><input class="easyui-validatebox textbox" name="USER" id="USER" data-options="required:true, validType:'maxLength[25]'" style="width:500px;height:25px;"></input></td>
	</tr>
	<tr>
		<td>요청자 연락처:</td>
		<td><input class="easyui-validatebox textbox" name="USER_TEL" id="USER_TEL" data-options="required:true, validType:'maxLength[15]'" style="width:500px;height:25px;"></input></td>
	</tr>
	<tr id="emgc_area">
		<td>긴급도:</td>
		<td>
		<input class="easyui-combobox" id="EMERGENCY_CODE" name="EMERGENCY_CODE" data-options="required:true,valueField:'CODE',textField:'NAME'" style="width:500px;" />
		</td>
	</tr>
	<tr >
		<td>요청일:</td>
		<td>
			<input class="easyui-datetimebox" name="REQ_DT" id="REQ_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
		</td>
	</tr>
	<tr>
		<td>첨부파일: </td>
		<td>
		<input class="easyui-validatebox textbox" name="REQ_FILE" id="REQ_FILE" style="width:150px;height:25px;" readonly="readonly"></input>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="deleteFile('REQ_FILE')">삭제</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="downloadFile('REQ_FILE')">첨부 받기</a>
		<br /> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadFile('REQ_FILE')" style="width:300px;">파일 업로드</a>
		</td>
	</tr>
</table>
<script type="text/javascript">
function setFormData(){
	$('#ff').form('load', <%=Utils.getRequestValue(request.getParameter("param"))%>);
}
</script>