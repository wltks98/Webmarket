<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>
<!-- DB에 접속 -->
<sql:setDataSource var="dataSource" 
url="jdbc:mysql://localhost:3306/webmarketdb?serverTimezone=UTC"
driver="com.mysql.jdbc.Driver"
user="root" password="wl0328"/>

<!-- sql쿼리문을 실행하는 코드 executeQuery() 기능과 유사 -->
<sql:query dataSource="${dataSource}" var="resultSet">
	select * from members where id=? and password=?
	<sql:param value="<%=id%>"/>
	<sql:param value="<%=password %>"/>	
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
<%
	session.setAttribute("sessionId", id);
%>
	<c:redirect url="resultMember.jsp?msg=2"></c:redirect>

</c:forEach>
<c:redirect url="loginMember.jsp?error=1"></c:redirect>