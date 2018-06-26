<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	div#content{
		text-align:center;
	}
	div#board{
		width:500px;
		height:50px;
		background-color:#04B404;
		border:10px solid #B18904;
		border-radius:10px;
		color:white;
		font-size:30pt;
		font-weight:bold;
	}
	div#seat{
		display:inline-block;
		width:100px;
		height:80px;
		margin:10px;
		background-color:#DBA901;
		border:5px solid #886A08;
		border-radius:10px;
		color:white;
		font-size:20pt;
		font-weight:bold;
	}
	input{
		width:150px;
		height:50px;
		color:white;
		font-size:20pt;
		border:0px;
		background-color:#886A08;
	}
	input[type="button"]:hover{
		background-color:#5F4C0B;
	}
</style>
</head>
<body>
<center>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		out.println("<script>");
		out.println("alert('로그인이 필요합니다.');");
		out.println("location.href='index.jsp';");
		out.println("</script>");
	}
	
	BufferedReader reader = null;
	String a="";
	String tmp = "";
	String filename=userID+".txt";
	
	try{
		String filePath=application.getRealPath("/WEB-INF/save/"+filename);
		reader=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
		while(true){
			a = reader.readLine();
			if(a==null)break;
			tmp += a;
		}%>
		<br>
		<div id="board" align="center">칠판</div>
		
		<%
		String[] Array = tmp.split(",");
		int garo=Integer.parseInt(Array[Array.length-2]);
		int sero=Integer.parseInt(Array[Array.length-1]);
		
		for(int i=0; i<sero; i++){
			for(int j=0; j<garo; j++){%>
				<div id="seat"><%=Array[i*garo+j]%></div>
			<%}
			out.println("<br>");
		}%>
		<a href="index.jsp"><input type="button" value="돌아가기"></a><br><br>
	<%}catch(Exception e){%>
		<script>
		window.onload=function(){
			alert("데이터가 없습니다.")
			location.href="index.jsp";
		}
		</script>
	<%}%>
</center>
</body>
</html>