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
  			<td><input class="easyui-validatebox textbox" name="USER" id="USER" data-options="required:true,validType:'maxLength[25]'" style="width:500px;height:25px;"></input></td>
  		</tr>
  		<tr>
			<td>요청자 연락처:</td>
			<td><input class="easyui-validatebox textbox" name="USER_TEL" id="USER_TEL" data-options="required:true, validType:'maxLength[15]'" style="width:500px;height:25px;"></input></td>
		</tr>
  		<tr>
  			<td>담당자:</td>
  			<td>
  				<input class="easyui-combobox" id="USER_ID" name="USER_ID" data-options="required:true,valueField:'USER_ID',textField:'NAME'" style="width:500px;" />
  			</td>
  		</tr>
  		<tr >
  			<td>요청일:</td>
  			<td>
  				<input class="easyui-datetimebox" name="REQ_DT" id="REQ_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
  			</td>
  		</tr>
  		<tr id="enddt_area">
  			<td>종료일:</td>
  			<td>
  				<input class="easyui-datetimebox" name="END_DT" id="END_DT" data-options="required:true,showSeconds:false,validType:'defaultDateTime[]'"  style="width:150px;">
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
		$('#ff').form('load', <%=Utils.getRequestValue(request.getParameter("param"))%>);
	}
</script>