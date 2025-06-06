<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@ page import="jakarta.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 1. 인코딩 처리
    request.setCharacterEncoding("UTF-8");

    // 2. 경로 설정
    String root = request.getContextPath();
    String savePath = application.getRealPath("/static/img");

    // 3. 파라미터 수신
    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    String unitPriceStr = request.getParameter("unitPrice");
    String description = request.getParameter("description");
    String manufacturer = request.getParameter("manufacturer");
    String category = request.getParameter("category");
    String unitsInStockStr = request.getParameter("unitsInStock");
    String condition = request.getParameter("condition");

    // 4. 필수값 검증
    if (productId == null || name == null || unitPriceStr == null || unitsInStockStr == null || condition == null ||
        productId.isEmpty() || name.isEmpty() || unitPriceStr.isEmpty() || unitsInStockStr.isEmpty() || condition.isEmpty()) {
        response.sendRedirect("add.jsp?error=empty_field");
        return;
    }

    // 5. 숫자 파싱
    int unitPrice = 0;
    long unitsInStock = 0;
    try {
        unitPrice = Integer.parseInt(unitPriceStr);
        unitsInStock = Long.parseLong(unitsInStockStr);
    } catch (Exception e) {
        response.sendRedirect("add.jsp?error=invalid_number");
        return;
    }

    // 6. 파일 처리
    String fileName = "";
    try {
        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();

            File dir = new File(savePath);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(savePath + File.separator + fileName);
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("add.jsp?error=file_upload");
        return;
    }

    // 7. 상품 객체 생성
    Product product = new Product();
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    product.setFile(fileName);
    product.setQuantity(0); // 장바구니용 초기 수량

    // 8. DB 저장
    ProductRepository repo = new ProductRepository();
    int result = repo.insert(product);

    // 9. 결과 처리
    if (result == 1) {
        response.sendRedirect("products.jsp");
    } else {
        response.sendRedirect("add.jsp?error=insert_failed");
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
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>