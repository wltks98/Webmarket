package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFileFilter implements Filter {

	PrintWriter writer=null;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		System.out.println("초기화");
		String filename=filterConfig.getInitParameter("filename");
		
		if(filename==null) {
			throw new ServletException("로그 파일의 이름을 찾을 수 없습니다");

		}
		try {
			writer=new PrintWriter(new FileWriter(filename,true),true);
			
		}
	
		catch(IOException e){
			e.printStackTrace();
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String clientAddr=request.getRemoteAddr();
		writer.println("접속한 클라이언트 IP : "+clientAddr);
		writer.println("접근한 URL경로 : "+this.getURLPath(request));
		long start = System.currentTimeMillis();
		writer.println("요청 처리 시작 시간 : " + this.getCurrentTime());
		chain.doFilter(request, response);
		long end = System.currentTimeMillis();
		writer.println("요청 처리 종료 시간 : " + this.getCurrentTime());
		writer.println("요청 처리 소요 시간 : " + (end-start)+"ms");
		writer.println("---------------------------------------");
		
		
	
	}

	@Override
	public void destroy() {
		System.out.println("필터해제");
		writer.close();
	}
	
	public String getURLPath(ServletRequest request) {
		
		HttpServletRequest  hRequest = null;
		String currentPath="";
		String queryString="";
		
		if(request instanceof HttpServletRequest) {
			hRequest=(HttpServletRequest)request; //다운 캐스팅
			currentPath=hRequest.getRequestURI();
			//아래 코드는 get, post이냐에 따라서 결과가 달라질 것이다
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
