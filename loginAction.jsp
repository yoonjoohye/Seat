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
		if(userID!=null){	
			out.println("<script>");
			out.println("alert('이미 로그인 되어있습니다.');");
			out.println("location.href='index.jsp';");
			out.println("</script>");
		}
		
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		
		BufferedReader reader = null;
		String a="";
		String tmp = "";
		
		try{
			String filePath = application.getRealPath("/WEB-INF/member.txt");
			reader=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
			while(true){
				a = reader.readLine();
				if(a==null)break;
				tmp += a;
			}
		}catch(Exception e){
			out.println("지정된 파일을 찾을 수 없습니다.");
		}
		String[] Array = tmp.split(",");
		Boolean check=false;
		for(int i=0; i<Array.length/4; i++){
			if(id.equals(Array[i*4])){
				if(pw.equals(Array[i*4+1])){
					check=true;
					break;
				}
				else{
					check=false;
				}
			}
			else{
				check=false;
			}
		}
		if(check==true){
			session.setAttribute("userID",id);
			response.sendRedirect("index.jsp");	
		}
		else{%>
			<script> 
			window.onload=function(){
				alert("다시 확인해주십시오."); 
				location.href="login.jsp";
			} 
			</script>
		<%}%>
</body>
</html>