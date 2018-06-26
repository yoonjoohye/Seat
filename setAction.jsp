<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
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
	request.setCharacterEncoding("utf-8");
	
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	int garo=Integer.parseInt(request.getParameter("garo"));
	int sero=Integer.parseInt(request.getParameter("sero"));
	
	String num[]=request.getParameterValues("num");
	int count=Integer.parseInt(request.getParameter("count"));
	
	String result[]=new String[count];
	int x=1;
	int y=0;
	do{
		String[] chk = new String[1];
		for(int i=0; i<1; i++){
			if(request.getParameterValues("gender"+x)!=null){
				chk=request.getParameterValues("gender"+x);
			}
		}
		if(chk[0]!=null){
			result[y]=chk[0];
			y++;
		}
		x++;
	}while(x<=count);
	
	String check[]=request.getParameterValues("check");
	
	out.println(garo);
	out.println(sero);
	out.println("<br>");
	for(int i=0; i<count; i++){
		out.println(num[i]);
		out.println(result[i]);
		out.println("<br>");
	}
	out.println(check[0]);
	
	String filename=userID+".txt";
	
	BufferedWriter writer=null;
	try{
		String filePath=application.getRealPath("/WEB-INF/member/"+filename);
		writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath),"UTF-8"));
		for(int i=0; i<count; i++){
			writer.write(num[i]+","+result[i]+",");
		}
		writer.write(garo+","+sero+","+check[0]+",");
		writer.flush();%>
		<script>
		window.onload=function(){
			alert("등록완료!");
			location.href="set.jsp"
		}
		</script>
	<%
	}catch(Exception e){
		out.println("오류발생");
	}	
	%>
	
</body>
</html>