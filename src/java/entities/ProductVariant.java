package entities;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "Product_Variant")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductVariant.findAll", query = "SELECT p FROM ProductVariant p"),
    @NamedQuery(name = "ProductVariant.findById", query = "SELECT p FROM ProductVariant p WHERE p.id = :id"),
    @NamedQuery(name = "ProductVariant.findBySize", query = "SELECT p FROM ProductVariant p WHERE p.size = :size"),
    @NamedQuery(name = "ProductVariant.findByColor", query = "SELECT p FROM ProductVariant p WHERE p.color = :color"),
    @NamedQuery(name = "ProductVariant.findByStockQuantity", query = "SELECT p FROM ProductVariant p WHERE p.stockQuantity = :stockQuantity"),
    @NamedQuery(name = "ProductVariant.findByProductId", query = "SELECT p FROM ProductVariant p WHERE p.productId.id = :productId")
})
public class ProductVariant implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "size")
    private String size;

    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "color")
    private String color;

    @NotNull
    @Column(name = "stock_quantity")
    private int stockQuantity;

    @OneToMany(mappedBy = "productVariantId")
    private Collection<OrderDetails> orderDetailsCollection;

    @JoinColumn(name = "product_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Product productId;

    public ProductVariant() {
    }

    public ProductVariant(Integer id) {
        this.id = id;
    }

    public ProductVariant(Integer id, String size, String color, int stockQuantity) {
        this.id = id;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    @XmlTransient
    public Collection<OrderDetails> getOrderDetailsCollection() {
        return orderDetailsCollection;
    }

    public void setOrderDetailsCollection(Collection<OrderDetails> orderDetailsCollection) {
        this.orderDetailsCollection = orderDetailsCollection;
    }

    public Product getProductId() {
        return productId;
    }

    public void setProductId(Product productId) {
        this.productId = productId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof ProductVariant)) {
            return false;
        }
        ProductVariant other = (ProductVariant) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "entities.ProductVariant[ id=" + id + " ]";
    }

}
