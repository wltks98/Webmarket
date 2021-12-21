package dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Product;

public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<>();	
	//인스턴스를 하나만 공유하게끔 싱글통 패턴을 이용
	private static ProductRepository instance = new ProductRepository();
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static String url = "jdbc:mysql://localhost:3306/webmarketdb?serverTimezone=UTC";
	private static String user="root";
	private static String password="wl0328";
	
	
	//인스턴스를 리턴하는 getter메소드
	public static ProductRepository getInstance() {
		return instance;
	}
	
	
	public ProductRepository() {
		
		
	}
	
	public ArrayList<Product> getAllProducts(){
		
		String sql="select * from product";
		
		try {
			conn=getConnection(); //커넥션 얻기
			pstmt=conn.prepareStatement(sql);
			rs= pstmt.executeQuery(); //DB에 저장되어 있는 상품 모두 가져와서 ResultSet에 담고 있다
			
			while(rs.next()) {
				
				Product product = new Product();
											
				product.setProductId(rs.getString("p_id"));
				product.setPname(rs.getString("p_name"));
				product.setUnitPrice(rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setManufacturer(rs.getString("p_manufacturer"));
				product.setCategory(rs.getString("p_category"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFilename(rs.getString("p_filename"));
				
				listOfProducts.add(product);
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try   {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
				System.out.println("DB연동 해제");
			} catch (Exception e2) { 
				e2.printStackTrace();
			}
		}
		
		return listOfProducts;
		
	}
	
	

	//listOfProducts에 저장된 목록을 조회를 해서 상품아이디하고 일치하는 상품을 리턴해주는 메소드
	public Product getProductById(String productId) {
		
		String sql = "select * from product where p_id=?";
		Product productById = new Product();
		
		try {
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs= pstmt.executeQuery();
			
			if(!rs.next()) {
				return null;
			}
			//넘어온 productId값이 있다면
			if(rs.next()) {
				productById.setProductId(rs.getString("p_id"));
				productById.setPname(rs.getString("p_name"));
				productById.setUnitPrice(rs.getInt("p_unitPrice"));
				productById.setDescription(rs.getString("p_description"));
				productById.setManufacturer(rs.getString("p_manufacturer"));
				productById.setCategory(rs.getString("p_category"));
				productById.setUnitsInStock(rs.getLong("p_unitsInStock"));
				productById.setCondition(rs.getString("p_condition"));
				productById.setFilename(rs.getString("p_filename"));
			}
			
		}catch (Exception e) {
			e.getMessage();
		}finally {
			try   {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
				System.out.println("DB연동 해제");
			} catch (Exception e2) { 
				e2.printStackTrace();
			}			
		}				
		
		return productById;
	}
	
	//상품을 추가하는 역할을 하는 메서드
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	//Connection객체를 리턴하는 메서드(DB접속)
	public Connection getConnection() {
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver"); //드라이버명
			conn = DriverManager.getConnection(url,user,password); //db연결 객체를 얻고 있다
			System.out.println("DB연동 완료");
		} catch (Exception e) {
			System.out.println("DB연동 실패");
			System.out.println("DB연동 이유 :");
			e.printStackTrace();
		}
		
		return conn;
	}

}
