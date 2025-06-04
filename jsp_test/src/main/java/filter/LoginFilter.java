package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {
	 @Override
	    public void init(FilterConfig filterConfig) throws ServletException {}

	    @Override
	    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
	            throws IOException, ServletException {
	        HttpServletRequest request = (HttpServletRequest) req;
	        HttpServletResponse response = (HttpServletResponse) res;

	        HttpSession session = request.getSession(false);
	        if (session != null && session.getAttribute("loginId") == null) {
	            String rememberMe = null;
	            String token = null;

	            Cookie[] cookies = request.getCookies();
	            if (cookies != null) {
	                for (Cookie c : cookies) {
	                    if ("rememberMe".equals(c.getName())) rememberMe = c.getValue();
	                    if ("token".equals(c.getName())) token = c.getValue();
	                }
	            }

	            if (rememberMe != null && token != null) {
	                try (Connection conn = DBUtil.getConnection(); // DB 연결 유틸 사용
	                     PreparedStatement stmt = conn.prepareStatement(
	                             "SELECT login_id FROM persistent_logins WHERE token = ?")) {
	                    stmt.setString(1, token);
	                    ResultSet rs = stmt.executeQuery();
	                    if (rs.next()) {
	                        String loginId = rs.getString("login_id");
	                        session = request.getSession(true);
	                        session.setAttribute("loginId", loginId);
	                    }
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        }

	        chain.doFilter(request, response);
	    }

	    @Override
	    public void destroy() {}
	
}
