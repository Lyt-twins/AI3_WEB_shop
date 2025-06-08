<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String productId = request.getParameter("productId");
String root = request.getContextPath();

if (productId == null || productId.isEmpty()) {
    response.sendRedirect(root + "/shop/products.jsp?error=no_id");
    return;
}

ProductRepository repo = new ProductRepository();
Product product = repo.getProductById(productId);

if (product == null) {
    response.sendRedirect(root + "/shop/products.jsp?error=not_found");
    return;
}

// 장바구니 가져오기 (없으면 새로 생성)
List<Product> cart = (List<Product>) session.getAttribute("cart");
if (cart == null) {
    cart = new ArrayList<>();
}

// 중복 검사 및 수량 증가
boolean found = false;
for (Product p : cart) {
    if (p.getProductId().equals(productId)) {
        p.setQuantity(p.getQuantity() + 1); // 수량 증가
        found = true;
        break;
    }
}

if (!found) {
    product.setQuantity(1); // 수량 1로 설정 후 추가
    cart.add(product);
}

session.setAttribute("cart", cart);

// 상품 상세 페이지가 아닌 장바구니로 이동
response.sendRedirect(root + "/shop/cart.jsp");
%>