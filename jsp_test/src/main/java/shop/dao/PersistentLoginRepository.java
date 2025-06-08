package shop.dao;

import java.sql.Timestamp;

import shop.dto.PersistentLogin;

public class PersistentLoginRepository extends JDBConnection {

    public int insert(PersistentLogin login) {
        int result = 0;
        String sql = "INSERT INTO persistent_logins (user_id, token, date) VALUES (?, ?, ?)";
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, login.getUserId());
            psmt.setString(2, login.getToken());
            psmt.setTimestamp(3, new Timestamp(login.getDate().getTime()));
            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
