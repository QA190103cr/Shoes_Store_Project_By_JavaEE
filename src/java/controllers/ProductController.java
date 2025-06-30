package controllers;

import entities.Product;
import entities.ProductVariant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.ProductFacade;
import sessionbeans.ProductVariantFacade;

import javax.ejb.EJB;
import java.util.*;
import java.util.stream.Collectors;
import org.json.JSONObject;

@Controller
public class ProductController {

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade productFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductVariantFacade")
    private ProductVariantFacade productVariantFacade;

    @RequestMapping("/products/products")
    public ModelAndView products() {
        ModelAndView mv = new ModelAndView("layout", "folder", "products");
        mv.addObject("view", "products");
        List<Product> list = productFacade.findAll();
        mv.addObject("list", list);
        return mv;
    }

 @RequestMapping("/products/product-detail")
public ModelAndView productDetail(@RequestParam("id") int id) {
    ModelAndView mv = new ModelAndView("layout");
    mv.addObject("folder", "products");
    mv.addObject("view", "product-detail"); // detail.jsp nằm trong /WEB-INF/views/product/

    Product product = productFacade.find(id);
    List<ProductVariant> variants = productVariantFacade.findByProductId(id);

    // Màu → size
    Set<String> colors = variants.stream()
        .map(ProductVariant::getColor)
        .collect(Collectors.toCollection(LinkedHashSet::new));

    Map<String, List<String>> sizeByColor = new HashMap<>();
    for (String color : colors) {
        List<String> sizes = variants.stream()
            .filter(v -> v.getColor().equals(color))
            .map(ProductVariant::getSize)
            .distinct()
            .collect(Collectors.toList());
        sizeByColor.put(color, sizes);
    }

    // Sử dụng org.json để truyền sang JS
    JSONObject json = new JSONObject(sizeByColor);

    mv.addObject("product", product);
    mv.addObject("colors", colors);
    mv.addObject("sizeByColor", sizeByColor);
    mv.addObject("sizeByColorJSON", json.toString()); // ✅ dùng trong JS

    return mv;
}

}
