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
		<%
		String root = request.getContextPath();
		%>
	    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">배송정보</h1>
    	</div>

    <!-- 입력 폼 -->
    <div class="container" style="max-width: 800px;">
        <form action="<%= root %>/shop/ship_pro.jsp" method="post">
            <div class="mb-3">
                <label class="form-label">성명</label>
                <input type="text" class="form-control" name="shipName" required>
            </div>
            <div class="mb-3">
                <label class="form-label">배송일</label>
                <input type="date" class="form-control" name="date" required>
            </div>
            <div class="mb-3">
                <label class="form-label">국가명</label>
                <input type="text" class="form-control" name="country" required>
            </div>
            <div class="mb-3">
                <label class="form-label">우편번호</label>
                <input type="text" class="form-control" name="zipCode" required>
            </div>
            <div class="mb-3">
                <label class="form-label">주소</label>
                <input type="text" class="form-control" name="address" required>
            </div>
            <div class="mb-3">
                <label class="form-label">전화번호</label>
                <input type="text" class="form-control" name="phone" required>
            </div>

            <!-- 버튼 영역 -->
            <div class="d-flex justify-content-between mt-4">
			    <div class="d-flex gap-2">
			        <button type="button" class="btn btn-secondary btn-lg" onclick="history.back()">이전</button>
			        <a href="<%= root %>/" class="btn btn-danger btn-lg">취소</a>
			    </div>
                <input type="submit" class="btn btn-primary btn-lg" value="등록">
            </div>
        </form>
    </div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>