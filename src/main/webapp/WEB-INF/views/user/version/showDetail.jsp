<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VERSION-DETAIL</title>
<script type="text/javascript">
	 $(function(){
				$("#dg").datagrid({
					title:"Version Detail"
					, width:600
					, height:400
					, iconCls: 'icon-edit'
					, singleSelect: true
					, url: '/user/version/showDetail.json?REVISON=<%=request.getParameter("REVISON")%>'
					//, onDblClickCell: onClickRow
					, columns:[[
					            {field:'TYPE',title:"구분", width:50}
					            , {field:'PATH',title:"작업파일", width:500}
					   ]]
		 });
	 });
</script>

</head>
<body>
      
      <div class="services">
         <div class="container">
			<div class="row">
				
			</div>
			<div class="row">
				<table id="dg"></table>
				<div id="tb" style="height:auto;">
				</div>
			</div>
		</div>
	</div>
</body>
</html>