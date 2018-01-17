<%@page import="kr.pe.lahuman.utils.Constants"%>
<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>STATISTICS</title>
<style type="text/css">
ul {
    margin: 20px;
}

.input-color {
    position: relative;
}
.input-color input {
    padding-left: 20px;
}
.input-color .color-box {
    width: 10px;
    height: 10px;
    display: inline-block;
    background-color: #ccc;
    position: absolute;
    left: 5px;
    top: 5px;
}
</style>
<script src="<%=Constants.getValue("context.path") %>js/Chart.js"></script>
<script type="text/javascript">
	 
	 $(function(){
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
	 });
	
	 function submitForm(){
		 if($('#ff').form('validate')){
			 //submit
			callAjax2Json("/admin/statistics/exclue/serviceResult.do",{"param":getForm2Json($('#ff').serializeArray())}, success );
		 }
	 }

	function success(dataList, textStatus, jqXHR ){
		
		$("#statistics").html('<div align="center"><span class="input-color"><input type="text" value="단순요청" disabled="disabled" class="textbox" /><div class="color-box" style="background-color: #9932CC;"></div></span><span class="input-color"><input type="text" value="서비스 요청" class="textbox"/><div class="color-box" style="background-color: #FFA500;" ></div></span><span class="input-color"><input type="text" value="변경" disabled="disabled" class="textbox" /><div class="color-box" style="background-color: #006400;"></div></span><span class="input-color"><input type="text" value="장애" class="textbox"/><div class="color-box" style="background-color: #FF4040;" ></div></span></div><canvas id="canvas" height="450" width="600"></canvas>');
		var labels = [];
		var innerData = [[],[],[],[]];
		for(var i=0; i<dataList.length; i++){
			labels.push(dataList[i].DT);
			innerData[0].push(dataList[i]["CALL_CNT"]);
			innerData[1].push(dataList[i]["EV01"]); 
			innerData[2].push(dataList[i]["EV02"]); 
			innerData[3].push(dataList[i]["EV03"]);
		}
		var barChartData = {
			labels : labels ,
			datasets : [
				{
					fillColor : "rgba(153,50,204,0.5)",
					strokeColor : "rgba(153,50,204,0.8)",
					highlightFill: "rgba(153,50,204,0.75)",
					highlightStroke: "rgba(153,50,204,1)",
					data : innerData[0]
				},
				{
					fillColor : "rgba(255,165,0,0.5)",
					strokeColor : "rgba(255,165,0,0.8)",
					highlightFill: "rgba(255,165,0,0.75)",
					highlightStroke: "rgba(255,165,0,1)",
					data : innerData[1]
				},
				{
					fillColor : "rgba(0,100,0,0.5)",
					strokeColor : "rgba(0,100,0,0.8)",
					highlightFill: "rgba(0,100,0,0.75)",
					highlightStroke: "rgba(0,100,0,1)",
					data : innerData[2]
				},
				{
					fillColor : "rgba(255,64,64,0.5)",
					strokeColor : "rgba(255,64,64,0.8)",
					highlightFill: "rgba(255,64,64,0.75)",
					highlightStroke: "rgba(255,64,64,1)",
					data : innerData[3]
				}
				
			]

		};
		
		var ctx = document.getElementById("canvas").getContext("2d");
		
		window.myBar = new Chart(ctx).Bar(barChartData, {
			responsive : true
		});		
		
	}
	 
	 function cleanForm(){
		 $('#ff').form('clear');
	 }
	 
	 
	 var randomScalingFactor = function(){ return Math.round(Math.random()*50)};
		
</script>

</head>
<body>

<!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> SERVICE <small>서비스별 통계</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="Service Statistics" style="width:800px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="post"><input type="hidden" name="type" value="YMD" />
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
				    <div id="statistics">
				   	 	
				    </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>