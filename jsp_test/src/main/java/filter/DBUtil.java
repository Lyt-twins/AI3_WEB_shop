package filter;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/shopdb?serverTimezone=UTC";
    private static final String USER = "root";         // 사용자명
    private static final String PASSWORD = "123456";   // 비밀번호

    public static Connection getConnection() throws Exception {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}