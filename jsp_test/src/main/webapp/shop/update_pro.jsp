<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String savePath = application.getRealPath("/static/img");

String productId = request.getParameter("productId");
String name = request.getParameter("name");
String unitPriceStr = request.getParameter("unitPrice");
String description = request.getParameter("description");
String manufacturer = request.getParameter("manufacturer");
String category = request.getParameter("category");
String unitsInStockStr = request.getParameter("unitsInStock");
String condition = request.getParameter("condition");

String root = request.getContextPath();

// 필수값 체크
if (productId == null || name == null || unitPriceStr == null || unitsInStockStr == null
    || productId.isEmpty() || name.isEmpty() || unitPriceStr.isEmpty() || unitsInStockStr.isEmpty()) {
    response.sendRedirect("update.jsp?id=" + productId + "&error=empty_field");
    return;
}

int unitPrice = 0;
long unitsInStock = 0;
try {
    unitPrice = Integer.parseInt(unitPriceStr.trim());
    unitsInStock = Long.parseLong(unitsInStockStr.trim());
} catch (NumberFormatException e) {
    response.sendRedirect("update.jsp?id=" + productId + "&error=invalid_number");
    return;
}

// 기존 상품 정보 불러오기
ProductRepository repo = new ProductRepository();
Product product = repo.getProductById(productId);

if (product == null) {
    response.sendRedirect("products.jsp?error=not_found");
    return;
}

// 파일 업로드 처리
String fileName = product.getFile(); // 기존 파일 유지
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
    response.sendRedirect("update.jsp?id=" + productId + "&error=file_upload");
    return;
}

// 수정 정보 저장
product.setName(name);
product.setUnitPrice(unitPrice);
product.setDescription(description);
product.setManufacturer(manufacturer);
product.setCategory(category);
product.setUnitsInStock(unitsInStock);
product.setCondition(condition);
product.setFile(fileName);

int result = repo.update(product);

if (result == 1) {
    response.sendRedirect("products.jsp");
} else {
    response.sendRedirect("update.jsp?id=" + productId + "&error=update_failed");
}
%>