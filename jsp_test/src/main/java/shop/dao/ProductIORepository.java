package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

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
            psmt.setString(1, product.getProductId());
            psmt.setInt(2, product.getOrderNo());    
            psmt.setString(3, product.getType());
            psmt.setString(4, product.getUserId());

            result = psmt.executeUpdate();

        } catch (Exception e) {
            System.err.println(">>> 상품 입출고 등록 실패");
            e.printStackTrace();
        }

        return result;
    }
		
	
	}
	

