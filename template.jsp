<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet">
<style>
	*{
		margin:0px;
		font-family: 'Jua', sans-serif;
		text-decoration:none;
		color:#434343;
	}
	body{
		text-align:center;
	}
	a{
		color:#434343;
	}
	a:hover{
		text-decoration:underline;
		color:#886A08;
	}
	div#header{
		background-color:white;
	}
	div#content{
		background-color:#FBF8EF;
	}
</style>
</head>
<body>
	<%String content=request.getParameter("content");%>
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
	<div id="content">
		<jsp:include page="<%= content %>"/>
	</div>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>