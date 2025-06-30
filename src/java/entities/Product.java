package entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "Product")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p")
    ,
    @NamedQuery(name = "Product.findById", query = "SELECT p FROM Product p WHERE p.id = :id")
    ,
    @NamedQuery(name = "Product.findByName", query = "SELECT p FROM Product p WHERE p.name = :name")
    ,
    @NamedQuery(name = "Product.findByImages", query = "SELECT p FROM Product p WHERE p.images = :images")
    ,
    @NamedQuery(name = "Product.findByIsSecondHand", query = "SELECT p FROM Product p WHERE p.isSecondHand = :isSecondHand")
    ,
    @NamedQuery(name = "Product.findByForGender", query = "SELECT p FROM Product p WHERE p.forGender = :forGender")
    ,
    @NamedQuery(name = "Product.findByPrice", query = "SELECT p FROM Product p WHERE p.price = :price")
    ,
    @NamedQuery(name = "Product.findByCreatedAt", query = "SELECT p FROM Product p WHERE p.createdAt = :createdAt")
    ,
    @NamedQuery(name = "Product.findByUpdatedAt", query = "SELECT p FROM Product p WHERE p.updatedAt = :updatedAt")
})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "name")
    private String name;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "images")
    private String images;

    @Basic(optional = false)
    @NotNull
    @Column(name = "is_second_hand")
    private boolean isSecondHand;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "for_gender")
    private String forGender;

    @Basic(optional = false)
    @NotNull
    @Column(name = "price")
    private int price;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @OneToMany(mappedBy = "productId")
    private Collection<Discount> discountCollection;

    @OneToMany(mappedBy = "productId", fetch = FetchType.LAZY)
    private Collection<ProductVariant> productVariantCollection;

    @JoinColumn(name = "brand_id", referencedColumnName = "id")
    @ManyToOne
    private Brand brandId;

    @JoinColumn(name = "category_id", referencedColumnName = "id")
    @ManyToOne
    private Category categoryId;

    @OneToMany(mappedBy = "productId")
    private Collection<Review> reviewCollection;

    public Product() {
    }

    public Product(Integer id) {
        this.id = id;
    }

    public Product(Integer id, String name, String images, boolean isSecondHand, String forGender, int price) {
        this.id = id;
        this.name = name;
        this.images = images;
        this.isSecondHand = isSecondHand;
        this.forGender = forGender;
        this.price = price;
    }

    // Getters và setters...
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public boolean getIsSecondHand() {
        return isSecondHand;
    }

    public void setIsSecondHand(boolean isSecondHand) {
        this.isSecondHand = isSecondHand;
    }

    public String getForGender() {
        return forGender;
    }

    public void setForGender(String forGender) {
        this.forGender = forGender;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @XmlTransient
    public Collection<Discount> getDiscountCollection() {
        return discountCollection;
    }

    public void setDiscountCollection(Collection<Discount> discountCollection) {
        this.discountCollection = discountCollection;
    }

    @XmlTransient
    public Collection<ProductVariant> getProductVariantCollection() {
        return productVariantCollection;
    }

    public void setProductVariantCollection(Collection<ProductVariant> productVariantCollection) {
        this.productVariantCollection = productVariantCollection;
    }

    public Brand getBrandId() {
        return brandId;
    }

    public void setBrandId(Brand brandId) {
        this.brandId = brandId;
    }

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    public Brand getBrand() {
        return brandId;
    }

    public void setBrand(Brand brand) {
        this.brandId = brand;
    }

    public Category getCategory() {
        return categoryId;
    }

    public void setCategory(Category category) {
        this.categoryId = category;
    }

    @XmlTransient
    public Collection<Review> getReviewCollection() {
        return reviewCollection;
    }

    public void setReviewCollection(Collection<Review> reviewCollection) {
        this.reviewCollection = reviewCollection;
    }

    @Override
    public int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        return (this.id != null || other.id == null) && (this.id == null || this.id.equals(other.id));
    }

    @Override
    public String toString() {
        return "entities.Product[ id=" + id + " ]";
    }

    @Transient
    private int totalStock;

    @Transient
    private List<String> allSize;

    public int getTotalStock() {
        return productVariantCollection == null ? 0
                : productVariantCollection.stream()
                        .mapToInt(ProductVariant::getStockQuantity)
                        .sum();
    }

    public Set<String> getAllSize() {
        return productVariantCollection == null ? new HashSet<>()
                : productVariantCollection.stream()
                        .map(ProductVariant::getSize)
                        .collect(Collectors.toSet());
    }

    public String getForGenderCapitalized() {
        if (forGender == null || forGender.isEmpty()) {
            return "";
        }
        return forGender.substring(0, 1).toUpperCase() + forGender.substring(1);
    }
}
