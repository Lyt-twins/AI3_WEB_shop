<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Ship"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String root = request.getContextPath();
	Ship ship = (Ship) session.getAttribute("ship");
	String userId = (String) session.getAttribute("userId"); // 로그인 회원의 아이디 (null이면 비회원)
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
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold">주문정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">아래의 주문 정보를 확인 후 주문을 완료해주세요.</p>
		</div>
	</div>

	<div class="container" style="max-width: 850px;">
	<form action="<%= root %>/shop/complete.jsp" method="post">
		<table class="table table-bordered align-middle text-center">
			<tr><th>주문 형태</th><td><%= (userId != null) ? "회원 주문" : "비회원 주문" %></td></tr>
			<tr><th>성명</th><td><%= ship.getShipName() %></td></tr>
			<tr><th>우편번호</th><td><%= ship.getZipCode() %></td></tr>
			<tr><th>주소</th><td><%= ship.getAddress() %></td></tr>
			<tr><th>배송일</th><td><%= ship.getDate() %></td></tr>
			<tr><th>전화번호</th><td><%= ship.getPhone() %></td></tr>
		</table>

		<%-- 비회원 주문 비밀번호 입력 --%>
		<% if (userId == null) { %>
			<div class="mb-3">
				<label class="form-label">주문 비밀번호</label>
				<input type="password" class="form-control" name="orderPw" required>
			</div>
		<% } %>

		<%-- 식별 정보 전달 hidden input --%>
		<% if (userId != null) { %>
			<input type="hidden" name="userId" value="<%= userId %>">
		<% } else { %>
			<input type="hidden" name="phone" value="<%= ship.getPhone() %>">
		<% } %>

		<div class="d-flex justify-content-between mt-5 mb-5">
			<div class="d-flex gap-2">
				<button type="button" class="btn btn-secondary btn-lg" onclick="history.back()">이전</button>
				<a href="<%= root %>/" class="btn btn-danger btn-lg">취소</a>
			</div>
			<input type="submit" class="btn btn-primary btn-lg" value="주문완료">
		</div>
	</form>
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>