package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		 int result = 0;
		    String sql = "INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) "
		               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		    try {
		        psmt = con.prepareStatement(sql);
		        psmt.setString(1, order.getShipName());
		        psmt.setString(2, order.getZipCode());
		        psmt.setString(3, order.getCountry());
		        psmt.setString(4, order.getAddress());
		        psmt.setString(5, order.getDate());
		        psmt.setString(6, order.getOrderPw());
		        psmt.setString(7, order.getUserId());
		        psmt.setInt(8, order.getTotalPrice());
		        psmt.setString(9, order.getPhone());
		        result = psmt.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int orderNo = 0;
		String sql = "SELECT MAX(order_no)FROM `order`";
		try {
			 psmt = con.prepareStatement(sql);
		        rs = psmt.executeQuery();
		        if (rs.next()) {
		            orderNo = rs.getInt(1);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return orderNo;
		}
	
	
		public int getNextOrderNo() {
		    int nextOrderNo = 0;
		    String sql = "SELECT IFNULL(MAX(order_no), 0) + 1 FROM `order`";  // MySQL 기준
	
		    try {
		        psmt = con.prepareStatement(sql);
		        rs = psmt.executeQuery();
		        if (rs.next()) {
		            nextOrderNo = rs.getInt(1);
		        }
		    } catch (SQLException e) {
		        System.err.println(">>> 주문번호 생성 오류");
		        e.printStackTrace();
		    }
	
		    return nextOrderNo;
		}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
		public List<Product> list(String userId) {
		    List<Product> list = new ArrayList<>();
		    String sql = "SELECT o.order_no, p.name, p.unit_price, oi.quantity " +
		                 "FROM `order` o " +  // ← 수정됨
		                 "JOIN order_item oi ON o.order_no = oi.order_no " +
		                 "JOIN product p ON oi.product_id = p.product_id " +
		                 "WHERE o.user_id = ?";

		    try {
		        psmt = con.prepareStatement(sql);
		        psmt.setString(1, userId);
		        rs = psmt.executeQuery();

		        while (rs.next()) {
		            Product p = new Product();
		            p.setOrderNo(rs.getInt("order_no"));
		            p.setName(rs.getString("name"));
		            p.setUnitPrice(rs.getInt("unit_price"));
		            p.setQuantity(rs.getInt("quantity"));
		            list.add(p);
		        }
		    } catch (SQLException e) {
		        System.err.println("주문 목록 조회 중 에러 발생");
		        e.printStackTrace();
		    }

		    return list;
		}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
		public List<Product> list(String phone, String orderPw) {
		    List<Product> list = new ArrayList<>();

		    String sql = """
		        SELECT oi.order_no, oi.quantity, p.product_id, p.name, p.unit_price
		        FROM order_item oi
		        JOIN product p ON oi.product_id = p.product_id
		        JOIN `order` o ON oi.order_no = o.order_no
		        WHERE o.phone = ? AND o.order_pw = ?
		        ORDER BY oi.order_no DESC
		    """;

		    try {
		        psmt = con.prepareStatement(sql);
		        psmt.setString(1, phone);
		        psmt.setString(2, orderPw);
		        rs = psmt.executeQuery();

		        while (rs.next()) {
		            Product p = new Product();
		            p.setOrderNo(rs.getInt("order_no"));
		            p.setProductId(rs.getString("product_id"));
		            p.setName(rs.getString("name"));
		            p.setUnitPrice(rs.getInt("unit_price"));
		            p.setQuantity(rs.getInt("quantity"));
		            list.add(p);
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return list;
		}
	}
	































