<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DASH BOARD</title>
<%if("true".equals(request.getParameter("close"))){%>

	<script type="text/javascript">
		alert("로그인 되었습니다.\n작업을 다시 진행해 주세요.");
		self.close();
	</script>
<%} %>

<!-- start: Mobile Specific -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- end: Mobile Specific -->
	
	<!-- start: CSS -->
	<link id="bootstrap-style" href="/monitoring/css/bootstrap.min.css" rel="stylesheet">
	<link href="/monitoring/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link id="base-style" href="/monitoring/css/style.css" rel="stylesheet">
	<link id="base-style-responsive" href="/monitoring/css/style-responsive.css" rel="stylesheet">
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>

		<link id="ie-style" href="/monitoring/css/ie.css" rel="stylesheet">
	<![endif]-->
	
	<!--[if IE 9]>
		<link id="ie9style" href="/monitoring/css/ie9.css" rel="stylesheet">
	<![endif]-->
		
		
</head>
<body>

	<!-- Page title -->
      <div class="page-title">
         <div class="container">
            <h2><i class="fa fa-desktop color"></i> HOME <small>DOC4SM DASH BOARD</small></h2>
            <hr />
         </div>
      </div>
      <!-- Page title -->
      
      <div class="services">
         <div class="container">
			<!--
			<img src="/img/information.png" width="800px;"/> 
			 -->
			<div class="row-fluid">
				
		
			
			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
				</div>
			</noscript>
			
			<!-- start: Content -->
			<div id="content" >
			
	
			
			<div class="row-fluid">	

				<a class="quick-button metro yellow span2">
					<i class="icon-tasks"></i>
					<p>요청 <span id="totalRequest">0</span>건</p>
					
				</a>
				<a class="quick-button metro green span2">
					<i class="icon-check"></i>
					<p>처리완료 <span id="totalComplet">0</span>건</p>
					
				</a>
				<a class="quick-button metro orange span2">
					<i class="icon-bolt"></i>
					<p>단순처리 <span id="totalCall">0</span>건</p>
					
				</a>
				<div class="clearfix"></div>
			</div>
			<div class="row-fluid">	
			&nbsp;
			</div>
			<div class="row-fluid">	

				<a class="quick-button metro pink span2">
					<i class="icon-star"></i>
					<p>처리중 <span id="ev00">0</span>건</p>
					
				</a>
				<a class="quick-button metro blue span2">
					<i class="icon-bell"></i>
					<p>서비스 <span id="ev01">0</span>건</p>
					
				</a>				
				
				<a class="quick-button metro black span2">
					<i class="icon-magic"></i>
					<p>변경 <span id="ev02">0</span>건</p>
					
				</a>
				
				<a class="quick-button metro red span2">
					<i class="icon-lock"></i>
					<p>장애 <span id="ev03">0</span>건</p>
					
				</a>
				
				<div class="clearfix"></div>
								
			</div><!--/row-->
			
			<div class="row-fluid">	
			&nbsp;
			</div>
					

	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
		</div><!--/#content.span10-->
			
		</div>
	</div>
	
	<script type="text/javascript">
			$(function(){
				callData();
			});
			
			function callData(){
				$.ajax({
					  type: "POST",
					  url: "/user/monitoring/dashaboard.json",
					  success: success,
					  dataType: "JSON"
					});
		        setTimeout("callData()",1000*60*5);
			}
			function success(data, textStatus, jqXHR ){
				$("#totalRequest").text(data.TOTAL_REQUEST);
				$("#totalComplet").text(data.TOTAL_COMPLET);
				$("#totalCall").text(data.TOTAL_CALL);
				$("#ev00").text(data.EV00);
				$("#ev01").text(data.EV01);
				$("#ev02").text(data.EV02);
				$("#ev03").text(data.EV03);
			}
		</script>
</body>
</html>
