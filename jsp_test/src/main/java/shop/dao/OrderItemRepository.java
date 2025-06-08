package shop.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import shop.dto.Product;

public class OrderItemRepository extends JDBConnection {
    
    public int insert(int orderNo, Product product) {
        int result = 0;

        String sql = """
            INSERT INTO order_item (order_no, product_id, quantity)
            VALUES (?, ?, ?)
        """;

        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, orderNo);
            psmt.setString(2, product.getProductId());
            psmt.setInt(3, product.getQuantity());
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println(">>> order_item insert 실패");
            e.printStackTrace();
        }

        return result;
    }
}