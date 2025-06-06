<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 자동 로그인, 토큰 쿠키 삭제
	
    // 세션 초기화 (로그아웃 처리)
    session.invalidate();

    // 홈 또는 로그인 페이지로 리다이렉트
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>