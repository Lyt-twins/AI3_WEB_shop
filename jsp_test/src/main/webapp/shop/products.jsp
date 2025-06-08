<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String root = request.getContextPath();
    String keyword = request.getParameter("keyword");

    // DB에서 상품 목록 가져오기
	ProductRepository repo = new ProductRepository();
	List<Product> productList = (keyword == null || keyword.isEmpty())
    ? repo.list()
    : repo.list(keyword);
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
		<h1 class="display-5 fw-bold text-body-emphasis">상품목록</h1>
		<p class="lead mb-4">쇼핑몰 상품 목록입니다.</p>
		<div class="m-2">
			<a href="<%= request.getContextPath() %>/shop/add.jsp" class="btn btn-primary btn-lg">상품등록</a>
			<a href="<%= request.getContextPath() %>/shop/editProducts.jsp" class="btn btn-success btn-lg">상품편집</a>
			<a href="<%= request.getContextPath() %>/shop/cart.jsp" class="btn btn-warning btn-lg">장바구니</a>
		</div>
	</div>	
	<div class="container mb-5 mt-5">
			<div class="row gy-4">
			<% for (Product p : productList) { %>
			<div class="col-md-6 col-xl-4 col-xxl-3">
				<div class="card" style="width: 100%">
					<img src="<%= root %>/static/img/<%= p.getFile() %>" class="card-img-top w-100 p-2" alt="<%= p.getName() %>">
					<div class="card-body">
						<h5 class="card-title"><%= p.getName() %></h5>
						<p class="card-text"><%= p.getDescription() %></p>
						<p class="text-end price">₩<%= p.getUnitPrice() %></p>
						<div class="d-flex justify-content-between">
							<a href="<%= root %>/shop/addCart.jsp?productId=<%= p.getProductId() %>" class="btn btn-outline-info">
								<i class="bi bi-bag"></i>
							</a>
							<a href="<%= root %>/shop/product.jsp?id=<%= p.getProductId() %>" class="btn btn-outline-info">
								상세정보
							</a>
						</div>
					</div>
				</div>
			</div>
			<% } %>
		</div>

	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>