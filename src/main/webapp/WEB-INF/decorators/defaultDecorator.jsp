<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="kr.pe.lahuman.utils.Constants"%>
<%
String username = null;
if(SecurityContextHolder.getContext().getAuthentication() != null ){

	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	if ( principal instanceof UserDetails) {
		username = ((UserDetails)principal).getUsername();
	} 
}
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
<head>
    <title>Doc4SM | <sitemesh:write property='title'/></title>

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
     
     
     <script type="text/javascript">
     
     function openMonitoring(type){
		window.open(
				type+"/exclue/monitoring/dashboard.do",'popUpWindow','height=400,width=860,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no,directories=no,status=no');
 	}
     </script>
</head> 

<body>
       
      <!-- Logo & Navigation starts -->
      
      <div class="header">
         <div class="container">
            <div class="row">
               <div class="col-md-2 col-sm-2">
                  <!-- Logo -->
                  <div class="logo">
                     <h1><a href="<%=Constants.getValue("context.path") %>index.jsp">Doc4SM</a></h1>
                  </div>
               </div>
               <div class="col-md-6 col-sm-5">
                  <!-- Navigation menu -->
						<div class="navi">
							<div id="ddtopmenubar" class="mattblackmenu">
			               	<%if(request.isUserInRole("ROLE_ADMIN")){ %>
								<ul>
									<li><a href="#" rel="ddsubmenu1">설정</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
                              				<li><a href="<%=Constants.getValue("context.path") %>admin/user.do">사용자</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/infra.do">시설관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/codeMaster.do">상위코드관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/code.do">하위코드관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/company.do">업체관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/service.do">서비스카테고리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/holiday.do">휴일 관리</a></li>
										</ul>
		                            </li>
									<li><a href="#" rel="ddsubmenu1">업무</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>admin/event/addEventForm.do">업무추가</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/external.do">외부업체 업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/call.do">단순 업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/event/event.do">업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/milestone/list.do">마일스톤</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/problem/list.do">문제관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/meet/list.do">회의록</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/vacation.do">휴가관리</a></li>
										</ul>
		                            </li>
									<li><a href="#" rel="ddsubmenu1">출력물</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/call.do">단순 업무 대장 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/event.do">업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/problem.do">문제 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/external.do">외부업무대장</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/infra.do">시설 현황 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/daily.do">일일 업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/meeting.do">회의록</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/vacation.do">휴가</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/report/slm.do">SLM</a></li>
										</ul>
		                            </li>
		                            <li><a href="#" rel="ddsubmenu1">통계</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>admin/statistics/event.do">업무 통계</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/statistics/service.do">서비스별 통계</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/statistics/tagCloud.do">태그 클라우드</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/statistics/ganttChart.do">간트 차트</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/statistics/ganttChart2.do">간트 차트2</a></li>
										</ul>
		                            </li>
		                            <%if(!"N".equals(Constants.getValue("svn.use"))){ %>
		                            <li><a href="#" rel="ddsubmenu1">릴리즈</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>admin/version/list.do">형상관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>admin/version/manage.do">버젼관리</a></li>
										</ul>
		                            </li>
		                            <%} %>
		                            <!-- 
									<li><a href="<%=Constants.getValue("context.path") %>admin/version/list.do">형상관리</a></li>
		                             -->
		                            <li><a href="javascript:openMonitoring('/admin')" >모니터링</a></li>
								</ul>
							<%}else if(request.isUserInRole("ROLE_USER")){ %>
								<ul>
									<li><a href="#" rel="ddsubmenu1">업무</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>user/event/addEventForm.do">업무 추가</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/external.do">외부업체 업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/call.do">단순 업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/event/event.do">업무 관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/milestone/list.do">마일스톤</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/problem/list.do">문제관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/meet/list.do">회의록</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/vacation.do">휴가관리</a></li>
										</ul>
		                            </li>
									<li><a href="#" rel="ddsubmenu1">출력물</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>user/report/call.do">단순 업무 대장 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/event.do">업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/problem.do">문제 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/external.do">외부업무대장</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/infra.do">시설 현황 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/daily.do">일일 업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/meeting.do">회의록 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/vacation.do">휴가</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/report/slm.do">SLM</a></li>
										</ul>
		                            </li>
		                            <%if(!"N".equals(Constants.getValue("svn.use"))){ %>
		                            <li><a href="#" rel="ddsubmenu1">릴리즈</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>user/version/list.do">형상관리</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>user/version/manage.do">버젼관리</a></li>
										</ul>
		                            </li>
		                            <%} %>
		                           <li><a href="javascript:openMonitoring('/user')" >모니터링</a></li>
		                         </ul>
		                     <%}else if(request.isUserInRole("ROLE_REQUESTER")){ %>
		                     <ul>
									<li><a href="#" rel="ddsubmenu1">업무</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>requester/event/addEventForm.do">업무 추가</a></li>
										</ul>
		                            </li>
									<li><a href="#" rel="ddsubmenu1">출력물</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/call.do">단순 업무 대장 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/event.do">업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/problem.do">문제 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/external.do">외부업무대장</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/infra.do">시설 현황 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/daily.do">일일 업무 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/meeting.do">회의록 출력</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/report/vacation.do">휴가</a></li>
										</ul>
		                            </li>
		                            <li><a href="#" rel="ddsubmenu1">통계</a>
                              			<ul id="ddsubmenu1" class="ddsubmenustyle">
											<li><a href="<%=Constants.getValue("context.path") %>requester/statistics/event.do">업무 통계</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/statistics/service.do">서비스별 통계</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/statistics/tagCloud.do">태그 클라우드</a></li>
											<li><a href="<%=Constants.getValue("context.path") %>requester/statistics/ganttChart.do">간트 차트</a></li>
										</ul>
		                            </li>
		                         </ul>
		                     <%} %>  
							</div>
						</div>

						<!-- Dropdown NavBar -->
                  <div class="navis"></div>                  
                  
               </div>
               <div class="col-md-4 col-sm-5">
					<div class="kart-links">
					<% if(username != null){ %>
						<%=username %>
						<a href="/logout">Logout</a>
					<%}else{ %>						
						<a href="/login/form.do">Login</a> 
						<!-- <a href="/register/join.do">Join</a> -->
					<%} %>
					</div>
				</div>
            </div>
         </div>
      </div>
      
      <!-- Logo & Navigation ends -->
       
       
<sitemesh:write property='body'/>
       
      <!-- Footer starts -->
      <footer>
         <div class="container">
         
            <hr />
            
            <div class="copy text-center">
               Copyright 2014 &copy; - lahuman.pe.kr
            </div>
         </div>
      </footer>
      <!-- Footer ends -->
      
      <!-- Scroll to top -->
      <span class="totop"><a href="#"><i class="fa fa-chevron-up"></i></a></span> 
      
		
		<!-- Dropdown menu -->
		<script src="<%=Constants.getValue("context.path") %>js/ddlevelsmenu.js"></script>
		<!-- Custom JS -->
		<script src="<%=Constants.getValue("context.path") %>js/custom.js"></script>
</body>
</html> 
