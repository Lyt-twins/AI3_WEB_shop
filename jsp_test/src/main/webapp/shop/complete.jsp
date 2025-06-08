<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dao.OrderItemRepository"%>
<%@page import="shop.dto.ProductIo"%>
<%@page import="java.util.Date"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
	String root = request.getContextPath();
	String userId = (String) session.getAttribute("loginId");
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	// 세션에서 장바구니 정보
	List<Product> cart = (List<Product>) session.getAttribute("cart");
	if (cart == null || cart.isEmpty()) {
	    response.sendRedirect(root + "/shop/cart.jsp?error=empty_cart");
	    return;
	}
	
	// 세션에서 배송 정보
	shop.dto.Ship ship = (shop.dto.Ship) session.getAttribute("ship");
	
	// DAO 객체
	OrderRepository orderRepo = new OrderRepository();
	ProductRepository productRepo = new ProductRepository();
	ProductIORepository ioRepo = new ProductIORepository();
	OrderItemRepository itemRepo = new OrderItemRepository();
	// 주문 번호 생성
	int orderNo = orderRepo.lastOrderNo() + 1;
	
	// 총 금액
	Object totalObj = session.getAttribute("total");
	int total = (totalObj instanceof Integer) ? (Integer) totalObj : 0;
	
	// 주문 정보 저장
	Order order = new Order();
	order.setOrderNo(orderNo);
	order.setShipName(ship.getShipName());
	order.setZipCode(ship.getZipCode());
	order.setCountry(ship.getCountry());
	order.setAddress(ship.getAddress());
	order.setDate(ship.getDate());
	order.setTotalPrice(total);
	
	if (userId != null && !userId.isEmpty()) {
	    order.setUserId(userId);
	} else {
	    order.setPhone(phone);
	    order.setOrderPw(orderPw);
	}
	orderRepo.insert(order);
	
	// 상품별 출고 및 재고 감소 처리
	for (Product p : cart) {
	    ProductIo io = new ProductIo();
	    io.setProductId(p.getProductId());
	    io.setOrderNo(orderNo);
	    io.setAmount(p.getQuantity());
	    io.setType("OUT");
	    io.setUserId((userId != null) ? userId : phone);
	    ioRepo.insert(io);
	    itemRepo.insert(orderNo, p); 
	    productRepo.decreaseStock(p.getProductId(), p.getQuantity());
	}
	
	// 세션 초기화
	session.removeAttribute("cart");
	session.removeAttribute("total");
	session.removeAttribute("ship");
	%>
	
	<!DOCTYPE html>
	<html>
	<head>
	    <title>주문 완료</title>
	    <jsp:include page="/layout/meta.jsp" />
	    <jsp:include page="/layout/link.jsp" />
	</head>
	<body>
	    <jsp:include page="/layout/header.jsp" />
	    <div class="px-4 py-5 my-5 text-center">
	        <h1 class="display-5 fw-bold">주문 완료</h1>
	        <p class="lead mb-4">주문이 성공적으로 처리되었습니다.</p>
	        <div class="container" style="max-width: 600px;">
	            <table class="table table-bordered text-center">
	                <tr>
	                    <th>주문번호</th>
	                    <td><%= orderNo %></td>
	                </tr>
	                <tr>
	                    <th>배송지</th>
	                    <td><%= order.getAddress() %></td>
	                </tr>
	            </table>
	            <div class="mt-4 d-flex justify-content-center">
	                <a href="<%= root %>/user/order.jsp" class="btn btn-lg btn-primary">주문내역</a>
	            </div>
	        </div>
	    </div>
	    <jsp:include page="/layout/footer.jsp" />
	    <jsp:include page="/layout/script.jsp" />
	</body>
	</html>