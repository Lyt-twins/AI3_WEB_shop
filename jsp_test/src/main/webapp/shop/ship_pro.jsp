<%-- <%@ include file="/layout/jstl.jsp" %> --%>
<%-- <%@ include file="/layout/common.jsp" %> --%>
<%@page import="shop.dto.Ship"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String root = request.getContextPath();

    // 파라미터 수집
    String shipName = request.getParameter("shipName");
    String date = request.getParameter("date");
    String country = request.getParameter("country");
    String zipCode = request.getParameter("zipCode");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    // 유효성 검사
    if (shipName == null || date == null || country == null || zipCode == null || address == null || phone == null
        || shipName.isEmpty() || date.isEmpty() || country.isEmpty() || zipCode.isEmpty() || address.isEmpty() || phone.isEmpty()) {
        response.sendRedirect(root + "/shop/ship.jsp?error=empty");
        return;
    }

    // Ship 객체 생성 및 저장
    Ship ship = new Ship();
    ship.setShipName(shipName);
    ship.setDate(date);
    ship.setCountry(country);
    ship.setZipCode(zipCode);
    ship.setAddress(address);
    ship.setPhone(phone);

    session.setAttribute("ship", ship);  // 세션에 저장

    // 주문 확인 페이지로 이동
    response.sendRedirect(root + "/shop/order.jsp");
%>