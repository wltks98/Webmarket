<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	String sessionId=(String)session.getAttribute("sessionId");
%>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

</head>
<body>

<sql:setDataSource var="dataSource" 
url="jdbc:mysql://localhost:3306/webmarketdb?serverTimezone=UTC"
driver="com.mysql.jdbc.Driver"
user="root" password="wl0328"
/>

<sql:update dataSource="${dataSource}" var="resultSet">
	delete from members where id=? 
	<sql:param value="<%=sessionId%>"/>
</sql:update>

	<c:if test="${resultSet>=1}">
		<c:import url="logoutMember.jsp"></c:import>
		<c:redirect url="resultMember.jsp"></c:redirect>
	</c:if>
	
</body>
</html>