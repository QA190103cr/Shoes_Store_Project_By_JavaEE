/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Product;
import java.io.File;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.BrandFacade;
import sessionbeans.CategoryFacade;
import sessionbeans.ProductFacade;

/**
 *
 * @author ASUS
 */

@Controller
public class AdminProductController {

    ModelAndView modelAV = new ModelAndView("layout", "folder", "admin");

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade productFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/CategoryFacade")
    private CategoryFacade categoryFacade;

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/BrandFacade")
    private BrandFacade brandFacade;

    @RequestMapping("/admin/product")
    public ModelAndView product(HttpServletRequest request) {
        modelAV.addObject("view", "product/index");

        List<Product> productList = productFacade.findAll();
        modelAV.addObject("productList", productList);

        return modelAV;
    }

    @RequestMapping("/admin/product/create")
    public ModelAndView create() {
        modelAV.addObject("view", "product/create");

        modelAV.addObject("categories", categoryFacade.findAll());
        modelAV.addObject("brands", brandFacade.findAll());

        return modelAV;
    }

    @RequestMapping(value = "/admin/product/create", method = RequestMethod.POST)
    public ModelAndView create(@RequestParam("imageFile") MultipartFile imageFile, Product product, HttpServletRequest request) {
        System.out.println("Start here");

        try {
            // 1. Lấy tên file gốc
            String originalFilename = imageFile.getOriginalFilename();

            // 2. Tạo đường dẫn lưu file vào folder Web Pages/images/product-images
            String uploadPath = request.getServletContext().getRealPath("/images/product-images/");
            System.out.println("uploadPath: " + uploadPath);

            if (uploadPath == null) {
                throw new RuntimeException("uploadPath is null. Check getServletContext().getRealPath()");
            }

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 3. Lưu file vào folder
            File savedFile = new File(uploadDir, originalFilename);
            imageFile.transferTo(savedFile); // lưu file

            // 4. Lưu tên file vào DB (nếu bạn lưu đường dẫn: /imgs/product-images/xxx.jpg thì cũng được)
            product.setImages(originalFilename);

            product.setCreatedAt(new Date());
            product.setUpdatedAt(new Date());

            System.out.println("===[ Debug: Product Submitted ]===");
            System.out.println("ID: " + product.getId());
            System.out.println("Name: " + product.getName());
            System.out.println("Images: " + product.getImages());
            System.out.println("Price: " + product.getPrice());
            System.out.println("SecondHand: " + product.getIsSecondHand());
            System.out.println("ForGender: " + product.getForGender());
            System.out.println("Brand: " + (product.getBrandId() != null ? product.getBrandId().getId() : "null"));
            System.out.println("Category: " + (product.getCategoryId() != null ? product.getCategoryId().getId() : "null"));
            System.out.println("==================================");

            productFacade.create(product);

            return new ModelAndView("redirect:/admin/product");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping("/admin/product/edit")
    public ModelAndView edit(int id) {
        Product product = productFacade.find(id);

        modelAV.addObject("view", "/product/edit");
        modelAV.addObject("product", product);

        modelAV.addObject("categories", categoryFacade.findAll());
        modelAV.addObject("brands", brandFacade.findAll());

        return modelAV;
    }

    @RequestMapping(value = "/admin/product/edit", method = RequestMethod.POST)
    public ModelAndView edit(@RequestParam("newImageFile") MultipartFile imageFile, Product product, HttpServletRequest request) {
        try {
            if (!imageFile.isEmpty()) {
                String originalFilename = imageFile.getOriginalFilename();
                String uploadPath = request.getServletContext().getRealPath("/images/product-images/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                File savedFile = new File(uploadDir, originalFilename);
                imageFile.transferTo(savedFile);
                product.setImages(originalFilename);

                product.setUpdatedAt(new Date());
                productFacade.edit(product);
            } else {
                productFacade.updateProductWithoutImage(product);
            }

            return new ModelAndView("redirect:/admin/product");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping("/admin/product/delete")
    public ModelAndView delete(int id) {
        ModelAndView modeAV = new ModelAndView("/admin/product/delete");

        modeAV.addObject("id", id);

        return modeAV;
    }

    @RequestMapping(value = "/admin/product/delete", method = RequestMethod.POST)
    public ModelAndView delete(int id, String op) {
        if (op.equals("yes")) {
            Product product = productFacade.find(id);

            productFacade.remove(product);
        }
        return new ModelAndView("redirect:/admin/product");
    }
}
