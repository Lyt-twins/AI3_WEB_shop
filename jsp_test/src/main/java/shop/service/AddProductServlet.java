package shop.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import shop.dao.ProductRepository;
import shop.dto.Product;

@WebServlet("/shop/add_pro.jsp")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB 메모리 임계치
    maxFileSize = 5 * 1024 * 1024,      // 개별 파일 최대 5MB
    maxRequestSize = 20 * 1024 * 1024   // 전체 요청 최대 20MB
)
public class AddProductServlet extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String savePath = getServletContext().getRealPath("/static/img");

        // 파라미터 수신
        String productId = request.getParameter("productId");
        String name = request.getParameter("name");
        String unitPriceStr = request.getParameter("unitPrice");
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        String category = request.getParameter("category");
        String unitsInStockStr = request.getParameter("unitsInStock");
        String condition = request.getParameter("condition");

        // 필수 검증
        if (productId == null || name == null || unitPriceStr == null || unitsInStockStr == null || condition == null ||
            productId.isEmpty() || name.isEmpty() || unitPriceStr.isEmpty() || unitsInStockStr.isEmpty() || condition.isEmpty()) {
            response.sendRedirect("add.jsp?error=empty_field");
            return;
        }

        int unitPrice = 0;
        long unitsInStock = 0;
        try {
            unitPrice = Integer.parseInt(unitPriceStr);
            unitsInStock = Long.parseLong(unitsInStockStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("add.jsp?error=invalid_number");
            return;
        }

        // 파일 처리
        String fileName = "";
        try {
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
                File uploadDir = new File(savePath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                filePart.write(savePath + File.separator + fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add.jsp?error=file_upload");
            return;
        }

        // 상품 객체 생성
        Product product = new Product();
        product.setProductId(productId);
        product.setName(name);
        product.setUnitPrice(unitPrice);
        product.setDescription(description);
        product.setManufacturer(manufacturer);
        product.setCategory(category);
        product.setUnitsInStock(unitsInStock);
        product.setCondition(condition);
        product.setFile(fileName);
        product.setQuantity(0);

        // DB 저장
        ProductRepository repo = new ProductRepository();
        int result = repo.insert(product);

        if (result == 1) {
            response.sendRedirect("products.jsp");
        } else {
            response.sendRedirect("add.jsp?error=insert_failed");
        }
    }
}
