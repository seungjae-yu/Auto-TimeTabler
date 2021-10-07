<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<body>

<table border="1" >
<tr>
<td align="center">학수번호</td><td align="center">과목명</td> <td align="center">학년</td> <td align="center">학점</td> <td align="center">과목구분</td> <td align="center">시간 및 강의실</td> <td align="center">담당교수</td>  <td align="center">평가방식</td> <td align="center">비고</td><td align="center">선택</td>
</tr>

<%		
		BufferedReader reader = null;
		try
		 {
		  String filePath = application.getRealPath("/Data.txt");//  <---input 파일을 연다.
		  reader = new BufferedReader(new FileReader(filePath));
		  while(true)
		  {
		  String str = reader.readLine(); //  <-- 한행의 텍스트 데이터를 읽는다.
		  
		  if(str==null){
		   break;
		  }
		  
		  //out.print(str+"</br>");   // <--- 읽은 데이터를 모니터로 출력 한다.
		  
		  out.print("<tr><td colspan=9>"+str+"</td></tr>");	  
		  
		  }
		 
		 }
		 catch(FileNotFoundException fnfe)
		 {
		  out.print("파일이 존재 하지 않습니다.");
		 }
		catch(IOException ioe)
		{
		 out.print("파일을 읽을수 없습니다.");
		}
		
		finally
		{
		 try 
		 {
		  reader.close();   //  <---- 파일을 닫는다.
		 }
		 catch(Exception e)
		 {
		 
		 }
		}
%>
</table>
</body>
</html>