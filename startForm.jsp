<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
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
	
	BufferedReader reader = null;
	
	String a="";
	String tmp = "";
	String filename=userID+".txt";
	
	int c=0;
	
	try{
		String filePath=application.getRealPath("/WEB-INF/member/"+filename);
		reader=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
		
		while(true){
			a = reader.readLine();
			if(a==null) break;	
			tmp += a;
		}
		String[] Array = tmp.split(",");
		
		if(Array[Array.length-1].equals("gender")){%>
			<jsp:forward page="template.jsp">
				<jsp:param name="content" value="gender.jsp"/>
			</jsp:forward>
		<%}
		else if(Array[Array.length-1].equals("rand")){%>
			<jsp:forward page="template.jsp">
				<jsp:param name="content" value="rand.jsp"/>
			</jsp:forward>
		<%}
		else if(Array[Array.length-1].equals("normal")){%>
		<jsp:forward page="template.jsp">
			<jsp:param name="content" value="normal.jsp"/>
		</jsp:forward>
		<%}
	}catch(Exception e){%>
		<script>
			window.onload=function(){
				alert("데이터가 없습니다.")
				location.href="index.jsp";
			}
		</script>
	<%}
	%>
</body>
</html>