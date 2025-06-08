<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String root = request.getContextPath();

    // 상품 ID 받기
    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    // Product 객체 생성
    Product newProduct = new Product();
    newProduct.setProductId(productId);
    newProduct.setName(name);
    newProduct.setUnitPrice(unitPrice);
    newProduct.setQuantity(quantity);

    // 세션에서 장바구니 가져오기
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    if (cartList == null) {
    	cartList = new ArrayList<>();
    }

    // 기존 상품이 있는지 확인
    boolean isExist = false;
    for (Product p : cartList) {
        if (p.getProductId().equals(productId)) {
            p.setQuantity(p.getQuantity() + quantity); // 수량 추가
            isExist = true;
            break;
        }
    }

    if (!isExist) {
    	cartList.add(newProduct); // 새 상품 추가
    }

    session.setAttribute("cartList", cartList); // 세션 저장

    // 상품 목록으로 이동
    response.sendRedirect(root + "/shop/products.jsp");
%>