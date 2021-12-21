function CheckAddProduct(){
	
	var productId = document.getElementNyId("productId");
	var pname = document.getElementNyId("pname");
	var unitPrice= document.getElementNyId("unitPrice");
	var unitsInStock = document.getElementNyId("unitsInStock");
	
	
	
	
	if(!check(/^P[0-9]{4,11}$/,productId,"[상품코드]\nP와 숫자를 조합하여 5에서 12자까지 입력하세요\n")){
		
		return false;
	}
	
	
	
	
	
	//정규표현식(regExp), 유효성 검사를 하는 부분(e), 오류가 발생하면 알려줄 메세지(msg)
	function check(regExp, e, msg){
		if(regExp.test(e.value)){
			return true;
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
	
}