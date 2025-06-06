<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String root = request.getContextPath();
    ProductRepository repo = new ProductRepository();
    List<Product> productList = repo.list(); // DB에서 모든 상품 조회
	%>
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
	    <% for (Product product : productList) { %>
	    <div class="col-md-6 col-xl-4 col-xxl-3">
	      <div class="card" style="width: 100%">
	        <img src="<%= request.getContextPath() %>/static/img/<%= product.getFile() %>" class="card-img-top w-100 p-2" alt="<%= product.getName() %>">
	        <div class="card-body">
	         	 <h5 class="card-title"><%= product.getName() %></h5>
	          	<p class="card-text"><%= product.getDescription() %></p>
	         	 <p class="text-end price">$<%= product.getUnitPrice() %></p>
	         	 <div class="d-flex justify-content-end">
	            <a href="<%= root %>/shop/update.jsp?id=<%= product.getProductId() %>" class="btn btn-secondary mx-2">수정</a>
	            <a href="javascript:;" class="btn btn-danger mx-2" onclick="deleteProduct('<%= product.getProductId() %>')">삭제</a>
	          	</div>
	        </div>
	      </div>
	    </div>
	    <% } %>
		
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<script>
	function deleteProduct(id) {
    if (confirm('정말 삭제하시겠습니까?')) {
        location.href = '<%= root %>/shop/delete_pro.jsp?id=' + encodeURIComponent(id);
    	}
	}
</script>
</body>
</html>