<!-- 로그인 처리 -->
<%@page import="java.util.Date"%>
<%@page import="shop.dao.PersistentLoginRepository"%>
<%@page import="shop.dto.PersistentLogin"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
    String rememberId = request.getParameter("remember-id");
    String rememberMe = request.getParameter("remember-me");
	
	
    UserRepository userDAO = new UserRepository();
    User loginUser = userDAO.login(id, pw);

    if (loginUser == null) {
        // 로그인 실패 시
        response.sendRedirect("login.jsp?error=0");
        return;
    }

    // 로그인 성공 시
    // 1. 세션에 아이디 저장
    session.setAttribute("loginId", loginUser.getId());
    session.setAttribute("loginUser", loginUser); 
    // 2. 아이디 저장 (쿠키)
    if ("on".equals(rememberId)) {
        Cookie cookie = new Cookie("rememberId", URLEncoder.encode(id, "UTF-8"));
        cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
        response.addCookie(cookie);
    } else {
        Cookie cookie = new Cookie("rememberId", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    // 3. 자동 로그인 처리 (토큰 저장 쿠키)
    if ("on".equals(rememberMe)) {
        String token = userDAO.refreshToken(id);

        // DB에 자동 로그인 정보 저장
        PersistentLoginRepository plRepo = new PersistentLoginRepository();
        PersistentLogin login = new PersistentLogin();
        login.setUserId(id);
        login.setToken(token);
        login.setDate(new Date());
        plRepo.insert(login); // ⬅ DB insert

        // 쿠키 저장
        Cookie tokenCookie = new Cookie("token", token);
        tokenCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
        response.addCookie(tokenCookie);

        Cookie rememberMeCookie = new Cookie("rememberMe", "on");
        rememberMeCookie.setMaxAge(60 * 60 * 24 * 30);
        response.addCookie(rememberMeCookie);
    }
	

	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>





