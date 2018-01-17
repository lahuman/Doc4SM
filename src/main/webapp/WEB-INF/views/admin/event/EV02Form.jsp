<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <input type="hidden" name="REQ_TYPE" value="C" />
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
	<tr>
		<td>긴급도:</td>
		<td>
		<input class="easyui-combobox" id="EMERGENCY_CODE" name="EMERGENCY_CODE" data-options="required:true,valueField:'CODE',textField:'NAME'" style="width:380px;" />
		</td>
	</tr>
	<tr>
		<td>관련 시설:</td>
		<td>
			<input class="easyui-combobox" id="INFRA_ID" name="INFRA_ID" data-options="required:true,valueField:'ID',textField:'USE_TITLE',multiple:true,multiline:true" style="width:380px;height:50px;" />
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
		<td>처리예정일:</td>
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
		<td>작업시작시간:</td>
		<td><input class="easyui-datetimebox" name="WORK_ST" id="WORK_ST" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;"></input></td>
	</tr>
	<tr>
		<td>작업종료시간:</td>
		<td><input class="easyui-datetimebox" name="WORK_ET" id="WORK_ET" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;"></input></td>
	</tr>
	<tr>
		<td>서비스 중단 시간(분):</td>
		<td><input class="easyui-validatebox textbox" name="SERVICE_STOP_TIME" id="SERVICE_STOP_TIME" data-options="required:true, validType:'onlyNumber[]'" style="width:100px;height:25px;"></input>분 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="onChangePeriod()">자동계산</a></td>
	</tr>
	<tr>
		<td>처리시간(분):</td>
		<td><input class="easyui-validatebox textbox" name="SPEND_TIME" id="SPEND_TIME" data-options="required:true, validType:'onlyNumber[]'" style="width:100px;height:25px;"></input>분</td>
	</tr>
	<tr>
		<td>변경되는 구성요소 및 주요 내용:</td>
		<td><textarea class="easyui-validatebox textbox" name="CHANGE_LOG" id="CHANGE_LOG" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>변경 목적:</td>
		<td><textarea class="easyui-validatebox textbox" name="REASON" id="REASON" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>변경이 되지 않을 경우 영향:</td>
		<td><textarea class="easyui-validatebox textbox" name="EFFECT" id="EFFECT" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>작업 계획:</td>
		<td><textarea class="easyui-validatebox textbox" name="WORK_PLAN" id="WORK_PLAN" data-options="required:true, validType:'maxLength[800]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>복구 계획:</td>
		<td><textarea class="easyui-validatebox textbox" name="RESTORE_PLAN" id="RESTORE_PLAN" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>작업 결과:</td>
		<td><textarea class="easyui-validatebox textbox" name="RESULT" id="RESULT" data-options="required:true, validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
	</tr>
	<tr>
		<td>반영 결과:</td>
		<td>
		<select id="cc" class="easyui-combobox" id="SUCCESS" name="SUCCESS" style="width:200px;">
		    <option value="Y">성공</option>
		    <option value="N">실패</option>
		    <option value="C">취소</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>CAB 의견:</td>
		<td><textarea class="easyui-validatebox textbox" name="CAB" id="CAB" data-options="validType:'maxLength[500]'" style="width:380px;height:100px;"></textarea></td>
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