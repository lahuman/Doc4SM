<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  	<table cellpadding="5">
  		<!-- 공통 끝 -->
  		<tr>
  			<td style="width:200px">용도:</td>
  			<td style="width:300px"><input class="easyui-validatebox textbox" name="USE_TITLE" id="USE_TITLE" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >자원번호:</td>
  			<td ><input class="easyui-validatebox textbox" name="RESOURCE_NUM" id="RESOURCE_NUM" data-options="required:true,validType:'maxLength[40]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >소유기관:</td>
  			<td ><input class="easyui-validatebox textbox" name="OWN_GROUP" id="OWN_GROUP" data-options="required:true,validType:'maxLength[25]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr >
			<td>입주일:</td>
			<td>
				<input class="easyui-datebox" name="INSTALL_DT" id="INSTALL_DT" data-options="required:true,validType:'defaultDate[]'"  style="width:150px;">
			</td>
		</tr>
  		<tr>
  			<td >관리책임자:</td>
  			<td ><input class="easyui-validatebox textbox" name="OFFER_USER" id="OFFER_USER" data-options="required:true,validType:'maxLength[25]'" style="width:300px;height:25px;"></input></td>
  		</tr>  		
  		<tr>
  			<td >담당자:</td>
  			<td >
  				 <input class="easyui-combobox" id="MARK_ID" name="MARK_ID" data-options="required:true,valueField:'USER_ID',textField:'NAME'"  style="width:300px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td >서비스상태:</td>
  			<td >
  				 <input class="easyui-combobox" id="SERVICE_STATUS" name="SERVICE_STATUS" data-options="required:true,valueField:'CODE',textField:'NAME'" style="width:300px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td >중요도:</td>
  			<td >
  				 <input class="easyui-combobox" id="EMERGENCY_TYPE" name="EMERGENCY_TYPE" data-options="required:true,valueField:'CODE',textField:'NAME'" style="width:300px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td >제조사:</td>
  			<td >
  				 <input class="easyui-combobox" id="COMPANY_ID" name="COMPANY_ID" data-options="valueField:'ID',textField:'COMPANY_NAME'" style="width:300px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td >모델명:</td>
  			<td ><input class="easyui-validatebox textbox" name="MODEL_NAME" id="MODEL_NAME" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >시리얼넘버:</td>
  			<td ><input class="easyui-validatebox textbox" name="SERIAL_NO" id="SERIAL_NO" data-options="validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >OS:</td>
  			<td ><input class="easyui-validatebox textbox" name="OS" id="OS" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<!-- 공통 끝 -->
  		<!-- H/W-->
		<tr>
  			<td >호스트명:</td>
  			<td ><input class="easyui-validatebox textbox" name="HOST_NAME" id="HOST_NAME" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr> 
  		<tr>
  			<td >IP 주소:</td>
  			<td ><input class="easyui-validatebox textbox" name="IP_ADDRESS" id="IP_ADDRESS" data-options="required:true,validType:'maxLength[15]'" style="width:300px;height:25px;"></input></td>
  		</tr> 
  		<tr>
  			<td >물리위치:</td>
  			<td ><input class="easyui-validatebox textbox" name="REAL_LOCATION" id="REAL_LOCATION" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >CPU:</td>
  			<td ><input class="easyui-validatebox textbox" name="CPU" id="CPU" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >메모리:</td>
  			<td ><input class="easyui-validatebox textbox" name="MEMORY" id="MEMORY" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >내부디스크:</td>
  			<td ><input class="easyui-validatebox textbox" name="INSIDE_DISK" id="INSIDE_DISK" data-options="required:true,validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>
  		<tr>
  			<td >외부디스크:</td>
  			<td ><input class="easyui-validatebox textbox" name="OUTSIDE_DISK" id="OUTSIDE_DISK" data-options="validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr> 
  		<tr>
  			<td >부속물품 및 기타 정보:</td>
  			<td ><input class="easyui-validatebox textbox" name="ADJUNCTION" id="ADJUNCTION" data-options="validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
  		</tr>  		
  	</table>
<script type="text/javascript">
	function setFormData(){
		<% if(!"".equals(Utils.getRequestValue(request.getParameter("param")))){%>
		$('#ff').form('load', <%=Utils.getRequestValue(request.getParameter("param"))%>);
		<%}%>
	}
</script>