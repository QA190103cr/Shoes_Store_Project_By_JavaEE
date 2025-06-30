/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Product;
import java.util.Date;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author ASUS
 */
@Stateless
public class ProductFacade extends AbstractFacade<Product> {

    @PersistenceContext(unitName = "Shoes-Shopping-WebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public void updateProductWithoutImage(Product updatedProduct) {
        Product existingProduct = em.find(Product.class, updatedProduct.getId());
        if (existingProduct != null) {
            existingProduct.setName(updatedProduct.getName());
            existingProduct.setPrice(updatedProduct.getPrice());
            existingProduct.setIsSecondHand(updatedProduct.getIsSecondHand());
            existingProduct.setForGender(updatedProduct.getForGender());
            existingProduct.setBrandId(updatedProduct.getBrandId());
            existingProduct.setCategoryId(updatedProduct.getCategoryId());
            existingProduct.setUpdatedAt(new Date());

            // Không cập nhật image
            // existingProduct.setImages(...);
            em.merge(existingProduct);
        }
    }

    public ProductFacade() {
        super(Product.class);
    }

}
