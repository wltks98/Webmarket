<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<link rel="stylesheet" href="./resource/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				//로그인 인증에서 실패했을 경우
				String error = request.getParameter("error");
				if(error!=null){
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해주세요");
					out.println("</div>");
				}
			%>
			<form class="form-signin" action="j_security_check" method="post">
				<div class="form_group">
				<!-- sr-only클래스는 웹접근성을 위한 코드이며 역할은 label내용을 숨긴다 -->
					<label for="inputUserName" class="sr-only">User Name</label>
					<input type="text" class="form-control" placeholder="ID" name="j_username" 
					required="required" autofocus="autofocus">
				</div>
				<div class="form_group">
					<label for="inputPassword" class="sr-only">Password</label>
					<input type="text" class="form-control" placeholder="Password" name="j_password" 
					required>
				</div>
				<!-- btn-lg는 버튼 크기를 의미 -->
				<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
				
			
			</form>
			
			
		
		</div>
	
	</div>
	
</body>
</html>