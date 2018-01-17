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
<link rel="stylesheet" type="text/css" href="<%=Constants.getValue("context.path") %>css/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="<%=Constants.getValue("context.path") %>css/jquery.ganttView.css"/>

<script type="text/javascript" src="<%=Constants.getValue("context.path") %>js/jquery.js"></script>
<script type="text/javascript" src="<%=Constants.getValue("context.path") %>js/date.js"></script>
<script type="text/javascript" src="<%=Constants.getValue("context.path") %>js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=Constants.getValue("context.path") %>js/jquery.ganttView.js"></script>
<script type="text/javascript" src="<%=Constants.getValue("context.path") %>js/common.js"></script>

<script type="text/javascript">
function getForm2Json(a){
	 var o = {};
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            //o[this.name].push(this.value || '');
            o[this.name] = o[this.name]+","+this.value || '';
        } else {
            o[this.name] = this.value || '';
        }
    });
    return JSON.stringify(o);
}

$(function(){
	callAjax2Json("/admin/statistics/ganttChart2.json",{"param":getForm2Json($('#ff').serializeArray())}, success );	
});

function success(data, textStatus, jqXHR ){
	$("#ganttChart").html = "";
	$("#ganttChart").ganttView({ 
		data: data,
		slideWidth: 700,
		behavior: {
			clickable:false,
			resizable:false,
			draggable:false,
			onClick: function (data) { 
				var msg = "You clicked on an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
				$("#eventMessage").text(msg);
			},
			onResize: function (data) { 
				var msg = "You resized an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
				$("#eventMessage").text(msg);
			},
			onDrag: function (data) { 
				var msg = "You dragged an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
				$("#eventMessage").text(msg);
			}
		}
	});
	
	// $("#ganttChart").ganttView("setSlideWidth", 600);

}
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
				    <form id="ff" method="get" action="/admin/statistics/ganttChart.do"><input type="hidden" name="type" value="YMD" />
				    	시작일 : 
				    	<input type="text" name="START_DT" id="START_DT" value="<%=request.getParameter("START_DT")%>">
				    	종료일 :
				    	<input type="text" name="END_DT" id="END_DT" value="<%=request.getParameter("END_DT")%>">
				    </form>
				    <div style="position:relative" class="gantt" id="ganttChart"></div>
				    <br />
				   
					
				   
			</div>
		</div>
	</div>
</body>
</html>