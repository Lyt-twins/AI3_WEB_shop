<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   	<%
    String root = request.getContextPath();

    // 상품 객체를 request에서 가져옴
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(root + "/shop/products.jsp");
        return;
    }
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

	<div class="mt-5 mb-5 px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
		<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		<div class="d-grid gap-2 d-md-flex justify-content-sm-center">
			<a href="<%= request.getContextPath() %>/shop/products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
		</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
			<img src="<%= request.getContextPath() %>/static/img/JAVA.jpg" class="w-100 p-2">
			</div>
			<div class="col-md-6">
				<h3 class="mb-5">null</h3>
				<table class="table table-bordered align-middle">
				<colgroup>
				<col width="120px">
				<col>
				</colgroup>
					<tbody>
                    <tr><td>상품ID :</td><td><%= product.getProductId() %></td></tr>
                    <tr><td>제조사 :</td><td><%= product.getManufacturer() %></td></tr>
                    <tr><td>분류 :</td><td><%= product.getCategory() %></td></tr>
                    <tr><td>상태 :</td><td><%= product.getCondition() %></td></tr>
                    <tr><td>재고 수 :</td><td><%= product.getUnitsInStock() %></td></tr>
                    <tr><td>가격 :</td><td>$<%= product.getUnitPrice() %></td></tr>
					</tbody>
				</table>
				<div class="mt-4">
				<form name="addForm" action="./addCart.jsp" method="post">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    <input type="hidden" name="quantity" value="1"><!-- 기본 수량 1개 -->
				<div class="btn-box d-flex justify-content-end">
				<a href="./cart.jsp" class="btn btn-lg btn-warning mx-3">장바구니</a>
				<a href="javascript:;" class="btn btn-lg btn-success mx-3" onclick="addToCart()">주문하기</a>
				</div>
				</form>
				</div>
			</div>
		</div>
	</div>	

	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>