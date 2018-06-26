<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
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
	String filename=userID+".txt";
	
	int garo=Integer.parseInt(request.getParameter("garo"));
	int sero=Integer.parseInt(request.getParameter("sero"));
	
	int total=garo*sero;
	String desk[]=new String[total];
	for(int i=0; i<total; i++){
		desk[i]=request.getParameter("seat"+i);
		out.println(desk[i]);
	}
	
	BufferedWriter writer=null;
	try{
		String filePath=application.getRealPath("/WEB-INF/save/"+filename);
		writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath),"UTF-8"));
		for(int i=0; i<total; i++){
			writer.write(desk[i]+",");
		}
		writer.write(garo+","+sero+",");
		writer.flush();%>
		<script>
		window.onload=function(){
			alert("저장완료!");
			location.href="index.jsp"
		}
		</script>
	<%
	}catch(Exception e){
		out.println("아직 데이터가 없습니다.");
	}
%>
</body>
</html>