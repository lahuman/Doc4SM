<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	
	<!-- start: Meta -->
	<meta charset="utf-8">
	<title>DOC4SM 상황판</title>
	<meta name="description" content="Dashboard">
	<meta name="author" content="lahuman">
	<meta name="keyword" content="Dashboard, Doc4SM">
	<!-- end: Meta -->
	
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
		
		
<script type="text/javascript">
<!--
// 시계를 보여주는 스크립트 입니다
function show2(){
        if (!document.all&&!document.getElementById)
        return;
        thelement=document.getElementById? document.getElementById("tick2"): document.all.tick2;
        var Digital=new Date();
        var year = Digital.getFullYear();
        var month = Digital.getMonth()+1;
        var day = Digital.getDate();
        var hours=Digital.getHours();
        var minutes=Digital.getMinutes();
        var seconds=Digital.getSeconds();
        var dn="오후";
        if (hours<12)
        dn="오전";
        if (hours>12)
        hours=hours-12;
        if (hours==0)
        hours=12;
        if (minutes<=9)
        minutes="0"+minutes;
        if (seconds<=9)
        seconds="0"+seconds;
        var ctime=year + "-"+month+"-"+day+" "+ dn+" " +hours+":"+minutes+":"+seconds;
        thelement.innerHTML="<b style='font-size:12;'>"+ctime+"</b>";
        
        // 글자의 색상을 수정할 수 있습니다
        setTimeout("show2()",1000);
        // 1초(1000)마다 갱신하여 초단위로 보여줍니다
}
window.onload=show2;

//-->
</script>
		
</head>

<body>
		<!-- start: Header -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="index.html"><span>Doc4SM 상황판</span></a>
				<div class="nav-no-collapse header-nav">
					<ul class="nav pull-right">
						<li class="dropdown">
							<a class="btn dropdown-toggle" id="tick2">
								 YYYYY
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- start: Header -->
	
		<div class="container-fluid-full">
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
		</div><!--/fluid-row-->
		
	
	<div class="clearfix"></div>
	
	
	
	<!-- start: JavaScript-->

		<script src="/monitoring/js/jquery-1.9.1.min.js"></script>
	
		<script src="/monitoring/js/jquery-ui-1.10.0.custom.min.js"></script>
	
		<script src="/monitoring/js/bootstrap.min.js"></script>
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
	<!-- end: JavaScript-->
	
</body>
</html>
