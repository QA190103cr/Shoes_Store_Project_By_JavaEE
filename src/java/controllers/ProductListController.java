package controllers;

import entities.Product;
import sessionbeans.ProductFacade;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductListController extends HttpServlet {

    @EJB
    private ProductFacade productFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sortOption = request.getParameter("sort");
        List<Product> products;

        if (sortOption != null && !sortOption.isEmpty()) {
            products = productFacade.findAllSorted(sortOption);
        } else {
            products = productFacade.findAll(); // mặc định
        }

        request.setAttribute("list", products);
        request.getRequestDispatcher("/WEB-INF/views/products/products.jsp").forward(request, response);
    }
}
