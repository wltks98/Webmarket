<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/css/bootstrap.min.css">
<title>로그인</title>
</head>
<body>
	<jsp:include page="/menu.jsp"></jsp:include>

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
	<%! int cnt=0; %>
	
	<div class="container" align="center">
		<div class="col-md-5 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%					
				//로그인 인증에서 실패했을 경우
				String error = request.getParameter("error");
				if(error!=null){
					if(cnt==3){
					out.println("<div class='alert alert-danger'>");
					out.println("존재하는 아이디가 없습니다 회원가입을 해주세요");
					out.println("</div>");
					}
					else{
						out.println("<div class='alert alert-danger'>");
						out.println("아이디와 비밀번호를 확인해주세요");
						out.println("</div>");
					}
				}
				cnt++;
			%>
			<form class="form-signin" action="processLoginMember.jsp">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> <!-- for="inputUserName"은 웹접근성에 좋다 -->
					<input type="text" class="form-control" placeholder="아이디" name="id" required autofocus>					
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <!-- for="inputUserName"은 웹접근성에 좋다 -->
					<input type="password" class="form-control" placeholder="비밀번호" name="password" required >					
				</div>
				<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
			
			</form>
			
			</div>
		</div>
			
			

</body>
</html>