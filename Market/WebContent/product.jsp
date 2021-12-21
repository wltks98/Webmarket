<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="exceptionNoProductId.jsp"%> <!-- id값이 유효하지 않으면 에러페이지로 이동 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");		
	DecimalFormat dfFormat = new DecimalFormat("###,###");
%>
<html>
<head>
<link rel="stylesheet" href="./resource/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<script>
	function addToCart(){
		//confirm함수는 사용자의 선택을 할 때 사용
		if(confirm("해당 상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();		
		}
		else{
			document.addForm.reset();		
		}
		
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">상품 정보</h1>
	</div>
</div>
<%@ include file="dbconn.jsp" %>	
	<%
		//어떤 제품을 편집할지 id값이 넘어오는 것을 받음
		String productId = request.getParameter("id");
	
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		String sql="select * from product where p_id=?";
		pstmt = conn.prepareStatement(sql); //Connection객체로 부터 쿼리를 주고 PreparedStatement객체를 얻음
		pstmt.setString(1,productId);

		rs=pstmt.executeQuery();
		
		if(rs.next()){

	%>

	<div class="container">
		<div class="row">
		<!-- 이미지 추가 -->
		<div class="col-md-5">
			<img src="${pageContext.request.contextPath}/resource/image/<%=rs.getString("p_fileName") %>"
				style="width:100%">
		
		</div>
		<div class="col-md-6">		
			
			<h3><%=rs.getString("p_name") %></h3>
			<p><%=rs.getString("p_description")%></p>
			<p><b>상품코드 : </b><span class="btn btn-danger"><%=rs.getString("p_id")%></span></p>
			<p><b>제조사 : </b><%=rs.getString("p_manufacturer")%></p>
			<p><b>분류 : </b><%=rs.getString("p_category")%></p>
			<p><b>재고 수량 : </b><%=dfFormat.format(Long.parseLong(rs.getString("p_unitsInStock")))%></p>
			<h4><%=dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice")))%>원</h4>
			
			<p><form name="addForm" action="./addCart.jsp?id=<%=rs.getString("p_id")%>" method="post">
			
			<!-- 상품 주문을 클릭하면 자바스크립의 핸들러 함수 addToCart()가 호출되도록 만듦 -->
			<a href="#" class="btn btn-info" onclick="addToCart()">상품 주문&raquo;</a>
			<!-- 장바구니 버튼을 추가, 클릭하면 cart.jsp로 이동 -->
			<a href="./cart.jsp" class="btn btn-warning">장바구니&raquo;</a>
			<a href="./products.jsp" class="btn btn-secondary">상품 목록&raquo;</a>
			</form>
		</div>
		<%
			}
		if(rs!=null) rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
		%>
		
		
		
		</div>
		<hr>
	</div>
	
	
	<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>