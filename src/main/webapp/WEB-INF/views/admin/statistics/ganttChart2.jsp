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


<script type="text/javascript">

function submitForm(){
	window.open("/admin/exclue/statistics/ganttChart2.do?START_DT="+$("#START_DT").datebox('getValue')+"&END_DT="+$("#END_DT").datebox('getValue'),'','height=800,width=800,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=no');
};

function cleanForm(){
	 $('#ff').form('clear');
};
$(function(){
	
	
});
</script>
</head>
<body>

<!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> GANTT CHART2 <small>간트 차트2</small></h2>
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
				    <form id="ff" method="get" action="/admin/statistics/ganttChart.do"><input type="hidden" name="type" value="YMD" />
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
				    <div style="position:relative" class="gantt" id="ganttChart"></div>
				    <br />
				   
					
				   
				</div>
			</div>
		</div>
	</div>
</body>
</html>