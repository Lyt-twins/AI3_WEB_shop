package shop.dto;

public class ProductIo {

	    private String productId;
	    private int orderNo;
	    private int amount;
	    private String type;
	    private String userId;

	    public ProductIo() {}

	    public String getProductId() {
	        return productId;
	    }
	    public void setProductId(String productId) {
	        this.productId = productId;
	    }

	    public int getOrderNo() {
	        return orderNo;
	    }
	    public void setOrderNo(int orderNo) {
	        this.orderNo = orderNo;
	    }

	    public int getAmount() {
	        return amount;
	    }
	    public void setAmount(int amount) {
	        this.amount = amount;
	    }

	    public String getType() {
	        return type;
	    }
	    public void setType(String type) {
	        this.type = type;
	    }

	    public String getUserId() {
	        return userId;
	    }
	    public void setUserId(String userId) {
	        this.userId = userId;
	    }

	    @Override
	    public String toString() {
	        return "ProductIo [productId=" + productId + ", orderNo=" + orderNo + ", amount=" + amount +
	                ", type=" + type + ", userId=" + userId + "]";
	    }
	}

