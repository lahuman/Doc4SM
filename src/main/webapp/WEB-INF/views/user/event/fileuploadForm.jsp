<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>File Upload</title>
</head>
<body>
<h1>File Upload</h1>
	<form method="post" enctype="multipart/form-data" action="/user/event/pop/doFileUpload.do">
	<input type="hidden" name="REQ_CODE" value="<%=request.getParameter("REQ_CODE") %>" />
	<input type="hidden" name="TYPE" value="<%=request.getParameter("TYPE") %>" />
		Upload File: <input type="file" name="file">
		<br/><br/><input type="submit" value="Upload"> 
	</form>
</body>
</html>