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
		</tbody>
		<tfoot>
		<tr>
		<td colspan="5">추가된 상품이 없습니다.</td>
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
</body>
</html>