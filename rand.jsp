<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.BufferedWriter"%>
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
	div#board{
		width:500px;
		height:50px;
		background-color:#04B404;
		border:10px solid #B18904;
		border-radius:10px;
		color:white;
		font-size:30pt;
		font-weight:bold;
		text-align:center;
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
		text-align:center;
	}
	input{
		width:150px;
		height:50px;
		color:white;
		font-size:20pt;
		border:0px;
		background-color:#886A08;
	}
	input[type="button"]:hover,input[type="submit"]:hover{
		background-color:#5F4C0B;
	}
</style>
</head>
<body>
<form method="post" action="action.jsp">
<h1>랜덤으로 뽑기</h1>
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
		String filePath=application.getRealPath("/WEB-INF/member/"+filename);
		reader=new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
		while(true){
			a = reader.readLine();
			if(a==null)break;
			
			tmp += a;
		}
	String[] Array = tmp.split(",");
	
	int garo=Integer.parseInt(Array[Array.length-3]);
	int sero=Integer.parseInt(Array[Array.length-2]);
	
	int total=(Array.length-3)/2;
	//전체 학생수
	out.println("학생 수:"+total+"<br>");
	
	int cnt;
	
	cnt=0;
	String num[]=new String[total];
	for(int i=0; i<Array.length-3; i++){
		if(i%2==0){
			num[cnt]=Array[i];
			//out.println(num[cnt]);
			cnt++;
		}
	}
	cnt=0;
	String gender[]=new String[total];
	for(int i=0; i<Array.length-3; i++){
		if(i%2==1){
			gender[cnt]=Array[i];
			cnt++;
		}
	}

	int []rand=new int[total];
	for(int i=0; i<total; i++){
		rand[i]=(int)(Math.random()*total)+0;
		
		for(int j=0; j<i; j++){
			if(rand[i]==rand[j]){
				i--;
				break;
			}
		}
	}
	
	String seat[]=new String[total];
	for(int i=0; i<total; i++){
		seat[i]=num[rand[i]]+gender[rand[i]];
		//out.println(seat[i]);
	}%>
	<input type="hidden" name="garo" value="<%=garo%>">
	<input type="hidden" name="sero" value="<%=sero%>">
	<div id="board">칠판</div>
	<%
	String desk[][]=new String[sero][garo];
	for(int i=0; i<sero; i++){
		for(int j=0; j<garo; j++){
			if(garo*i+j<total){
				desk[i][j]=seat[garo*i+j];%>
				<div id="seat"><%=desk[i][j]%></div>
				<input type="hidden" name="seat<%=garo*i+j%>" value="<%=desk[i][j]%>">
			<%}
			else{
				desk[i][j]="X";%>
				<div id="seat"><%=desk[i][j]%></div>
				<input type="hidden" name="seat<%=garo*i+j%>" value="<%=desk[i][j]%>">
			<%}
		}
		out.println("<br>");
	}
%>
<input type="submit"  value="저장하기">
<a href="index.jsp"><input type="button" value="돌아가기"></a><br><br>
</center>
</form>
<%}catch(Exception e){
		out.println("지정된 파일을 찾을 수 없습니다.");
}%>
</body>
</html>