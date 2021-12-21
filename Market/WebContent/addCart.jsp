<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품주문</title>
</head>
<body>
	<%	
		String id = request.getParameter("id");
	
		//상품 id가 넘어오지 않을때
		if(id == null || id.trim().equals("")){
			response.sendRedirect("products.jsp");
			return;			
		}
		
		//상품 데이터 접근 클래스의 인스턴스를 받아옴
		ProductRepository dao = ProductRepository.getInstance();
		
		//해당 id값을 이용해 상품상세정보를 얻어옴
		Product product=dao.getProductById(id);
		//해당 상품이 없을 떄
		if(product==null){
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		//모든 상품을 가져오는 코드
		ArrayList<Product> goodList= dao.getAllProducts();
		Product goods = new Product();
		
		//상품리스트 중에서 사용자가 주문을 한 상품을 찾음
		for(int i=0; i<goodList.size(); i++){
			goods = goodList.get(i);
			if(goods.getProductId().equals(id)){
				break;
			}
		}
		//세션 속성의 이름이 cartlist인 세션 정보(장바구니 리스트)를 가져옴
		ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
		//cartlist값이 null이라면 새로운 ArrayList만들고 세션에다가 cartlist이름으로 list라는 값을 대입하고 있다
		if(list == null){
			list = new ArrayList<Product>();
			session.setAttribute("cartlist", list);
		}
		int cnt = 0;
		Product goodsQnt = new Product();
		
		//사용자가 주문한 상품이 장바구니에 이미 담긴 물품인지 검색해서 있다면 수량을 증가시킴
		for(int i=0; i<list.size(); i++){
			goodsQnt = list.get(i);
			if(goodsQnt.getProductId().equals(id)){
				cnt++;
				int orderQuantity = goodsQnt.getQuantity()+1;
				goodsQnt.setQuantity(orderQuantity);
			}
		}
		
		if(cnt==0){
			goods.setQuantity(1);
			list.add(goods);
		}
		
		response.sendRedirect("product.jsp?id="+id);
		
		
	%>

</body>
</html>