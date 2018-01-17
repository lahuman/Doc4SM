<%@page import="kr.pe.lahuman.utils.DataMap"%>
<%@page import="java.util.List"%>
<%@page import="kr.pe.lahuman.utils.Constants"%>
<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>STATISTICS</title>
<link rel="stylesheet" type="text/css" href="<%=Constants.getValue("context.path") %>css/jsgantt.css"/>
<script src="<%=Constants.getValue("context.path") %>js/jsgantt.js"></script>
<script type="text/javascript">
	 
	 $(function(){
		 
		 
		  if( g ) {

			    // Parameters             (pID, pName,                  pStart,      pEnd,        pColor,   pLink,          pMile, pRes,  pComp, pGroup, pParent, pOpen, pDepend, pCaption)
				
				// You can also use the XML file parser JSGantt.parseXML('project.xml',g)
				<%
					if(request.getAttribute("chartData") != null){
						List<DataMap<String, String>> resultList =(List<DataMap<String, String>> )request.getAttribute("chartData");
						for(DataMap<String, String> data : resultList){%>
							g.AddTaskItem(new JSGantt.TaskItem(<%=data.getString("rownum")%>, '<%=data.getString("title")%>', '<%=data.getString("req_dt")%>', '<%=data.getString("complete_dt")%>','<%=data.getString("PROC_TYPE")%>', '', 0, '<%=data.getString("proc_user")%>',     100, 0, 0, 0,0, '<%=data.getString("target")%>'));			
						<%
						}
						
					}
				%>
			    
			    g.Draw();	
			    g.DrawDependencies();

			  }

			  else

			  {

			    alert("not defined");

			  }
		 
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
				
				$("#START_DT").datebox('setValue', '<%=Utils.getRequestValue(request.getParameter("START_DT"))%>');
				$("#END_DT").datebox('setValue', '<%=Utils.getRequestValue(request.getParameter("END_DT"))%>')
	 });
	
	 function submitForm(){
		 if($('#ff').form('validate')){
			 //submit
			$('#ff').submit();
		 }
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
            <h2><i class="fa fa-desktop color"></i> GANTT CHART <small>간트 차트</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<div class="easyui-panel" title="Gantt Chart" style="width:1100px">
					<div style="padding:30px 60px 20px 60px">
				    <form id="ff" method="get" action="/requester/statistics/ganttChart.do"><input type="hidden" name="type" value="YMD" />
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
				    <div style="position:relative" class="gantt" id="GanttChartDIV"></div>
				    <script>


  // here's all the html code neccessary to display the chart object

  // Future idea would be to allow XML file name to be passed in and chart tasks built from file.

  var g = new JSGantt.GanttChart('g',document.getElementById('GanttChartDIV'), 'day');

 g.setShowRes(1); // Show/Hide Responsible (0/1)
 g.setShowDur(0); // Show/Hide Duration (0/1)
 g.setShowComp(0); // Show/Hide % Complete(0/1)
 g.setCaptionType('Resource');  // Set to Show Caption (None,Caption,Resource,Duration,Complete)
 //g.setDateInputFormat("yyyy-mm-dd");
	
</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>