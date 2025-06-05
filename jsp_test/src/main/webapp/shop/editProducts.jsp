<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		<div class="mt-5 px-4 py-5 my-5 text-center">
			<h1 class="display-5 fw-bold text-body-emphasis">상품편집</h1>
			<p class="lead mb-4">쇼핑몰 상품 목록입니다.</p>
		<div class="m-2">
			<a href="<%= request.getContextPath() %>/shop/add.jsp" class="btn btn-primary btn-lg">상품등록</a>
			<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-success btn-lg gap-3">상품목록</a>
		</div>
		</div>	
	<div class="container mb-5 mt-5">
		<div class="row gy-4">
		<div class="col-md-6 col-xl-4 col-xxl-3">
		<div class="card" style="width: 100%">
  		<img src="<%= request.getContextPath() %>/static/img/JAVA.jpg" class="card-img-top w-100 p-2" alt="java">
  		<div class="card-body">
		    <h5 class="card-title">자바 프로그래밍</h5>
		    <p class="card-text">안녕하세요 자바 프로그래밍 강의입니다.</p>
		    <p class="text-end price">$20000</p>
		    <div class="d-flex justify-content-end">
		   	 <a href="./update.jsp?id=P100001" class="btn btn-secondary mx-2">수정</a>
		     <a href="javascript:;" class="btn btn-danger mx-2" onclick="deleteProduct('P100001')">삭제</a>
		    </div>
  		</div>
		</div>
		</div>
		<div class="col-md-6 col-xl-4 col-xxl-3">
			<div class="card" style="width: 100%">
  			<img src="<%= request.getContextPath() %>/static/img/DB.jpg" class="card-img-top w-100 p-2" alt="oracle">
		<div class="card-body">
		    <h5 class="card-title">오라클 데이터베이스</h5>
		    <p class="card-text">오라클 데이터베이스 입니다.</p>
		    <p class="text-end price">$10000</p>
 		    <div class="d-flex justify-content-end">
		   	 <a href="./update.jsp?id=P100001" class="btn btn-secondary mx-2">수정</a>
		     <a href="javascript:;" class="btn btn-danger mx-2" onclick="deleteProduct('P100001')">삭제</a>
		    </div>
  		</div>
			</div>
		</div>
		<div class="col-md-6 col-xl-4 col-xxl-3">
		<div class="card" style="width: 100%">
  		<img src="<%= request.getContextPath() %>/static/img/WEB.jpg" class="card-img-top w-100 p-2" alt="web">
  		<div class="card-body">
		    <h5 class="card-title">HTML CSS JAVASCRIPT</h5>
		    <p class="card-text">웹 기초 강의입니다.</p>
		    <p class="text-end price">$15000</p>
		    <div class="d-flex justify-content-end">
		   	 <a href="./update.jsp?id=P100001" class="btn btn-secondary mx-2">수정</a>
		     <a href="javascript:;" class="btn btn-danger mx-2" onclick="deleteProduct('P100001')">삭제</a>
		    </div>
  		</div>
		</div>
		</div>
		<div class="col-md-6 col-xl-4 col-xxl-3">
		<div class="card" style="width: 100%">
  		<img src="<%= request.getContextPath() %>/static/img/JSP.jpg" class="card-img-top w-100 p-2" alt="jsp">
  			<div class="card-body">
		    <h5 class="card-title">JSP1111</h5>
		    <p class="card-text">JSP강의 입니다.</p>
		    <p class="text-end price">$10000</p>
		    <div class="d-flex justify-content-end">
		   	 <a href="./update.jsp?id=P100001" class="btn btn-secondary mx-2">수정</a>
		     <a href="javascript:;" class="btn btn-danger mx-2" onclick="deleteProduct('P100001')">삭제</a>
		    </div>
  			</div>
		</div>
		</div>
		</div>	
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>