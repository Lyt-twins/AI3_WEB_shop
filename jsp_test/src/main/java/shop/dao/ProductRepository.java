package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * @return
	 */
	public List<Product> list() {
		List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM product";
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getInt("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                product.setQuantity(rs.getInt("quantity"));
                products.add(product);
            }
        } catch (Exception e) {
            System.err.println(">>> 상품 목록 조회 실패");
            e.printStackTrace();
        }
        return products;
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		 List<Product> products = new ArrayList<>();
	        try {
	            String sql = """
	                    SELECT * FROM product
	                    WHERE name LIKE ? OR description LIKE ? OR manufacturer LIKE ? OR category LIKE ?
	                """;
	                psmt = con.prepareStatement(sql);
	                psmt.setString(1, "%" + keyword + "%");
	                psmt.setString(2, "%" + keyword + "%");
	                psmt.setString(3, "%" + keyword + "%");
	                psmt.setString(4, "%" + keyword + "%");

	                rs = psmt.executeQuery();

	            while (rs.next()) {
	                Product product = new Product();
	                product.setProductId(rs.getString("product_id"));
	                product.setName(rs.getString("name"));
	                product.setUnitPrice(rs.getInt("unit_price"));
	                product.setDescription(rs.getString("description"));
	                product.setManufacturer(rs.getString("manufacturer"));
	                product.setCategory(rs.getString("category"));
	                product.setUnitsInStock(rs.getInt("units_in_stock"));
	                product.setCondition(rs.getString("condition"));
	                product.setFile(rs.getString("file"));
	                product.setQuantity(rs.getInt("quantity"));
	                products.add(product);
	            }
	        } catch (Exception e) {
	            System.err.println(">>> 상품 검색 실패");
	            e.printStackTrace();
	        }
	        return products;
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		 Product product = null;
	        try {
	            String sql = "SELECT * FROM product WHERE product_id = ?";
	            psmt = con.prepareStatement(sql);
	            psmt.setString(1, productId);
	            rs = psmt.executeQuery();

	            if (rs.next()) {
	                product = new Product();
	                product.setProductId(rs.getString("product_id"));
	                product.setName(rs.getString("name"));
	                product.setUnitPrice(rs.getInt("unit_price"));
	                product.setDescription(rs.getString("description"));
	                product.setManufacturer(rs.getString("manufacturer"));
	                product.setCategory(rs.getString("category"));
	                product.setUnitsInStock(rs.getInt("units_in_stock"));
	                product.setCondition(rs.getString("condition"));
	                product.setFile(rs.getString("file"));
	                product.setQuantity(rs.getInt("quantity"));
	            }
	        } catch (Exception e) {
	            System.err.println(">>> 상품 상세 조회 실패");
	            e.printStackTrace();
	        }
	        return product;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		 int result = 0;
	        try {
	            String sql = """
	                INSERT INTO product (
	                    product_id, name, unit_price, description,
	                    manufacturer, category, units_in_stock, `condition`, file, quantity
	                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
	            """;
	            psmt = con.prepareStatement(sql);
	            psmt.setString(1, product.getProductId());
	            psmt.setString(2, product.getName());
	            psmt.setInt(3, product.getUnitPrice());
	            psmt.setString(4, product.getDescription());
	            psmt.setString(5, product.getManufacturer());
	            psmt.setString(6, product.getCategory());
	            psmt.setLong(7, product.getUnitsInStock());
	            psmt.setString(8, product.getCondition());
	            psmt.setString(9, product.getFile());
	            psmt.setInt(10, product.getQuantity());

	            result = psmt.executeUpdate();
	            System.out.println(">>> insert result: " + result);
	        } catch (Exception e) {
	            System.err.println(">>> 상품 등록 실패");
	            e.printStackTrace();
	        }
	        return result;
	}
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
        try {
            String sql = """
                UPDATE product SET
                    name = ?, unit_price = ?, description = ?, manufacturer = ?,
                    category = ?, units_in_stock = ?, `condition` = ?, file = ?, quantity = ?
                WHERE product_id = ?
            """;
            psmt = con.prepareStatement(sql);
            psmt.setString(1, product.getName());
            psmt.setInt(2, product.getUnitPrice());
            psmt.setString(3, product.getDescription());
            psmt.setString(4, product.getManufacturer());
            psmt.setString(5, product.getCategory());
            psmt.setLong(6, product.getUnitsInStock());
            psmt.setString(7, product.getCondition());
            psmt.setString(8, product.getFile());
            psmt.setInt(9, product.getQuantity());
            psmt.setString(10, product.getProductId());

            result = psmt.executeUpdate();
        } catch (Exception e) {
            System.err.println(">>> 상품 수정 실패");
            e.printStackTrace();
        }
        return result;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		 int result = 0;
	        try {
	            String sql = "DELETE FROM product WHERE product_id = ?";
	            psmt = con.prepareStatement(sql);
	            psmt.setString(1, productId);
	            result = psmt.executeUpdate();
	        } catch (Exception e) {
	            System.err.println(">>> 상품 삭제 실패");
	            e.printStackTrace();
	        }
	        return result;
	    }
	
	public int decreaseStock(String productId, int amount) {
	    int result = 0;
	    String sql = "UPDATE product SET units_in_stock = units_in_stock - ? WHERE product_id = ?";
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setInt(1, amount);
	        psmt.setString(2, productId);
	        result = psmt.executeUpdate();
	    } catch (Exception e) {
	        System.err.println(">>> 재고 감소 실패");
	        e.printStackTrace();
	    }
	    return result;
	}
	
	}































