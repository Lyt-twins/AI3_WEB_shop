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

@WebServlet("/shop/update_pro")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 5 * 1024 * 1024,    // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String root = request.getContextPath();
        String savePath = getServletContext().getRealPath("/static/img");

        // 파라미터 추출
        String productId = request.getParameter("productId");
        String name = request.getParameter("name");
        String unitPriceStr = request.getParameter("unitPrice");
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        String category = request.getParameter("category");
        String unitsInStockStr = request.getParameter("unitsInStock");
        String condition = request.getParameter("condition");

        // 필수 값 확인
        if (productId == null || name == null || unitPriceStr == null || unitsInStockStr == null
                || productId.isEmpty() || name.isEmpty() || unitPriceStr.isEmpty() || unitsInStockStr.isEmpty()) {
            response.sendRedirect(root + "/shop/update.jsp?id=" + productId + "&error=empty_field");
            return;
        }

        int unitPrice = 0;
        long unitsInStock = 0;

        try {
            unitPrice = Integer.parseInt(unitPriceStr.trim());
            unitsInStock = Long.parseLong(unitsInStockStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(root + "/shop/update.jsp?id=" + productId + "&error=invalid_number");
            return;
        }

        // 기존 상품 정보 가져오기
        ProductRepository repo = new ProductRepository();
        Product product = repo.getProductById(productId);

        if (product == null) {
            response.sendRedirect(root + "/shop/products.jsp?error=not_found");
            return;
        }

        // 파일 처리
        String fileName = product.getFile();  // 기존 파일 유지
        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
            File dir = new File(savePath);
            if (!dir.exists()) dir.mkdirs();
            filePart.write(savePath + File.separator + fileName);
        }

        // 상품 정보 업데이트
        product.setName(name);
        product.setUnitPrice(unitPrice);
        product.setDescription(description);
        product.setManufacturer(manufacturer);
        product.setCategory(category);
        product.setUnitsInStock(unitsInStock);
        product.setCondition(condition);
        product.setFile(fileName);

        int result = repo.update(product);

        if (result == 1) {
            response.sendRedirect(root + "/shop/products.jsp");
        } else {
            response.sendRedirect(root + "/shop/update.jsp?id=" + productId + "&error=update_failed");
        }
    }
}
