<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
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
	String userId = request.getParameter("userId");
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("orderPw");
	
	// 세션에서 장바구니 가져오기
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	
	// 주문 처리 DAO
	OrderRepository orderRepo = new OrderRepository();
	ProductRepository productRepo = new ProductRepository();
	ProductIORepository ioRepo = new ProductIORepository();
	
	int orderNo = orderRepo.lastOrderNo() + 1;
	
    // 배송 정보는 이전 페이지에서 세션 또는 파라미터로 전달되었다고 가정
    Order order = new Order();
    order.setOrderNo(orderNo);

    // 공통 배송 정보
    order.setShipName(request.getParameter("shipName"));
    order.setZipCode(request.getParameter("zipCode"));
    order.setCountry(request.getParameter("country"));
    order.setAddress(request.getParameter("address"));
    order.setDate(request.getParameter("date"));
    order.setTotalPrice((int) session.getAttribute("total")); // 총금액 세션에서
	
	if (userId != null && !userId.isEmpty()) {
	    order.setUserId(userId);
	} else {
	    order.setPhone(phone);
	    order.setOrderPw(orderPw);
	}
	
	orderRepo.insert(order);  // 주문 저장
	
	// 상품 처리
	for (Product p : cartList) {
	    ProductIo io = new ProductIo();
	    io.setProductId(p.getProductId());
	    io.setOrderNo(orderNo);
	    io.setAmount(p.getQuantity()); // Product 클래스에 getQuantity() 있어야 함
	    io.setType("OUT");
	    io.setUserId(userId != null ? userId : phone);
	    ioRepo.insert(io);
	
	    productRepo.decreaseStock(p.getProductId(), p.getQuantity());
	}
	
	// 장바구니 비우기
    session.removeAttribute("cartList");
    session.removeAttribute("total");
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
                    <td><%= order.getAddress() != null ? order.getAddress() : "입력된 주소 없음" %></td>
                </tr>
            </table>
            <div class="mt-4 d-flex justify-content-center">
                <a href="<%= root %>/user/order.jsp" class="btn btn-lg btn-primary">주문내역</a>
            </div>
        </div>
    </div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>