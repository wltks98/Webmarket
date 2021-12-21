package filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter {

	
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		System.out.println("�ʱ�ȭ");
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("������ Ŭ���̾�Ʈ IP : "+request.getRemoteAddr());
		//���������� ���� �׽�Ʈ
		long start = System.currentTimeMillis();
		System.out.println("������ URL��� : " + this.getURLPath(request) );
		System.out.println("��û ó�� ���� �ð� : " + this.getCurrentTime());
		
		chain.doFilter(request, response);
		long end = System.currentTimeMillis();
		System.out.println("��û ó�� ���� �ð� : " + this.getCurrentTime());
		System.out.println("��û ó�� �ҿ� �ð� : " + (end-start)+"ms");
		System.out.println("---------------------------------------");
	
	
	}

	@Override
	public void destroy() {
		System.out.println("��������");
		
	}
	
	public String getURLPath(ServletRequest request) {
		
		HttpServletRequest  hRequest = null;
		String currentPath="";
		String queryString="";
		
		if(request instanceof HttpServletRequest) {
			hRequest=(HttpServletRequest)request; //�ٿ� ĳ����
			currentPath=hRequest.getRequestURI();
			//�Ʒ� �ڵ�� get, post�̳Ŀ� ���� ����� �޶��� ���̴�
			queryString = (queryString==null) ? "":"?"+hRequest.getQueryString();
			
			
			return currentPath+queryString;
		}
				
		
		
		return null;
	}

	public String getCurrentTime() {
		SimpleDateFormat sformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		return sformat.format(new Date());
	}
}
