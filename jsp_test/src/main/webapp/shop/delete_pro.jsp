<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String productId = request.getParameter("id");
    String root = request.getContextPath();

    if (productId == null || productId.trim().isEmpty()) {
        // id가 없으면 목록으로 이동
        response.sendRedirect(root + "/shop/products.jsp?error=no_id");
        return;
    }

    ProductRepository repo = new ProductRepository();
    int result = repo.delete(productId);

    if (result == 1) {
        // 삭제 성공
        response.sendRedirect(root + "/shop/products.jsp");
    } else {
        // 삭제 실패
        response.sendRedirect(root + "/shop/products.jsp?error=delete_failed");
    }
%>