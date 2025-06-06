<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
    request.setCharacterEncoding("UTF-8");
    String root = request.getContextPath();

    // 세션에서 로그인 사용자 정보 확인
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(root + "/user/login.jsp");
        return;
    }

    String userId = loginUser.getId();

    // DB에서 회원 삭제
    UserRepository userRepo = new UserRepository();
    int result = userRepo.delete(userId);

    if (result > 0) {
        // 자동 로그인 토큰도 함께 삭제
        userRepo.deleteToken(userId);

        // 세션 종료
        session.invalidate();

        // 쿠키도 삭제 (자동 로그인 쿠키가 존재하는 경우)
       	Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberMe".equals(cookie.getName()) || "token".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // 쿠키 제거
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }

        // 완료 페이지로 이동
        response.sendRedirect(root + "/user/complete.jsp?msg=3");
    } else {
        response.sendRedirect(root + "/user/mypage.jsp?error=delete");
    }
%>