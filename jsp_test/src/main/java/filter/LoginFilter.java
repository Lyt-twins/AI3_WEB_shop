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
import shop.dao.UserRepository;
import shop.dto.User;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/*")
public class LoginFilter extends HttpFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loginId") == null) {
            String rememberMe = null;
            String token = null;

            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("rememberMe".equals(c.getName())) rememberMe = c.getValue();
                    if ("token".equals(c.getName())) token = c.getValue();
                }
            }

            if ("on".equals(rememberMe) && token != null) {
                try (Connection conn = DBUtil.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT user_id FROM persistent_logins WHERE token = ?")) {
                    
                    stmt.setString(1, token);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String loginId = rs.getString("user_id");

                        UserRepository userRepo = new UserRepository();
                        User loginUser = userRepo.getUserById(loginId);

                        session = request.getSession(true);
                        session.setAttribute("loginId", loginId);
                        session.setAttribute("loginUser", loginUser);
                    }

                    rs.close();
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
