<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String productId = request.getParameter("id");
String root = request.getContextPath();

List<Product> cart = (List<Product>) session.getAttribute("cart");

// cart가 없으면 바로 리다이렉트
if (cart == null) {
    response.sendRedirect(root + "/shop/cart.jsp");
    return;
}

if (productId == null || productId.trim().isEmpty()) {
    // 전체삭제
    session.removeAttribute("cart");
} else {
    // 단일 삭제
    Iterator<Product> iterator = cart.iterator();
    while (iterator.hasNext()) {
        Product item = iterator.next();
        if (productId.equals(item.getProductId())) {
            iterator.remove();
            break;
        }
    }
    session.setAttribute("cart", cart);
}

// 최종 리다이렉트 한 번만 실행
response.sendRedirect(root + "/shop/cart.jsp");
%>