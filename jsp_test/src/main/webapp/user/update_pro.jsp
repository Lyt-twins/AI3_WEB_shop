<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%
	// [1] 로그인 상태 확인
	User loginUser = (User) session.getAttribute("loginUser");
	if (loginUser == null) {
	    response.sendRedirect("../user/login.jsp?error=login_required");
	    return;
	}
    // [2] 폼에서 전달된 값 받기
    String id = loginUser.getId(); // ID는 세션에서 가져옴
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String birth = request.getParameter("birth");
    String mail = request.getParameter("mail");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    
    // [3] User 객체에 값 설정
    User user = new User();
    user.setId(id);
    user.setPassword(password);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(mail);
    user.setPhone(phone);
    user.setAddress(address);
    
    // [4] DB 업데이트 처리
    int result = userDAO.update(user);

    // [5] 결과 처리
    if (result > 0) {
        // 세션 정보도 갱신
        session.setAttribute("loginUser", user);
        response.sendRedirect("complete.jsp?msg=2"); // 수정 성공
    } else {
        response.sendRedirect("update.jsp?error=update_failed"); // 수정 실패
    }
// 	// 회원 정보 수정 처리

//     int result = userDAO.update(user);
//     if (result >0 ){
//         response.sendRedirect("complete.jsp?msg=2");
//     } else {
//         response.sendRedirect("update.jsp");
//     }

%>
