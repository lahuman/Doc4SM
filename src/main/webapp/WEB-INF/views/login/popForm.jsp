<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Login Page</title>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>
<script type="text/javascript">
	$(function() {
	<%if("LoginError".equals(request.getParameter("errorMsg"))){%>
		alert("로그인에 실패 하였습니다.\nID/PW를 확인하여주세요.");
	<%} %>
	  // Handler for .ready() called.
	  $("#username").focus();
	});
</script>

</head>
<body >

	
	
	<!-- Page content -->
      
      <div class="blocky">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="register-login">
                     <div class="cool-block">
                        <div class="cool-block-bor">
                        
                           <h3>Login</h3>
                           <form name='f' action="<c:url value='/login' />" method='POST' class="form-horizontal" role="form">
                             <div class="form-group">
                               <label for="username" class="col-lg-2 control-label">username</label>
                               <div class="col-lg-10">
                                 <input type="text" class="form-control" id="username" name="username" placeholder="UserName" style="ime-mode:disabled;">
                               </div>
                             </div>
                             <div class="form-group">
                               <label for="inputPassword1" class="col-lg-2 control-label">Password</label>
                               <div class="col-lg-10">
                                 <input type="password" class="form-control" id="inputPassword1" placeholder="Password" name="password">
                               </div>
                             </div>
                             <div class="form-group">
                               <div class="col-lg-offset-2 col-lg-10">
                                 <div class="checkbox">
                                   <label>
                                     <input type="checkbox" name="remember-me"> Remember me
                                   </label>
                                 </div>
                               </div>
                             </div>
                             <div class="form-group">
                               <div class="col-lg-offset-2 col-lg-10">
                                 <button type="submit" class="btn btn-info">Sign in</button>
                                 <button type="reset" class="btn btn-default">Reset</button>
                               </div>
                             </div>
                           </form>
                           
                        </div>
                     </div>   
                  </div>
               </div>
            </div>
         </div>
      </div>
      

</body>
</html>