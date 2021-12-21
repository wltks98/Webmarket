<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%

	request.setCharacterEncoding("UTF-8");
	String filename="";
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
	 System.out.println("update");
	 
	 Enumeration files = multi.getFileNames();
	 String fname = (String)files.nextElement();
	 String fileName = multi.getFilesystemName(fname);
	 
	 PreparedStatement pstmt = null;
	 ResultSet rs=null;
	 
	 String sql="select * from product where p_id=?";
	 pstmt = conn.prepareStatement(sql);
	 pstmt.setString(1,productId);
	 rs=pstmt.executeQuery();
	 
	 if(rs.next()){		 
		 if(fileName != null){
			 sql = "update product set p_name=?,p_unitPrice=?,p_description=?,"+
					 "p_manufacturer=?,p_category=?,p_unitsInStock=?,p_condition=?,p_fileName=? where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pname);
			pstmt.setInt(2,price);
			pstmt.setString(3,description);
			pstmt.setString(4,manufacturer);
			pstmt.setString(5,category);
			pstmt.setLong(6,stock);
			pstmt.setString(7,condition);
			pstmt.setString(8,fileName);
			pstmt.setString(9,productId);
			pstmt.executeUpdate();			
		 }
		 else{
			 sql = "update product set p_name=?,p_unitPrice=?,p_description=?,"+
					 "p_manufacturer=?,p_category=?,p_unitsInStock=?,p_condition=? where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pname);
			pstmt.setInt(2,price);
			pstmt.setString(3,description);
			pstmt.setString(4,manufacturer);
			pstmt.setString(5,category);
			pstmt.setLong(6,stock);
			pstmt.setString(7,condition);
			pstmt.setString(8,productId);
			pstmt.executeUpdate();			
			 
		 }
	 }
	 
	 if(rs != null) rs.close();
	 if(pstmt != null) pstmt.close();
	 if(conn != null) conn.close();
	 
	 response.sendRedirect("editProduct.jsp?edit=update");
	 
%>