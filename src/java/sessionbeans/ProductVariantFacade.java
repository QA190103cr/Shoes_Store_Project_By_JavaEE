package sessionbeans;

import entities.ProductVariant;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class ProductVariantFacade extends AbstractFacade<ProductVariant> {

    @PersistenceContext(unitName = "Shoes-Shopping-WebPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductVariantFacade() {
        super(ProductVariant.class);
    }

    // ✅ Trả về danh sách biến thể theo productId
    public List<ProductVariant> findByProductId(int productId) {
        return em.createQuery("SELECT p FROM ProductVariant p WHERE p.productId.id = :productId", ProductVariant.class)
                .setParameter("productId", productId)
                .getResultList();
    }

    // ✅ Tương tự findByProductId, có thể gộp nếu không cần thiết
    public List<ProductVariant> getProductVariantByProductId(int productId) {
        return findByProductId(productId);
    }

    // ✅ Tìm một biến thể cụ thể theo productId, size và color
    public ProductVariant findByProductIdAndSizeAndColor(int productId, String size, String color) {
    try {
        return em.createQuery("SELECT p FROM ProductVariant p WHERE p.productId.id = :pid AND p.size = :size AND p.color = :color", ProductVariant.class)
                .setParameter("pid", productId)
                .setParameter("size", size)
                .setParameter("color", color)
                .getSingleResult();
    } catch (Exception e) {
        return null;
    }
}
}
