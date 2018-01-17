<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>METTING DETAIL</title>
<script type="text/javascript">
	 
	 
	 $(function(){
		 
		 <%
		 if(request.getParameter("ID") != null && !"".equals(request.getParameter("ID") )){
		 %>
			 $("#ff").form('load',"/admin//meet/view.json?ID=<%=request.getParameter("ID")%>");
	 	 <%
		 }
		 %>
		 $.fn.datebox.defaults.formatter = function(date){
				var y = date.getFullYear();
				var m = date.getMonth()+1;
				var d = date.getDate();
				return y+''+(m<10?('0'+m):m)+''+(d<10?('0'+d):d);
			};
			$.fn.datebox.defaults.parser = function(s){
				if (!s) return new Date();
				var y = parseInt(s.substring(0,4),10);
				var m = parseInt(s.substring(4,6),10);
				var d = parseInt(s.substring(6,8),10);
				if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
					return new Date(y,m-1,d);
				} else {
					return new Date();
				}
			};
			$('#MEET_DT').datebox({
			    required:true,
			    validType:'defaultDate[]'
		    	, parser:function(s){
		    		if (!s) return new Date();
					var y = parseInt(s.substring(0,4),10);
					var m = parseInt(s.substring(4,6),10);
					var d = parseInt(s.substring(6,8),10);
					if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
						return new Date(y,m-1,d);
					} else {
						return new Date();
					}
				}
				, formatter:function(date){
					var y = date.getFullYear();
					var m = date.getMonth()+1;
					var d = date.getDate();
					return y+''+(m<10?('0'+m):m)+''+(d<10?('0'+d):d);
				}
			});
		
			
	 });
	 
	
	 function submitForm(){
		 if($('#ff').form('validate')){
			 
			 if($("#ETIME").val() - $("#STIME").val() <= 0 ){
				 alert("시작 시간이 종료 시간보다 큽니다.");
				 return;
			 }
			 //submit
			 callAjax2Json("/admin/meet/process.do",{"param":"["+getForm2Json($('#ff').serializeArray())+"]"}, success );
		 }
	 }
	 
	 function cleanForm(){
		 $('#ff').form('clear');
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
				<div class="easyui-panel" title="Meeting" style="width:600px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post">
				    	<input type="hidden" name="ID" name="ID" />
				    	<table cellpadding="5">
							<tr>
								<td>제목:</td>
								<td><input class="easyui-validatebox textbox" name="TITLE" id="TITLE" data-options="required:true, validType:'maxLength[100]'" style="width:300px;height:25px;"></input></td>
							</tr>
							<tr >
								<td>회의일:</td>
								<td>
									<input class="easyui-datebox" name="MEET_DT" id="MEET_DT" data-options="required:true,validType:'defaultDate[]'"  style="width:150px;">
								</td>
							</tr>
							<tr>
								<td>회의 시작 시간:</td>
								<td><input class="easyui-validatebox textbox" name="STIME" id="STIME" data-options="required:true, validType:'yearDate[]'" style="width:300px;height:25px;"></input></td>
							</tr>
							<tr>
								<td>회의 종료 시간:</td>
								<td><input class="easyui-validatebox textbox" name="ETIME" id="ETIME" data-options="required:true, validType:'yearDate[]'" style="width:300px;height:25px;"></input></td>
							</tr>
							<tr>
								<td>회의 장소:</td>
								<td><input class="easyui-validatebox textbox" name="LOCATION" id="LOCATION" data-options="required:true, validType:'maxLength[50]'" style="width:300px;height:25px;"></input></td>
							</tr>
							<tr>
								<td>기상청 참석자:</td>
								<td><input class="easyui-validatebox textbox" name="KMA_USER" id="KMA_USER" data-options="required:true, validType:'maxLength[500]'" style="width:300px;height:25px;"></input><br />* 소속 이름 직급 순으로 여러명일 경우,로 구분</td>
							</tr>
							<tr>
								<td>사업 수행 참석자:</td>
								<td><input class="easyui-validatebox textbox" name="COMPANY_USER" id="COMPANY_USER" data-options="required:true, validType:'maxLength[500]'" style="width:300px;height:25px;"></input><br />* 소속 이름 직급 순으로 여러명일 경우,로 구분</td>
							</tr>
							<tr>
								<td>회의 내용:</td>
								<td><textarea class="easyui-validatebox textbox" name="CONTENTS" id="CONTENTS" data-options="required:true, validType:'maxLength[1000]'" style="width:300px;height:180px;"></textarea></td>
							</tr>
							<tr>
								<td>특이사항:</td>
								<td><input class="easyui-validatebox textbox" name="ETC" id="ETC" data-options="validType:'maxLength[500]'" style="width:300px;height:25px;"></input></td>
							</tr>
						</table>
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