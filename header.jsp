<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	span#logo{
		font-size:50pt;
		margin-right:300px;
	}
	div#register{
		display:inline;
		
	}
	div#header a{
		text-decoration:none;
		color:#434343;
	}
	div#header a:hover{
		color:#886A08;
	}
	div#register a#name{
		color:#886A08;	
	}
</style>
</head>
<body>
<a href="index.jsp"><span id="logo">자리바꾸기</span></a>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){%>
	<div id="register">
		<a href="login.jsp">로그인</a>
		<a href="join.jsp">회원가입</a>
	</div>
	<%}
	else{%>
	<div id="register">
		<a href="save.jsp" id="name"><%=userID %>님</a>
		<a href="logout.jsp">로그아웃</a>
	</div>
	<%}%>
</body>
</html>