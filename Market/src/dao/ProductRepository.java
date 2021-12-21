package dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Product;

public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<>();	
	//�ν��Ͻ��� �ϳ��� �����ϰԲ� �̱��� ������ �̿�
	private static ProductRepository instance = new ProductRepository();
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static String url = "jdbc:mysql://localhost:3306/webmarketdb?serverTimezone=UTC";
	private static String user="root";
	private static String password="wl0328";
	
	
	//�ν��Ͻ��� �����ϴ� getter�޼ҵ�
	public static ProductRepository getInstance() {
		return instance;
	}
	
	
	public ProductRepository() {
		
		
	}
	
	public ArrayList<Product> getAllProducts(){
		
		String sql="select * from product";
		
		try {
			conn=getConnection(); //Ŀ�ؼ� ���
			pstmt=conn.prepareStatement(sql);
			rs= pstmt.executeQuery(); //DB�� ����Ǿ� �ִ� ��ǰ ��� �����ͼ� ResultSet�� ��� �ִ�
			
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
				System.out.println("DB���� ����");
			} catch (Exception e2) { 
				e2.printStackTrace();
			}
		}
		
		return listOfProducts;
		
	}
	
	

	//listOfProducts�� ����� ����� ��ȸ�� �ؼ� ��ǰ���̵��ϰ� ��ġ�ϴ� ��ǰ�� �������ִ� �޼ҵ�
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
			//�Ѿ�� productId���� �ִٸ�
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
				System.out.println("DB���� ����");
			} catch (Exception e2) { 
				e2.printStackTrace();
			}			
		}				
		
		return productById;
	}
	
	//��ǰ�� �߰��ϴ� ������ �ϴ� �޼���
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	//Connection��ü�� �����ϴ� �޼���(DB����)
	public Connection getConnection() {
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver"); //����̹���
			conn = DriverManager.getConnection(url,user,password); //db���� ��ü�� ��� �ִ�
			System.out.println("DB���� �Ϸ�");
		} catch (Exception e) {
			System.out.println("DB���� ����");
			System.out.println("DB���� ���� :");
			e.printStackTrace();
		}
		
		return conn;
	}

}
