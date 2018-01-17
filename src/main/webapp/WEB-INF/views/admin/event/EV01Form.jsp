<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <input type="hidden" name="REQ_TYPE" value="S" />
<table cellpadding="5">
	<tr>
		<td style="width:150px">서비스:</td>
		<td style="width:400px">
			 <input class="easyui-combobox" id="SERVICE_ID" name="SERVICE_ID" data-options="required:true,valueField:'ID',textField:'NAME',onChange:getCategory" style="width:380px;"/>
		</td>
	</tr>
	<tr>
		<td>카테고리:</td>
		<td>
			<input class="easyui-combobox" id="CATEGORY_ID" name="CATEGORY_ID" data-options="required:true,valueField:'ID',textField:'NAME'" style="width:380px;" />
		</td>
	</tr>
	<tr>
		<td>요청내역:</td>
		<td><textarea class="easyui-validatebox textbox" name="REQ_TITLE" id="REQ_TITLE" data-options="required:true,validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
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
	<tr>
		<td>요청자:</td>
		<td><input class="easyui-validatebox textbox" name="USER" id="USER" data-options="required:true, validType:'maxLength[25]'" style="width:380px;height:25px;"></input></td>
	</tr>
	<tr>
		<td>요청자 연락처:</td>
		<td><input class="easyui-validatebox textbox" name="USER_TEL" id="USER_TEL" data-options="required:true, validType:'maxLength[15]'" style="width:380px;height:25px;"></input></td>
	</tr>
	<tr >
		<td>긴급도:</td>
		<td>
		<input class="easyui-combobox" id="EMERGENCY_CODE" name="EMERGENCY_CODE" data-options="required:true,valueField:'CODE',textField:'NAME'" style="width:380px;" />
		</td>
	</tr>
	<tr>
		<td>관련 시설:</td>
		<td>
			<input class="easyui-combobox" id="INFRA_ID" name="INFRA_ID" data-options="valueField:'ID',textField:'USE_TITLE',multiple:true,multiline:true" style="width:380px;height:50px;" />
		</td>
	</tr>
	<tr >
		<td>요청일:</td>
		<td>
			<input class="easyui-datetimebox" name="REQ_DT" id="REQ_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
		</td>
	</tr>
	<tr >
		<td>접수일:</td>
		<td>
			<input class="easyui-datetimebox" name="RECEIPT_DT" id="RECEIPT_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
		</td>
	</tr>
	<tr>
		<td>처리자:</td>
		<td>
			<input class="easyui-combobox" id="PROC_USER" name="PROC_USER" data-options="required:true,valueField:'USER_ID',textField:'NAME'" style="width:380px;" />
		</td>
	</tr>
	<tr >
		<td>요청완료예정일:</td>
		<td>
			<input class="easyui-datetimebox" name="SCHEDULE_DT" id="SCHEDULE_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
		</td>
	</tr>
	<tr >
		<td>처리완료일:</td>
		<td>
			<input class="easyui-datetimebox" name="COMPLETE_DT" id="COMPLETE_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
		</td>
	</tr>
	<tr>
		<td>처리시간(분):</td>
		<td><input class="easyui-validatebox textbox" name="SPEND_TIME" id="SPEND_TIME" data-options="required:true, validType:'onlyNumber[]'" style="width:100px;height:25px;"></input>분<a href="javascript:void(0)" class="easyui-linkbutton" onclick="onChangePeriod()">자동계산</a></td>
	</tr>
	<tr>
		<td>처리결과:</td>
		<td><textarea class="easyui-validatebox textbox" name="PROCESS_RT" id="PROCESS_RT" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>첨부파일: </td>
		<td>
		<input class="easyui-validatebox textbox" name="FILE_NAME" id="FILE_NAME" style="width:150px;height:25px;" readonly="readonly"></input>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="deleteFile('FILE_NAME')">삭제</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="downloadFile('FILE_NAME')">첨부 받기</a>
		<br /> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadFile('FILE_NAME')" style="width:300px;">파일 업로드</a>
		</td>
	</tr>
	<tr>
		<td>마일스톤 :</td>
		<td>
			<input class="easyui-combobox" id="MILESTONE_ID" name="MILESTONE_ID" data-options="valueField:'ID',textField:'TITLE',multiple:false,multiline:false" style="width:380px;height:25px;" />
		</td>
	</tr>
	
</table>
<script type="text/javascript">
function setFormData(){
	<% if(!"".equals(Utils.getRequestValue(request.getParameter("param")))){%>
	$('#ff').form('load', <%=Utils.getRequestValue(request.getParameter("param"))%>);
	<%}%>
}
</script>