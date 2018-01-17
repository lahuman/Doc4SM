<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.pe.lahuman.utils.Constants"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
<head>
    <title>ITSM | <sitemesh:write property='title'/></title>

   		<meta charset="utf-8">
		<!-- Title here -->
		<!-- IE 최신  보기 -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		
		<!-- Description, Keywords and Author -->
		<meta name="description" content="Your description">
		<meta name="keywords" content="Your,Keywords">
		<meta name="author" content="ResponsiveWebInc">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- Styles -->
		
		<!-- Animate css -->
		<link href="<%=Constants.getValue("context.path") %>css/animate.min.css" rel="stylesheet">
		<!-- Dropdown menu -->
		<link href="<%=Constants.getValue("context.path") %>css/ddlevelsmenu-base.css" rel="stylesheet">
		<link href="<%=Constants.getValue("context.path") %>css/ddlevelsmenu-topbar.css" rel="stylesheet">
		<!-- Countdown -->
		<link href="<%=Constants.getValue("context.path") %>css/jquery.countdown.css" rel="stylesheet">
		<!-- prettyPhoto -->
		<link href="<%=Constants.getValue("context.path") %>css/prettyPhoto.css" rel="stylesheet">      
		<!-- Font awesome CSS -->
		<link href="<%=Constants.getValue("context.path") %>css/font-awesome.min.css" rel="stylesheet">		
		<!-- Custom CSS -->
		<link href="<%=Constants.getValue("context.path") %>css/style.css" rel="stylesheet">
		
		<!-- Bootstrap CSS -->
		<link href="<%=Constants.getValue("context.path") %>css/bootstrap.min.css" rel="stylesheet">
		
		<!-- easyui -->
		<link href="<%=Constants.getValue("context.path") %>css/easyui.css" rel="stylesheet">
		<link href="<%=Constants.getValue("context.path") %>css/icon.css" rel="stylesheet">
		
		<!-- Favicon 이거 넣으면 한번더 페이지를 확인하네;
		 
		<link rel="shortcut icon" href="#">
		-->
    
    
    		<!-- Javascript files -->
		<!-- jQuery -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.js"></script>
		<!-- Bootstrap JS -->
		<script src="<%=Constants.getValue("context.path") %>js/bootstrap.min.js"></script>
		      
		<!-- CaroFredSel -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.carouFredSel.js"></script> 
		<!-- Countdown -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.countdown.min.js"></script>      
		<!-- Filter for support page -->
		<script src="<%=Constants.getValue("context.path") %>js/filter.js"></script>      
		<!-- Isotope -->
		<script src="<%=Constants.getValue("context.path") %>js/isotope.js"></script>
		<!-- prettyPhoto -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.prettyPhoto.js"></script>      
		<!-- Respond JS for IE8 -->
		<script src="<%=Constants.getValue("context.path") %>js/respond.min.js"></script>
		<!-- HTML5 Support for IE -->
		<script src="<%=Constants.getValue("context.path") %>js/html5shiv.js"></script>
		
		
		<!-- easyUI -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.easyui.min.js"></script>
		<!-- blockUI -->
		<script src="<%=Constants.getValue("context.path") %>js/jquery.blockUI.js"></script>
		<!-- common -->
		<script src="<%=Constants.getValue("context.path") %>js/common.js"></script>
		<!-- GRID common -->
		<script src="<%=Constants.getValue("context.path") %>js/commonDataGridFunction.js"></script>
		
		<!-- JSON -->
		<script src="<%=Constants.getValue("context.path") %>js/JSON3.js"></script>
<sitemesh:write property='head'/>
     
</head> 

<body>
       
      
	<sitemesh:write property='body'/>
    
	<!-- Scroll to top -->
	<span class="totop"><a href="#"><i class="fa fa-chevron-up"></i></a></span> 
</body>
</html> 
