<%@page import="kr.pe.lahuman.utils.Constants"%>
<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>STATISTICS</title>
<script src="<%=Constants.getValue("context.path") %>js/dygraph-combined.js"></script>
<script type="text/javascript">
	 
	 $(function(){
		$("#type").bind("change", function(){
			//data-options="required:true,validType:'defaultDate[]'"
			if($("#type").val() == "YMD"){
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
				$('#START_DT').datebox({
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
				$('#END_DT').datebox({
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
			}else if($("#type").val() == "YM"){
				$('#START_DT').datebox({
				    required:true,
				    validType:'monthDate[]'
					, parser:function(s){
						if (!s) return new Date();
						var y = parseInt(s.substring(0,4),10);
						var m = parseInt(s.substring(4,6),10);
						if (!isNaN(y) && !isNaN(m) ){
							return new Date(y,m-1);
						} else {
							return new Date();
						}
					}
					, formatter:function(date){
						var y = date.getFullYear();
						var m = date.getMonth()+1;
						return y+''+(m<10?('0'+m):m);
					}
				});
				$('#END_DT').datebox({
				    required:true,
				    validType:'monthDate[]'
			    	, parser:function(s){
						if (!s) return new Date();
						var y = parseInt(s.substring(0,4),10);
						var m = parseInt(s.substring(4,6),10);
						if (!isNaN(y) && !isNaN(m) ){
							return new Date(y,m-1);
						} else {
							return new Date();
						}
					}
					, formatter:function(date){
						var y = date.getFullYear();
						var m = date.getMonth()+1;
						return y+''+(m<10?('0'+m):m);
					}
				});
			}else if($("#type").val() == "Y"){
				$('#START_DT').datebox({
				    required:true,
				    validType:'yearDate[]'
			    	, parser:function(s){
			    		if (!s) return new Date();
						var y = parseInt(s);
						var d = new Date();
						d.setFullYear(y);
						return d;
					}
					, formatter:function(date){
						var y = date.getFullYear();
						return y;
					}
				});
				$('#END_DT').datebox({
				    required:true,
				    validType:'yearDate[]'
			    	, parser:function(s){
			    		if (!s) return new Date();
						var y = parseInt(s);
						var d = new Date();
						d.setFullYear(y);
						return d;
					}
					, formatter:function(date){
						var y = date.getFullYear();
						return y;
					}
				});
			}
		});
		$("#type").trigger("change");
	 });
	
	 function submitForm(){
		 if($('#ff').form('validate')){
			 //submit
			callAjax2Html("/admin/statistics/exclue/eventResult.do",{"param":getForm2Json($('#ff').serializeArray())}, success );
		 }
	 }

	function success(data, textStatus, jqXHR ){
		g = new Dygraph(
	              document.getElementById("statistics"),
	              data,{
	            	  legend: 'always',
	            	  title: 'EVENT',
	            	  labelsDiv: 'legend'
	              });
	}
	 
	 function cleanForm(){
		 $('#ff').form('clear');
	 }
	 
</script>

</head>
<body>
      
      <!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> Event <small>업무 통계</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row" >
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="Event Statistics" style="width:800px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post">
				    	타입 : <select id="type" name="type">
				    			<option value="YMD">일별</option>
				    			<option value="YM">년월별</option>
				    			<option value="Y">년별</option>
				    		 </select>	
				    	시작일 : 
				    	<input class="easyui-datebox" name="START_DT" id="START_DT" style="width:150px;">
				    	종료일 : 
				    	<input class="easyui-datebox" name="END_DT" id="END_DT" style="width:150px;">
				    </form>
				    <div style="text-align:center;padding:5px">
				    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">통계</a>
				    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="cleanForm()">초기화</a>
				    </div>
				    </div>
				    <div class="row" id="legend" style="width:700px;height:50px;vertical-align: center;" align="center">
						
					</div>
					<div class="row" id="statistics" style="width:700px;height:400px;">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>