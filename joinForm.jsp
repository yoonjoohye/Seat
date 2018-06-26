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
	div#join{
		margin-left:8%;
		padding-top:20px;
	}
	input[type="text"],input[type="password"]{
		width:300px;
		height:30px;
		border:1px solid #eeeeee;
		border-radius:10px;
		font-size:15pt;
	}
	input[type="number"]{
		width:100px;
		height:30px;
		border:1px solid #eeeeee;
		border-radius:10px;
		font-size:15pt;
	}
	iframe{
		border:1px solid #eeeeee;
		background-color:white;
	}
	input[type="button"]{
		background-color:#886A08;
		color:white;
		border:0px;
		width:150px;
		height:50px;
		font-size:20pt;
	}
	input#chk{
		width:80px;
		height:30px;
		font-size:15pt;
	}
	input[type="button"]:hover{
		background-color:#5F4C0B;
	}
</style>
	<%
		request.setCharacterEncoding("UTF-8");
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
	%>

<script>	
	function check(){
		var id=document.joinForm.userID.value;
		bool=true;

		if(id==""){
			alert("아이디를 입력해주세요");
			bool="X";
		}
		else{
			<%for(int i=0; i<Array.length/4; i++){%>
				if(id=="<%=Array[i*4]%>"){
					bool=false;
				}
			<%}%>
		}
		if(bool==true){
			alert("사용 가능한 아이디입니다.");		
		}
		else if(bool==false){
			alert("이미 존재하는 아이디입니다.");
			document.joinForm.userID.value="";
		}
	}
	function join(){
		var id=document.joinForm.userID.value;
		var pw=document.joinForm.userPW.value;
		var chk_pw=document.joinForm.checkPW.value;
		var name=document.joinForm.userNAME.value;
		var num1=document.joinForm.num1.value;
		var num2=document.joinForm.num2.value;
		var num3=document.joinForm.num3.value;
		
		if(id!=""&&pw!=""&&chk_pw!=""&&name!=""&&num1!=""&&num2!=""&&num3!=""&&document.joinForm.agree.checked){
			if(pw!=chk_pw){
				alert("비밀번호를 확인해주세요!");
				document.joinForm.pw_chk.focus();
				return;
			}
			else{
				document.joinForm.submit();
			}
		}
		else{
			alert("정보를 확인해주세요!");
			return;
		}
		
	}
</script>
</head>
<body>
 <form name="joinForm" method="post" action="joinAction.jsp">
 	<center>
 	<div id="join">
 	<table>
 		<tr>
 			<td align="left">아이디</td>
 			<td align="left">
 				<input type="text"  name="userID">
 				<input type="button" id="chk" value="중복체크" onclick="check()">
 			</td>
 		</tr>
 		<tr>
 			<td align="left">비밀번호</td>
 			<td align="left"><input type="password" name="userPW"></td>
 		</tr>
 		<tr>
 			<td align="left">비밀번호 확인</td>
 			<td align="left"><input type="password"  name="checkPW"></td>
 		</tr>
 		<tr>
 			<td align="left">성명</td>
 			<td align="left"><input type="text" name="userNAME"></td>
 		</tr>
 		<tr>
 			<td align="left">전화번호</td>
 			<td align="left">
 				<input type="number" name="num1">-
 				<input type="number" name="num2">-
 				<input type="number" name="num3">
 			</td>
 		</tr>
 		<tr>
 			<td colspan=2><iframe src="agree.jsp" width="600px"></iframe></td>
 		</tr>
 		<tr>
			<td colspan=2><input type="checkbox" name="agree">위 약관에 동의합니다.</td>
 		</tr>
 	</table>
 	</div>
 	<input type="button" id="join" value="회원가입" onclick="join()">
	<a href="index.jsp"><input type="button" value="취소"/></a>
 	</center>
 </form>
</body>
</html>