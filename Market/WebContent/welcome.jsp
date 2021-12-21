<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<meta charset="UTF-8">
<title>웹쇼핑몰</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
<%

	String greeting="환영합니다";
	String tagline="Welcome to Web Market";

%>


<div class="jumbotron">
	<div class="container">
		<h1 class="display-3"><%=greeting %></h1>
	</div>

</div>

<div class="container">
	<div class="text-center">
		<h3><%=tagline%></h3>
		<%
			response.setIntHeader("refresh", 1); //1초 간격으로 refresh;
			Calendar calendar=Calendar.getInstance();
			int hour = calendar.get(Calendar.HOUR_OF_DAY);
			int minute = calendar.get(Calendar.MINUTE);
			int second = calendar.get(Calendar.SECOND);
			int am_pm=calendar.get(Calendar.AM_PM);
			String ampm=null;
			
			if(am_pm==0)
				ampm="오전";
			else
				ampm="오후";
			
			String connectTime=hour+":"+minute+":"+second+" "+ampm;
			out.println("현재접속시간"+connectTime+"\n");
				
		%>
	</div>
	<hr>

</div>

<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>