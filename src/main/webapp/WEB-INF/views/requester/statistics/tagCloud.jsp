<%@page import="kr.pe.lahuman.utils.Constants"%>
<%@page import="kr.pe.lahuman.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>STATISTICS</title>
<link href="<%=Constants.getValue("context.path") %>css/jqcloud.css" rel="stylesheet">
<script src="<%=Constants.getValue("context.path") %>js/jqcloud-1.0.4.js"></script>
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
			 $("#SERVICE_ID").val("");
			 //submit
			callAjax2Json("/requester/statistics/tagCloudResult.json",{"param":getForm2Json($('#ff').serializeArray())}, success );
		 }
	 }

	function callDetail(serviceId){
		$("#SERVICE_ID").val(serviceId);
		callAjax2Json("/requester/statistics/tagCloudResult.json",{"param":getForm2Json($('#ff').serializeArray())}, success );
	}
	function success(dataList, textStatus, jqXHR ){
		var word_list = [];
		
		for(var i=0; i<dataList.length; i++){
			var word;
			if(dataList[i]["ID"]){
				word= {"text": dataList[i]["NAME"], "weight": dataList[i]["CNT"], "link": "javascript:callDetail('"+dataList[i]["ID"]+"');", "html":{"title":"총 "+dataList[i]["CNT"]+"건 (단순요청:"+dataList[i]["CALL_CNT"]+"건 요청:"+dataList[i]["EV01"]+"건 변경:"+dataList[i]["EV02"]+"건 장애: "+dataList[i]["EV03"]+"건) "}};
			}else{
				word = {"text": dataList[i]["NAME"], "weight": dataList[i]["CNT"], "html":{"title":"총 "+dataList[i]["CNT"]+"건 (단순요청:"+dataList[i]["CALL_CNT"]+"건 요청:"+dataList[i]["EV01"]+"건 변경:"+dataList[i]["EV02"]+"건 장애: "+dataList[i]["EV03"]+"건) "}};
			}
			word_list.push(word);
		}
		$("#statistics").html("");
		$("#statistics").jQCloud(word_list);
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
            <h2><i class="fa fa-desktop color"></i> TAG CLOUD <small>태그 클라우드 통계</small></h2>
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
				    <input type="hidden" name="SERVICE_ID" id="SERVICE_ID" />
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
				    <div id="statistics" style="width: 790px; height: 400px; border: 1px solid #ccc;">
				   	 	
				    </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>