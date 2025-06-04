<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>jsp-shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
	<div class="mt-5 px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품목록</h1>
		<p class="lead mb-4">쇼핑몰 상품 목록입니다.</p>
		<div class="m-2">
			<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-primary btn-lg">상품등록</a>
			<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-success btn-lg">상품편집</a>
			<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-warning btn-lg">장바구니</a>
		</div>
		<div class="d-flex justify-content-center mt-4">
		<div class="card" style="width: 18rem;">
  		<img src="static/img/JAVA.jpg" class="card-img-top" alt="java">
  		<div class="card-body">
		    <h5 class="card-title">자바 프로그래밍</h5>
		    <p class="card-text">안녕하세요 자바 프로그래밍 강의입니다.</p>
		    <div class="d-flex justify-content-between">
		   	 <a href="#" class="btn btn-outline-info"><i class="bi bi-bag"></i></a>
		     <a href="#" class="btn btn-outline-info">상세정보</a>
		    </div>
  		</div>
		</div>
				<div class="card" style="width: 18rem;">
  		<img src="/static/img/JAVA.jpg" class="card-img-top" alt="oracle">
  		<div class="card-body">
		    <h5 class="card-title">오라클 데이터베이스</h5>
		    <p class="card-text">오라클 데이터베이스 입니다.</p>
		    <div class="d-flex justify-content-between">
		   	 <a href="#" class="btn btn-outline-info"><i class="bi bi-bag"></i></a>
		     <a href="#" class="btn btn-outline-info">상세정보</a>
		    </div>
  		</div>
		</div>
				<div class="card" style="width: 18rem;">
  		<img src="/static/img/JAVA.jpg" class="card-img-top" alt="web">
  		<div class="card-body">
		    <h5 class="card-title">HTML CSS JAVASCRIPT</h5>
		    <p class="card-text">웹 기초 강의입니다.</p>
		    <div class="d-flex justify-content-between">
		   	 <a href="#" class="btn btn-outline-info"><i class="bi bi-bag"></i></a>
		     <a href="#" class="btn btn-outline-info">상세정보</a>
		    </div>
  		</div>
		</div>
				<div class="card" style="width: 18rem;">
  		<img src="/static/img/JAVA.jpg" class="card-img-top" alt="jsp">
  		<div class="card-body">
		    <h5 class="card-title">JSP1111</h5>
		    <p class="card-text">JSP강의 입니다.</p>
		    <div class="d-flex justify-content-between">
		   	 <a href="#" class="btn btn-outline-info"><i class="bi bi-bag"></i></a>
		     <a href="#" class="btn btn-outline-info">상세정보</a>
		    </div>
  		</div>
		</div>
		</div>	
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>