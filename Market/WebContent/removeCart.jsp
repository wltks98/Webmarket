<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	
	//상품 id가 넘어오지 않을때 강제로 products로 이동
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;			
}
	
	ProductRepository dao=ProductRepository.getInstance();
	
	Product product = dao.getProductById(id);
	
	//해당 상품이 없을 떄
	if(product==null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	ArrayList<Product> cartList =(ArrayList<Product>)session.getAttribute("cartlist");
	
	Product goodQnt = new Product();
	
	for(int i=0; i<cartList.size(); i++){
		goodQnt = cartList.get(i);
		if(goodQnt.getProductId().equals(id)){
			cartList.remove(goodQnt);
		}
	}
	response.sendRedirect("cart.jsp");
%>
</body>
</html>