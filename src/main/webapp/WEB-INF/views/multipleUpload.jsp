<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Multiple File Upload </title>
</head>
<body>
 <h1> Multiple File Upload </h1>
	<form method="post" enctype="multipart/form-data" action="/user/multipleSave.do">
		Upload File 1: <input type="file" name="file"> <br/>
		Upload File 2: <input type="file" name="file"> <br/>
		Upload File 3: <input type="file" name="file"> <br/>
		Upload File 4: <input type="file" name="file"> <br/>
		<br /><br /><input type="submit" value="Upload"> 
	</form>
</body>
</html>