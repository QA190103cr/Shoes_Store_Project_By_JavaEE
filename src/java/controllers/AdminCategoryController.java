/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Category;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.CategoryFacade;

/**
 *
 * @author ASUS
 */

@Controller
public class AdminCategoryController {
    
    ModelAndView modelAV = new ModelAndView("layout", "folder", "admin");

    @EJB(mappedName = "java:global/Shoes-Shopping-Web/CategoryFacade")
    private CategoryFacade categoryFacade;

    @RequestMapping("/admin/category")
    public ModelAndView product(HttpServletRequest request) {
        modelAV.addObject("view", "category/index");

        List<Category> categoryList = categoryFacade.findAll();
        modelAV.addObject("categoryList", categoryList);

        return modelAV;
    }

    @RequestMapping("/admin/category/create")
    public ModelAndView create() {
        modelAV.addObject("view", "category/create");
        return modelAV;
    }

    @RequestMapping(value = "/admin/category/create", method = RequestMethod.POST)
    public ModelAndView create(Category category) {
        try {
            categoryFacade.create(category);
            return new ModelAndView("redirect:/admin/category");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }
    
    @RequestMapping("/admin/category/edit")
    public ModelAndView edit(int id) {
        Category category = categoryFacade.find(id);
        
        modelAV.addObject("view", "category/edit");
        modelAV.addObject("category", category);
        
        return modelAV;
    }

    @RequestMapping(value = "/admin/category/edit", method = RequestMethod.POST)
    public ModelAndView edit(Category category) {
        try {
            categoryFacade.edit(category);
            return new ModelAndView("redirect:/admin/category");
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("error");
        }
    }

    @RequestMapping("/admin/category/delete")
    public ModelAndView delete(int id) {
        ModelAndView mv = new ModelAndView("admin/category/delete");
        mv.addObject("id", id);
        return mv;
    }

    @RequestMapping(value = "/admin/category/delete", method = RequestMethod.POST)
    public ModelAndView delete(int id, String op) {
        if ("yes".equals(op)) {
            Category category = categoryFacade.find(id);
            categoryFacade.remove(category);
        }
        return new ModelAndView("redirect:/admin/category");
    }
}
