<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	//addProduct.jsp에서 사용자가 업로드한 이미지 부분을 받아서 저장읋 하고 있다
	String filename="";
	//String realFolder="C:\\upload";
	String realFolder="C:/Users/USER/eclipse-EE-workspace/Market/WebContent/resource/image";
	int maxSize = 10*1024*1024;
	String encType="utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder,maxSize,encType, new DefaultFileRenamePolicy());

	 String productId=multi.getParameter("productId");
	 String pname=multi.getParameter("pname");
	 String unitPrice=multi.getParameter("unitPrice");
	 String description=multi.getParameter("description");
	 String manufacturer=multi.getParameter("manufacturer");
	 String category=multi.getParameter("category");
	 String unitsInStock=multi.getParameter("unitsInStock");
	 String condition=multi.getParameter("condition");

	 Integer price;
	 long stock;
	 
	 //단가(unitPrice)입력창에 미 입력시에 가격을 0으로 처리
	 if(unitPrice.isEmpty()){
		 price=0;
	 }
	 
	 else{
		 //String을 숫자로 변환하고 있다
		 price = Integer.valueOf(unitPrice);
	 }
	 
	 if(unitsInStock.isEmpty()){
		 stock=0;
	 }
	 
	 else{
		 
		stock = Long.valueOf(unitsInStock);
	 }
	 
	 Enumeration files = multi.getFileNames();
	 String fname = (String) files.nextElement();
	 String fileName = multi.getFilesystemName(fname);
	 
	 PreparedStatement pstmt = null;
	 String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	 pstmt = conn.prepareStatement(sql);
	 
	 pstmt.setString(1,productId);
	 pstmt.setString(2,pname);
	 pstmt.setInt(3,price);
	 pstmt.setString(4,description);
	 pstmt.setString(5,manufacturer);
	 pstmt.setString(6,category);
	 pstmt.setLong(7,stock);
	 pstmt.setString(8,condition);
	 pstmt.setString(9,fileName);
	 pstmt.executeUpdate();
	 System.out.println("상품 등록 완료");
	 
	 if(pstmt!=null) pstmt.close();
	 if(conn!=null) conn.close();
	 
	 
	
	 
	 //강제로 페이지 이동을 시키고 있다
	 response.sendRedirect("products.jsp");
%>


</body>
</html>