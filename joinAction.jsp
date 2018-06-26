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
		request.setCharacterEncoding("UTF-8");
	
		String id=request.getParameter("userID");
		String pw=request.getParameter("userPW");
		String name=request.getParameter("userNAME");
		String num1=request.getParameter("num1");
		String num2=request.getParameter("num2");
		String num3=request.getParameter("num3");
		
		String num=num1+num2+num3;
		
		BufferedWriter writer = null;
		try{
			String filePath = application.getRealPath("/WEB-INF/member.txt");
			writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filePath,true),"utf-8"));
			writer.write(id+","+pw+","+name+","+num+",");
			writer.flush();

			response.sendRedirect("index.jsp");
		}
		catch(Exception e){
			System.out.println("오류 발생");
			response.sendRedirect("index.jsp");
		}
		finally{
			writer.close();
		}
	%>
</body>
</html>