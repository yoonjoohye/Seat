<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	input[type="text"]{
		width:200px;
		height:30px;
		border:1px solid #eeeeee;
		border-radius:5px;
	}
	input[type="button"]{
		width:150px;
		height:50px;
		color:white;
		font-size:20pt;
		border:0px;
		background-color:#886A08;
	}
	
	input[type="button"]#del{
		margin-top:10px;
		margin-left:60px;
		font-size:10pt;
		width:20px;
		height:20px;
		background-color:#886A08;
		color:white;
		border:0px;
	}
	
	input[type="button"]:hover{
		background-color:#5F4C0B;
	}
	
	input[type="button"]#addBtn{
		margin-bottom:10px;
		width:30px;
		height:30px;
		border-radius:30px;
		border:3px solid #886A08;
		color:#886A08;
		background-color:white;
		font-size:15pt;
	}
	
	input[type="radio"]{
		margin-right:15px;
		margin-left:15px;
	}
	div#info{
		text-align:center;
		padding-top:30px;
	}
	p#seat{
		text-align:center;
		font-size:20pt;
	}
	p#stu{
		text-align:center;
		font-size:20pt;
	}
</style>
</head>
<body>
<form name="setForm" method="post" action="setAction.jsp">
<div id="info">
	<p id="seat">자리 설정</p>
    <%!
	public String maleCheck(String value){
		if(value.equals("남")) {
			return "checked";	
		}
		else {
			return "";
		}	
	}
    public String femaleCheck(String value){
		if(value.equals("여")) {
			return "checked";	
		}
		else {
			return "";
		}	
	}
    public String way1(String value){
    	if(value.equals("gender")){
    		return "checked";
    	}
    	else{
    		return "";
    	}
    }
    public String way2(String value){
    	 if(value.equals("rand")){
    			return "checked";
    		}
    	else{
    		return "";
    	}
    }
    public String way3(String value){
   	 if(value.equals("normal")){
   			return "checked";
   		}
   	else{
   		return "";
   	}
   }
	%>
	
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
		String[] Array = tmp.split(",");%>
		<label>↔</label><input type="text" name="garo" value="<%=Array[Array.length-3]%>"/><br>
		<label>↕</label><input type="text" name="sero" value="<%=Array[Array.length-2]%>"/><br><br>
		<p id="stu">
		학생정보 설정
		<input id="addBtn" type="button" value="+"/><br>
		<input type="hidden" id="count" name="count" value=<%=(Array.length-3)/2 %>>
		</p>
		
		<%
		for(int i=0; i<Array.length-3; i++){
			if(i%2==0){
			c++;%>
			<div>
				<label>학번</label>
				<input type="text" name="num" value="<%=Array[i]%>"><br>
					
				<label>성별</label>
				<input type="radio" name="gender<%=c %>" value="남" <%=maleCheck(Array[i+1])%>>남
				<input type="radio" name="gender<%=c %>" value="여" <%=femaleCheck(Array[i+1])%>>여
				<input type="button"  id="del" name="delete[<%=c %>]" value="X" onclick="delButton(<%=c %>)"/><br><br>
			</div>
			<%}%>
		<%}%>
		</div>
		<input type="radio" name="check" value="gender" <%=way1(Array[Array.length-1])%>>남녀순으로 뽑기
		<input type="radio" name="check" value="rand" <%=way2(Array[Array.length-1])%>>랜덤으로 뽑기
		<input type="radio" name="check" value="normal" <%=way3(Array[Array.length-1])%>>그대로 뽑기<br><br>
	<%}catch(Exception e){
		c=1;%>
			<label>↔</label><input type="text" name="garo"/><br>
		    <label>↕</label><input type="text" name="sero"/><br><br>
			
			<h2 id="stu">학생 정보 설정</h2>
			<input id="addBtn" type="button" value="추가" />
		    <input type="text" id="count" name="count" value="1"><br><br>
		    
		    <div>
				<label>학번</label>
				<input type="text" name="num" ><br>
					
				<label>성별</label>
				<input type="radio" name="gender<%=c %>" value="남">남
				<input type="radio" name="gender<%=c %>" value="여">여
				<input type="button" id="del"name="delete[<%=c %>]" value="X" onclick="delButton(<%=c %>)"/><br><br>
			</div>
		</div>
		<input type="radio" name="check" value="gender" checked>남녀순으로 뽑기
		<input type="radio" name="check" value="rand">랜덤으로 뽑기
		<input type="radio" name="check" value="normal">그대로 뽑기<br><br>
	<%}%>
	
	<input type="button" value="등록하기" onclick="set()" />
	<a href="index.jsp"><input type="button" value="돌아가기"/></a><br><br>
</form>

	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script>
		var cnt=<%=c%>;
		$(document).ready(function() {
		    $('#addBtn').click(function() {
		    	cnt++;
		        $('#info').append(
		        		'<div>'+
		                '<label>학번</label> '+
		        		'<input type="text" name="num" /><br>'+
		        		'<label>성별</label> '+
		        		'<input type="radio" name="gender'+cnt+'" value="남" />남 '+
		        		'<input type="radio" name="gender'+cnt+'" value="여" />여 '+
		        		'<input type="button" id="del" name="delete['+ cnt +']" value="X" onclick="delButton('+cnt+')"/><br><br>'+
		        		'</div>'
		        );
		       	document.getElementById("count").value=cnt;
		    });
		});
		function delButton(idx){
			cnt--;
			$("input[name='delete["+idx+"]']").parent().empty();
			document.getElementById("count").value=cnt;
		}
		function set(){
			document.setForm.submit();	
		}
	</script>
	
</body>
</html>