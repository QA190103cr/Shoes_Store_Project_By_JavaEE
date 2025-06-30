/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Brand;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author ASUS
 */
@Stateless
public class BrandFacade extends AbstractFacade<Brand> {

    @PersistenceContext(unitName = "Shoes-Shopping-WebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    public void updateBrandWithoutLogo(Brand updatedBrand) {
        Brand existingProduct = em.find(Brand.class, updatedBrand.getId());
        if (existingProduct != null) {
            existingProduct.setName(updatedBrand.getName());
            
            em.merge(existingProduct);
        }
    }

    public BrandFacade() {
        super(Brand.class);
    }
    
}
