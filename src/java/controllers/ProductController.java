package controllers;

import entities.Brand;
import entities.Category;
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
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;
import sessionbeans.BrandFacade;
import sessionbeans.CategoryFacade;

@Controller
public class ProductController {

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade productFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductVariantFacade")
    private ProductVariantFacade productVariantFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/CategoryFacade")
    private CategoryFacade categoryFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/BrandFacade")
    private BrandFacade brandFacade;

    @RequestMapping("/products/products")
    public ModelAndView products(
            @RequestParam(value = "gender", required = false) String[] genders,
            @RequestParam(value = "category", required = false) Integer[] categoryIds,
            @RequestParam(value = "brand", required = false) Integer[] brandIds,
            @RequestParam(value = "search", required = false) String searchText,
            HttpServletRequest request
    ) {
        ModelAndView mv = new ModelAndView("layout", "folder", "products");
        mv.addObject("view", "products");

        List<Product> list = productFacade.findAll();
        List<Category> categories = categoryFacade.findAll();
        List<Brand> brands = brandFacade.findAll();

        mv.addObject("categories", categories);
        mv.addObject("brands", brands);

        // Kiểm tra xem có phải là lần đầu truy cập không (không có parameters)
        boolean isFirstLoad = (genders == null || genders.length == 0)
                && (categoryIds == null || categoryIds.length == 0)
                && (brandIds == null || brandIds.length == 0);

        // Thêm flag để JSP biết có đang filter không
        mv.addObject("hasFilters", !isFirstLoad);

        // Chỉ filter khi thực sự có parameters
        if (!isFirstLoad) {
            // Lọc theo gender
            if (genders != null && genders.length > 0) {
                Set<String> genderSet = new HashSet<>(Arrays.asList(genders));
                list = list.stream()
                        .filter(p -> genderSet.contains(p.getForGender()))
                        .collect(Collectors.toList());
            }

            // Lọc theo category
            if (categoryIds != null && categoryIds.length > 0) {
                Set<Integer> catSet = new HashSet<>(Arrays.asList(categoryIds));
                list = list.stream()
                        .filter(p -> p.getCategory() != null && catSet.contains(p.getCategory().getId()))
                        .collect(Collectors.toList());
            }

            // Lọc theo brand
            if (brandIds != null && brandIds.length > 0) {
                Set<Integer> brandSet = new HashSet<>(Arrays.asList(brandIds));
                list = list.stream()
                        .filter(p -> p.getBrand() != null && brandSet.contains(p.getBrand().getId()))
                        .collect(Collectors.toList());
            }
        }

        if (searchText != null && !searchText.trim().isEmpty()) {
            String lowerSearch = searchText.toLowerCase();
            list = list.stream()
                    .filter(p -> p.getName() != null && p.getName().toLowerCase().contains(lowerSearch))
                    .collect(Collectors.toList());
        }

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
