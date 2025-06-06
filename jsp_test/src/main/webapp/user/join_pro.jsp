<!-- 
	회원 가입 처리
 -->
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");

	// 폼 데이터 받기
	String id = request.getParameter("id");
	String password = request.getParameter("pw");  // 유저 비밀번호
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "-" + month + "-" + day;
	String mail = request.getParameter("ail1") + "@" + request.getParameter("ail2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");

	// DB 연결 정보
	String url = "jdbc:mysql://localhost:3306/shopdb";
	String dbUser = "root";
	String dbPw = "123456";

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection(url, dbUser, dbPw);  // ✅ 올바른 계정 사용

	    String sql = "INSERT INTO user (id, password, name, gender, birth, mail, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, id);
	    pstmt.setString(2, password); // ✅ 폼에서 받은 비밀번호
	    pstmt.setString(3, name);
	    pstmt.setString(4, gender);
	    pstmt.setString(5, birth);
	    pstmt.setString(6, mail);
	    pstmt.setString(7, phone);
	    pstmt.setString(8, address);

	    int result = pstmt.executeUpdate();

	    if (result > 0) {
%>
			<script>
				alert("회원가입이 완료되었습니다.");
				location.href = "<%= request.getContextPath() %>/index.jsp";
			</script>
<%
	    } else {
%>
			<script>
				alert("회원가입 실패. 다시 시도하세요.");
				history.back();
			</script>
<%
	    }
	} catch (Exception e) {
	    e.printStackTrace();
%>
		<script>
			alert("오류 발생: <%= e.getMessage() %>");
			history.back();
		</script>
<%
	} finally {
	    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
	    try { if (conn != null) conn.close(); } catch (Exception e) {}
	}
%>
    
    

    
    
    
    
    
    