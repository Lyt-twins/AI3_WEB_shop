<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<%-- [Contents] ######################################################### --%>
	<%
	String root = request.getContextPath();
	String id = request.getParameter("id");
	
	if (id == null || id.isEmpty()) {
	    response.sendRedirect(root + "/shop/products.jsp");
	    return;
	}
	
	ProductRepository repo = new ProductRepository();
	Product product = repo.getProductById(id);
	
	if (product == null) {
	    out.println("<script>alert('해당 상품을 찾을 수 없습니다.'); location.href='" + root + "/shop/products.jsp';</script>");
	    return;
	}
	%>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
	<div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
    <div class="col-lg-6 mx-auto">
        <p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
    </div>
</div>

<div class="container" style="max-width: 850px;">
    <form name="product" action="./update_pro.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="<%= product.getProductId() %>">

        <div class="mb-3 text-center">
            <img src="<%= root %>/static/img/<%= product.getFile() %>" width="200" alt="상품 이미지">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">상품 이미지</label>
            <input type="file" class="form-control col-md-10" name="file">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">상품명</label>
            <input type="text" class="form-control col-md-10" name="name" value="<%= product.getName() %>">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">가격</label>
            <input type="number" class="form-control col-md-10" name="unitPrice" value="<%= product.getUnitPrice() %>">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">상세 정보</label>
            <textarea class="form-control" name="description" style="height: 200px !important;"><%= product.getDescription() %></textarea>
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">제조사</label>
            <input type="text" class="form-control col-md-10" name="manufacturer" value="<%= product.getManufacturer() %>">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">분류</label>
            <input type="text" class="form-control col-md-10" name="category" value="<%= product.getCategory() %>">
        </div>

        <div class="input-group mb-3 row">
            <label class="input-group-text col-md-2">재고 수</label>
            <input type="number" class="form-control col-md-10" name="unitsInStock" value="<%= product.getUnitsInStock() %>">
        </div>

        <div class="input-group mb-3 row">
            <div class="col-md-2 p-0">
                <label class="input-group-text">상태</label>
            </div>
            <div class="col-md-10 d-flex align-items-center">
                <div class="radio-box d-flex">
                    <div class="radio-item mx-5">
                        <input type="radio" class="form-check-input" name="condition" value="NEW" id="condition-new">
                        <label for="condition-new">신규 제품</label>
                    </div>
                    <div class="radio-item mx-5">
                        <input type="radio" class="form-check-input" name="condition" value="OLD" id="condition-old">
                        <label for="condition-old">중고 제품</label>
                    </div>
                    <div class="radio-item mx-5">
                        <input type="radio" class="form-check-input" name="condition" value="RE" id="condition-re">
                        <label for="condition-re">재생 제품</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-between mt-5 mb-5">
            <a href="./products.jsp" class="btn btn-lg btn-secondary">목록</a>
            <input type="submit" class="btn btn-lg btn-primary" value="수정">
        </div>
    </form>
</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>