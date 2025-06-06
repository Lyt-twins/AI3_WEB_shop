<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
<%
	String root = request.getContextPath();
	String msg = request.getParameter("msg");
	String message = "";

	if ("0".equals(msg)) {
		message = "로그인 되었습니다.";
	} else if ("1".equals(msg)) {
		message = "회원 가입이 완료되었습니다.";
	} else if ("2".equals(msg)) {
		message = "회원 정보가 수정되었습니다.";
	} else if ("3".equals(msg)) {
		message = "회원 탈퇴가 완료되었습니다.";
	} else {
		message = "처리 결과를 알 수 없습니다.";
	}
%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5 text-center">
	<p class="fs-4"><%= message %></p>
	<a href="<%= root %>/index.jsp" class="btn btn-success mt-4">메인으로</a>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>







