<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!--<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"></jsp:useBean>  -->  
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dfFormat = new DecimalFormat("###,###");
%>
<html>
<head>
<link rel="stylesheet" href="./resource/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품목록</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	



<div class="container">
	<div class="row" align="center">
	<%@ include file="dbconn.jsp" %> <!-- db연동 -->
	<%
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		String sql="select * from product";
		pstmt = conn.prepareStatement(sql); //Connection객체로 부터 쿼리를 주고 PreparedStatement객체를 얻음
		//쿼리문의 결과를 받아오고 있다
		rs=pstmt.executeQuery();
		
		while(rs.next()){
			
		
		%>
	<div class="col-md-4">
		<img  src="${pageContext.request.contextPath}/resource/image/<%=rs.getString("p_fileName") %>"
		style="width:100%">
		
		<h3><%=rs.getString("p_name")%></h3>
		<p><%=rs.getString("p_description") %></p>
		<p><%=dfFormat.format(Integer.parseInt(rs.getString("p_UnitPrice")))%>원</p>
	

		<p><a href="./product.jsp?id=<%=rs.getString("p_id")%>"
		class="btn btn-secondary" role=button>상세정보&raquo;</a></p>
	</div>
	<%
		}
		if(rs!=null)rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
	%>
	
	</div>
	<hr>
</div>


<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>