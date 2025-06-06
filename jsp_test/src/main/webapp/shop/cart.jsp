<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<%
	List<Product> cart = (List<Product>) session.getAttribute("cart");
	if (cart == null) cart = new java.util.ArrayList<>();
	%>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	<div class="container" style="max-width: 850px;">
	<table class="table  table-striped table-hover table-bordered text-center align-middle">
		<thead>
		<tr class="table-success">
			<th>상품</th>
			<th>가격</th>
			<th>수량</th>
			<th>소계</th>
			<th>비고</th>
		</tr>
		</thead>
		<tbody>
		<%
		int total = 0;
		for (Product product : cart) {
		    total += product.getUnitPrice() * product.getQuantity();
		%>
		<tr>
		  <td><%= product.getName() %></td>
		  <td><%= product.getUnitPrice() %></td>
		  <td><%= product.getQuantity() %></td>
		  <td><%= product.getUnitPrice() * product.getQuantity() %></td>
		  <td>
		    <a href="./deleteCart.jsp?productId=<%= product.getProductId() %>" class="btn btn-sm btn-danger">삭제</a>
		  </td>
		</tr>
		<% } %>
		</tbody>
		<tfoot>
        <tr class="table-light fw-bold">
            <td colspan="3">총 합계</td>
            <td colspan="2"><%= total %> 원</td>
        </tr>
		</tfoot>
	</table>
	<div class="d-flex justify-content-between align-items-center p-3">
		<a href="deleteCart.jsp?cartId=88AF33B2AC6076F3D761D5C636CFDF00" class="btn btn-lg btn-danger ">전체삭제</a>
		<a href="javascript:;" class="btn btn-lg btn-secondary" onclick="order()">주문하기</a>
	</div>
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<script>
	function order() {
	    const cartNotEmpty = <%= (cart != null && !cart.isEmpty()) ? "true" : "false" %>;
	
	    if (!cartNotEmpty) {
	        alert("장바구니가 비어 있습니다. 상품을 먼저 담아주세요.");
	        return false;
	    }
	
	    location.href = "<%= request.getContextPath() %>/shop/ship.jsp";
	}
</script>
</body>
</html>