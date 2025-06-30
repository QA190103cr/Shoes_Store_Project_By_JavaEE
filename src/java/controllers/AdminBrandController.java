/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Brand;
import entities.Category;
import java.io.File;
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

/**
 *
 * @author ASUS
 */
@Controller
public class AdminBrandController {

    ModelAndView modelAV = new ModelAndView("layout", "folder", "admin");

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/BrandFacade")
    private BrandFacade brandFacade;

    @RequestMapping("/admin/brand")
    public ModelAndView product(HttpServletRequest request) {
        modelAV.addObject("view", "brand/index");

        List<Brand> brandList = brandFacade.findAll();
        modelAV.addObject("brandList", brandList);

        return modelAV;
    }

    @RequestMapping("/admin/brand/create")
    public ModelAndView create() {
        modelAV.addObject("view", "brand/create");
        return modelAV;
    }

    @RequestMapping(value = "/admin/brand/create", method = RequestMethod.POST)
    public ModelAndView create(@RequestParam("imageFile") MultipartFile imageFile, Brand brand, HttpServletRequest request) {
        try {
            // 1. Lấy tên file gốc
            String originalFilename = imageFile.getOriginalFilename();

            // 2. Tạo đường dẫn lưu file vào folder Web Pages/images/product-images
            String uploadPath = request.getServletContext().getRealPath("/images/brand-logo/");
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
            brand.setLogo(originalFilename);

            brandFacade.create(brand);
            return new ModelAndView("redirect:/admin/brand");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping("/admin/brand/edit")
    public ModelAndView edit(int id) {
        Brand brand = brandFacade.find(id);

        modelAV.addObject("view", "brand/edit");
        modelAV.addObject("brand", brand);

        return modelAV;
    }

    @RequestMapping(value = "/admin/brand/edit", method = RequestMethod.POST)
    public ModelAndView edit(@RequestParam("newImageFile") MultipartFile imageFile, Brand brand, HttpServletRequest request) {
        try {
            if (!imageFile.isEmpty()) {
                String originalFilename = imageFile.getOriginalFilename();
                String uploadPath = request.getServletContext().getRealPath("/images/brand-logo/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                File savedFile = new File(uploadDir, originalFilename);
                imageFile.transferTo(savedFile);
                brand.setLogo(originalFilename);

                brandFacade.edit(brand);
            } else {
                brandFacade.updateBrandWithoutLogo(brand);
            }
            return new ModelAndView("redirect:/admin/brand");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping("/admin/brand/delete")
    public ModelAndView delete(int id) {
        ModelAndView mv = new ModelAndView("admin/brand/delete");
        mv.addObject("id", id);
        return mv;
    }

    @RequestMapping(value = "/admin/brand/delete", method = RequestMethod.POST)
    public ModelAndView delete(int id, String op) {
        if ("yes".equals(op)) {
            Brand brand = brandFacade.find(id);
            brandFacade.remove(brand);
        }
        return new ModelAndView("redirect:/admin/brand");
    }
}
