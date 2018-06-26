<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	input#start, input#set{
		width:300px;
		height:150px;
		margin:10px;
		background-color:#886A08;
		color:white;
		font-size:50pt;
		border:0px;
		border-radius:40px;
	}
	input#start:hover, input#set:hover,input#login:hover{
		background-color:#5F4C0B;
	}
	input#id, input#pw, input#login{
		margin:5px;
		width:300px;
		height:30px;
		font-size:20pt;
		border-radius:5px;
		border:1px solid #eeeeee;
	}
	input#login{
		width:300px;
		height:50px;
	 	background-color:#886A08;
	 	color:white;
	}
</style>
<script>
	function check(){
		var id=document.loginForm.id.value;
		var pw=document.loginForm.pw.value;
		
		if(id!=""&&pw!=""){
			document.loginForm.submit();
		}
		else{
			alert("아이디와 비밀번호를 확인해주세요");
		}
		
	}
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		
		if(userID==null){
	%>
	<form name="loginForm" method="post" action="loginAction.jsp">
		<input type="text" id="id" name="id" placeholder="아이디"><br>
		<input type="password" id="pw" name="pw" placeholder="패스워드"><br>
		<a href="#">아이디/비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;
		<a href="join.jsp">회원가입</a><br>
		<input type="button" id="login" value="로그인" onclick="check()">
	</form>
	<%}else{%>
		<a href="start.jsp"><input type="button" id="start" value="START"></a><br>
		<a href="set.jsp"><input type="button" id="set" value="SET"></a><br>
	<%} %>
</body>
</html>