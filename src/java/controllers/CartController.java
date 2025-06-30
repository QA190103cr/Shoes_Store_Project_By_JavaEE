package controllers;

import entities.Product;
import entities.ProductVariant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sessionbeans.ProductFacade;
import sessionbeans.ProductVariantFacade;

import javax.ejb.EJB;
import javax.servlet.http.HttpSession;
import java.util.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/cart")
public class CartController {

    ModelAndView modelAV = new ModelAndView("layout", "folder", "cart");

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade productFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductVariantFacade")
    private ProductVariantFacade productVariantFacade;

    // Thêm sản phẩm vào giỏ
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addToCart(@RequestParam("productId") int productId,
            @RequestParam("size") String size,
            @RequestParam("color") String color,
            HttpSession session) {

        Map<String, Map<String, Object>> cart
                = (Map<String, Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        String key = productId + "-" + size + "-" + color;

        // Lấy tồn kho từ DB
        ProductVariant variant = productVariantFacade.findByProductIdAndSizeAndColor(productId, size, color);
        if (variant == null) {
            return "redirect:/cart/view";
        }

        int stock = variant.getStockQuantity();

        if (cart.containsKey(key)) {
            int currentQty = (int) cart.get(key).get("quantity");
            if (currentQty < stock) {
                cart.get(key).put("quantity", currentQty + 1);
            }
        } else {
            Product product = productFacade.find(productId);
            if (product != null && stock > 0) {
                Map<String, Object> item = new HashMap<>();
                item.put("product", product);
                item.put("size", size);
                item.put("color", color);
                item.put("quantity", 1);
                cart.put(key, item);
            }
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart/view";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateCart(@RequestParam("productId") int productId,
            @RequestParam("size") String size,
            @RequestParam("color") String color,
            @RequestParam("quantity") int quantity,
            HttpSession session) {

        String key = productId + "-" + size + "-" + color;
        Map<String, Map<String, Object>> cart
                = (Map<String, Map<String, Object>>) session.getAttribute("cart");

        if (cart != null && cart.containsKey(key)) {
            ProductVariant variant = productVariantFacade.findByProductIdAndSizeAndColor(productId, size, color);
            int stock = variant != null ? variant.getStockQuantity() : 1;

            if (quantity <= 0) {
                cart.remove(key);
            } else if (quantity <= stock) {
                cart.get(key).put("quantity", quantity);
            } else {
                cart.get(key).put("quantity", stock); // nếu vượt thì giới hạn lại
            }
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart/view";
    }

    // Xem giỏ hàng
    @RequestMapping("/view")
    public ModelAndView viewCart(HttpSession session, Map<String, Object> model) {
        modelAV.addObject("view", "index");
        
        Map<String, Map<String, Object>> cart
                = (Map<String, Map<String, Object>>) session.getAttribute("cart");
        
        modelAV.addObject("cart", cart);
        return modelAV;
    }

    // Xoá sản phẩm
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String removeFromCart(@RequestParam("productId") int productId,
            @RequestParam("size") String size,
            @RequestParam("color") String color,
            HttpSession session) {

        String key = productId + "-" + size + "-" + color;

        Map<String, Map<String, Object>> cart
                = (Map<String, Map<String, Object>>) session.getAttribute("cart");

        if (cart != null) {
            cart.remove(key);
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart/view";
    }
}
