<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resource/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/validation.js"></script>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<body>

	<fmt:setLocale value='<%=request.getParameter("language")%>'/>
	<fmt:bundle basename="resourceBundle.message"></fmt:bundle>

	<jsp:include page="menu.jsp"/>
	
	<div class="jumbotron"> <!--점보트론은 대형전광판임  -->
		<div class="container">
		<h1 class="display-3">상품목록</h1>
		<!--<h1 class="display-3"><fmt:message key="title"/></h1>  -->
			
		</div>
	</div>
	
	<div class="container">
		<!-- form-horizontal은 폼요소들이 수평으로 배치가 되도록 해준다 -->
		<form name="newProduct" action="./processAddProduct.jsp" class="form-horizontal"
		 method="post" enctype="multipart/form-data"> 
		 <div class="text-right">
			<a href="logout.jsp" class="btn btn-sm btn-success pull-right"><b>로그아웃</b></a> 
		</div>	
			
			<div class="form-group row">
			<!-- 화면크기가 768px이상일 때 col-sm-? 부분이 적용됨,div요소의 block특성에 의해 100%너비를 가지면 수직으로 쌓이게 만든다 -->
			
				<label class="col-sm-2"><b>상품코드</b></label>
				<div class="col-sm-3">
				<!-- id속성을 추가한 것은 유효성 검사를 위해서 이 document에서 자바스크립트 파일에서 참조하기 위함 -->
					<input type="text" id="productId" name="productId" class="form-control" placeholder="상품코드를 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
			<!-- 화면크기가 768px이상일 때 col-sm-? 부분이 적용됨,div요소의 block특성에 의해 100%너비를 가지면 수직으로 쌓이게 만든다 -->
			
				<label class="col-sm-2"><b>상품명</b></label>
				<div class="col-sm-3">
					<input type="text" id="pname" name="pname" class="form-control" placeholder="상품명을 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
			
			
				<label class="col-sm-2"><b>가격</b></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" placeholder="가격을 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
						
				<label class="col-sm-2"><b>상세정보</b></label>
				<div class="col-sm-5">
					<textarea name="description" cols="500" rows="2" class="form-control" placeholder="상세정보를 입력하세요"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
						
				<label class="col-sm-2"><b>제조사</b></label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control" placeholder="제조사를 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
						
				<label class="col-sm-2"><b>분류</b></label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control" placeholder="분류를 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
						
				<label class="col-sm-2"><b>재고 수량</b></label>
				<div class="col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" placeholder="재소 수량을 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
						
				<label class="col-sm-2"><b>상태</b></label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New" >신규제품	
					<input type="radio" name="condition" value="Old" >중고제품	
					<input type="radio" name="condition" value="Refurbished" >재생제품	
						
				</div>
			</div>
		
		<div class="form-group row">
						
				<label class="col-sm-2"><b>이미지</b></label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control">	
					
				</div>
			</div>
		
		
		
			<div class="form-group row">
								
				<!-- offset지정은 col의 2만큼 띄워라는 뜻 -->						
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value="등록" onclick="CheckAddProduct()">
					
				</div>
			</div>
		
		</form>
	
	</div>

</body>
</html>