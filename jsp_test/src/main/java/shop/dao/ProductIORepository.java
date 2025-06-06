package shop.dao;

import java.sql.SQLException;

import shop.dto.Product;
import shop.dto.ProductIo;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
	    int result = 0;

	    try {
	        String sql = """
	            INSERT INTO product_io (
	                product_id, order_no, amount, type, user_id
	            ) VALUES (?, ?, ?, ?, ?)
	        """;

	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, product.getProductId());   // 상품 ID
	        psmt.setInt(2, product.getOrderNo());        // 주문 번호
	        psmt.setInt(3, product.getQuantity());       // 출고 수량
	        psmt.setString(4, product.getType());        // 출고 타입 (예: "OUT")
	        psmt.setString(5, product.getUserId());      // 사용자 ID (회원/비회원)

	        result = psmt.executeUpdate();

	    } catch (SQLException e) {
	        System.err.println(">>> 상품 입출고 등록 실패");
	        e.printStackTrace();
	    }

	    return result;
	}
	
    public int insert(ProductIo io) {
        int result = 0;
        String sql = """
            INSERT INTO product_io (product_id, order_no, amount, type, user_id)
            VALUES (?, ?, ?, ?, ?)
        """;

        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, io.getProductId());
            psmt.setInt(2, io.getOrderNo());
            psmt.setInt(3, io.getAmount());
            psmt.setString(4, io.getType());
            psmt.setString(5, io.getUserId());

            result = psmt.executeUpdate();
        } catch (Exception e) {
            System.err.println(">>> 상품 입출고 등록 실패");
            e.printStackTrace();
        }

        return result;
    }
}
		
	
	
	

