/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Brand;
import entities.Product;
import java.util.List;
import javax.ejb.EJB;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.BrandFacade;
import sessionbeans.ProductFacade;

/**
 *
 * @author ASUS
 */
@Controller
public class HomeController {

    ModelAndView modelAV = new ModelAndView("layout", "folder", "home");
    
    @EJB(mappedName = "java:global/Shoes-Shopping-Web/ProductFacade")
    private ProductFacade pf;
    
    @EJB(mappedName = "java:global/Shoes-Shopping-Web/BrandFacade")
    private BrandFacade brandFacade;

    @RequestMapping({"", "/home"})
    public ModelAndView index() {
        modelAV.addObject("view", "index");

        List<Product> productList = pf.findAll();
        modelAV.addObject("productList", productList);

        List<Brand> brandList = brandFacade.findAll();
        modelAV.addObject("brandList", brandList);

        return modelAV;
    }
}
