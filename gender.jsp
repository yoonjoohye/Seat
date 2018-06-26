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
<h1>남녀순으로 뽑기</h1>
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
	
	int male_cnt=0;
	int female_cnt=0;
	for(int i=0; i<Array.length-3; i++){
		if(i%2==1){
			if(Array[i].equals("남")){
				male_cnt++;
			}
			else if(Array[i].equals("여")){
				female_cnt++;
			}
		}
	}
	
	String[]male=new String[male_cnt];
	String[]female=new String[female_cnt];
	
	int m=0;
	int f=0;
	for(int i=0; i<Array.length-2; i++){
		if(i%2==1){
			if(Array[i].equals("남")){
				male[m]=Array[i-1];
				m++;
			}
			else if(Array[i].equals("여")){
				female[f]=Array[i-1];
				f++;
			}
		}
	}
	
	int []male_rand=new int[male_cnt];
	for(int i=0; i<male_cnt; i++){
		male_rand[i]=(int)(Math.random()*male_cnt)+0;
		
		for(int j=0; j<i; j++){
			if(male_rand[i]==male_rand[j]){
				i--;
				break;
			}
		}
	}
	int []female_rand=new int[female_cnt];
	for(int i=0; i<female_cnt; i++){
		female_rand[i]=(int)(Math.random()*female_cnt)+0;
		
		for(int j=0; j<i; j++){
			if(female_rand[i]==female_rand[j]){
				i--;
				break;
			}
		}
	}
	
	String seat[]=new String[total];
	int mm=0;	
	int ff=0;
	//남 녀 남 녀...
	if(m>=f){
		for(int i=0; i<total; i++){
			if(i%2==1){
				if(f>ff){
					seat[i]=female[female_rand[ff]]+"여";
					ff++;
				}
				else{
					seat[i]=male[male_rand[mm]]+"남";
					mm++;
				}
			}
			else{
				seat[i]=male[male_rand[mm]]+"남";
				mm++;
			}
		}
	}
	//여 남 여 남...
	else{
		for(int i=0; i<total; i++){
			if(i%2==1){
				if(m>mm){
					seat[i]=male[male_rand[mm]]+"남";
					mm++;
				}
				else{
					seat[i]=female[female_rand[ff]]+"여";
					ff++;
				}
			}
			else{
				seat[i]=female[female_rand[ff]]+"여";
				ff++;
			}
		}
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
<% }catch(Exception e){
		out.println("지정된 파일을 찾을 수 없습니다.");
}%>
</body>
</html>