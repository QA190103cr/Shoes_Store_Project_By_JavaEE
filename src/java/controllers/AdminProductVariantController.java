package controllers;

import entities.Product;
import entities.ProductVariant;
import java.util.List;
import javax.ejb.EJB;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.ProductFacade;
import sessionbeans.ProductVariantFacade;

/**
 * Controller quản lý ProductVariant
 */
@Controller
public class AdminProductVariantController {

    ModelAndView modelAV = new ModelAndView("layout", "folder", "admin");

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductVariantFacade")
    private ProductVariantFacade productVariantFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade productFacade;

    // Trang danh sách các biến thể của sản phẩm
    @RequestMapping("/admin/product_variant")
    public ModelAndView index(@RequestParam("productId") int productId) {
        modelAV.addObject("view", "product_variant/index");

        List<ProductVariant> productVariantList = productVariantFacade.getProductVariantByProductId(productId);
        modelAV.addObject("productVariantList", productVariantList);
        modelAV.addObject("productId", productId);

        return modelAV;
    }

    // Trang tạo mới ProductVariant
    @RequestMapping("/admin/product_variant/create")
    public ModelAndView create(@RequestParam("productId") int productId) {
        ModelAndView modelAV = new ModelAndView("layout", "folder", "admin");

        modelAV.addObject("view", "product_variant/create");
        modelAV.addObject("productId", productId);

        return modelAV;
    }

    // Xử lý tạo mới ProductVariant - FIXED METHOD
    @RequestMapping(value = "/admin/product_variant/create", method = RequestMethod.POST)
    public ModelAndView create(@RequestParam("size") String size,
            @RequestParam("color") String color,
            @RequestParam("stockQuantity") int stockQuantity,
            @RequestParam("productId") int productId) {
        // In ra thông tin đã nhập
        System.out.println("===== FORM SUBMISSION =====");
        System.out.println("Size: " + size);
        System.out.println("Color: " + color);
        System.out.println("Stock Quantity: " + stockQuantity);
        System.out.println("Product ID: " + productId);
        System.out.println("===========================");

        try {
            // Fetch the Product object using the productId
            Product product = productFacade.find(productId);
            if (product == null) {
                throw new RuntimeException("Product not found with ID: " + productId);
            }

            // Manually create ProductVariant object
            ProductVariant productVariant = new ProductVariant();
            productVariant.setSize(size);
            productVariant.setColor(color);
            productVariant.setStockQuantity(stockQuantity);
            productVariant.setProductId(product);

            productVariantFacade.create(productVariant);
            
            product.getProductVariantCollection().size();

            return new ModelAndView("redirect:/admin/product_variant?productId=" + productId);
        } catch (Exception e) {
            e.printStackTrace();

            ModelAndView mav = new ModelAndView("layout", "folder", "admin");
            mav.addObject("view", "product_variant/create");
            mav.addObject("productId", productId);
            mav.addObject("error", "Lỗi tạo product variant: " + e.getMessage());

            return mav;
        }
    }

    // Trang chỉnh sửa ProductVariant
    @RequestMapping("/admin/product_variant/edit")
    public ModelAndView edit(@RequestParam("id") int id, @RequestParam("productId") int productId) {
        ProductVariant productVariant = productVariantFacade.find(id);
        Product product = productFacade.find(productId);

        modelAV.addObject("view", "product_variant/edit");

        modelAV.addObject("productVariant", productVariant);
        modelAV.addObject("product", product);
        modelAV.addObject("productId", productId);

        return modelAV;
    }

    // Xử lý chỉnh sửa ProductVariant
    @RequestMapping(value = "/admin/product_variant/edit", method = RequestMethod.POST)
    public ModelAndView edit(@RequestParam("id") int id,
            @RequestParam("size") String size,
            @RequestParam("color") String color,
            @RequestParam("stockQuantity") int stockQuantity,
            @RequestParam("productId") int productId) {
        System.out.println("===== EDIT SUBMISSION =====");
        System.out.println("ID: " + id);
        System.out.println("Size: " + size);
        System.out.println("Color: " + color);
        System.out.println("Stock Quantity: " + stockQuantity);
        System.out.println("Product ID: " + productId);
        System.out.println("===========================");

        try {
            // Lấy ProductVariant hiện tại
            ProductVariant productVariant = productVariantFacade.find(id);
            if (productVariant == null) {
                throw new RuntimeException("ProductVariant not found with ID: " + id);
            }

            // Lấy Product object
            Product product = productFacade.find(productId);
            if (product == null) {
                throw new RuntimeException("Product not found with ID: " + productId);
            }

            // Cập nhật thông tin
            productVariant.setSize(size);
            productVariant.setColor(color);
            productVariant.setStockQuantity(stockQuantity);
            productVariant.setProductId(product);

            productVariantFacade.edit(productVariant);
            
            product.getProductVariantCollection().size();

            return new ModelAndView("redirect:/admin/product_variant?productId=" + productId);

        } catch (Exception e) {
            e.printStackTrace();

            ModelAndView mav = new ModelAndView("layout", "folder", "admin");
            mav.addObject("view", "product_variant/edit");
            mav.addObject("productId", productId);
            mav.addObject("error", "Lỗi cập nhật product variant: " + e.getMessage());

            return mav;
        }
    }

    // Trang xác nhận xoá ProductVariant
    @RequestMapping("/admin/product_variant/delete")
    public ModelAndView deleteConfirm(@RequestParam("id") int id, @RequestParam("productId") int productId) {
        ModelAndView mav = new ModelAndView("/admin/product_variant/delete");
        mav.addObject("id", id);
        mav.addObject("productId", productId);
        return mav;
    }

    // Xử lý xoá ProductVariant
    @RequestMapping(value = "/admin/product_variant/delete", method = RequestMethod.POST)
    public ModelAndView delete(@RequestParam("id") int id,
            @RequestParam("op") String op,
            @RequestParam("productId") int productId) {
        System.out.println("===== DELETE OPERATION =====");
        System.out.println("ID: " + id);
        System.out.println("Operation: " + op);
        System.out.println("Product ID: " + productId);
        System.out.println("=============================");

        try {
            if ("yes".equals(op)) { // Sử dụng "yes".equals() để tránh NullPointerException
                ProductVariant productVariant = productVariantFacade.find(id);
                Product product = productFacade.find(productId);
                
                if (productVariant != null) {
                    productVariantFacade.remove(productVariant);
                    
                    product.getProductVariantCollection().size();
                    
                    System.out.println("ProductVariant deleted successfully");
                } else {
                    System.out.println("ProductVariant not found with ID: " + id);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Có thể thêm error handling nếu cần
        }

        return new ModelAndView("redirect:/admin/product_variant?productId=" + productId);
    }
}
