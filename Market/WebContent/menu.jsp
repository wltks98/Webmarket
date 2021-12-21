<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	//로그인 여부를 판단하기 위해서 아래 코드를 추가함
	String sessionId = (String)session.getAttribute("sessionId");
%>
<nav class="navbar navbar-expand navbar-dark bg-dark"> <!-- 네비게이션 바를 만듬 -->
		<div class="container"> <!-- container라는 클래스부터는 무엇인가 내용을 표시 -->
			<div class="navbar-header"> <!-- 네비게이션 헤드 -->
			<a class="navbar-brand" href="${pageContext.request.contextPath}/welcome.jsp">HOME</a>
			</div>
		<div>
			<ul class="navbar-nav mr-auto"> <!-- mr-auto는 마진을 알아서 잡아줌 -->
				<c:choose>			
					<c:when test="${empty sessionId}">
						<li class="nav-item"><a class="nav-link" 
						href="<c:url value="/members/loginMember.jsp"/>">로그인</a></li>
						<li class="nav-item"><a class="nav-link" 
						href="<c:url value="/members/addMember.jsp"/>">회원가입</a></li>
					</c:when>					
					<c:otherwise>
						<li style="padding-top : 7px; color:white">[<%=sessionId %>님]</li>
						<li class="nav-item"><a class="nav-link" 
						href="<c:url value="/members/logoutMember.jsp"/>">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link" 
						href="<c:url value="/members/addMember.jsp"/>">회원가입</a></li>
						<li class="nav-item"><a class="nav-link" 
						href="<c:url value="/members/updateMember.jsp"/>">정보수정</a></li>
					</c:otherwise>
				</c:choose>
				
				<c:choose>			
					<c:when test="${sessionId ne 'admin'}">
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products.jsp">상품목록</a></li>				
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products.jsp">상품목록</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/addProduct.jsp">상품등록</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/editProduct.jsp?edit=update">상품수정</a></li>			
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/editProduct.jsp?edit=delete">상품삭제</a></li>			
										
					</c:otherwise>					
				</c:choose>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/BoardListAction.do?pageNum=1">게시판</a></li>
				
			
			</ul>
		
		</div>
		
		
		</div>
</nav>