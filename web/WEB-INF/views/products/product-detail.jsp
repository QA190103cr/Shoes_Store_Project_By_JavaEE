<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>${product.name}</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background: #fff;
            }

            .container {
                max-width: 1200px;
                margin: 40px auto;
                display: flex;
                gap: 30px;
                padding: 0 20px;
            }

            .image-gallery {
                flex: 1;
            }

            .main-image {
                width: 100%;
                border-radius: 8px;
            }

            .details {
                flex: 1.2;
            }

            .price {
                font-size: 22px;
                font-weight: bold;
                margin: 15px 0;
            }

            .form-group {
                margin: 15px 0;
            }

            .color-options {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                margin-top: 8px;
            }

            .color-option {
                padding: 10px 16px;
                border: 1px solid #ccc;
                border-radius: 20px;
                cursor: pointer;
                user-select: none;
            }

            .color-option.active {
                background: black;
                color: white;
                font-weight: bold;
            }

            .size-options {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                margin-top: 8px;
            }

            .size-option {
                padding: 10px 16px;
                border: 1px solid #ccc;
                border-radius: 20px;
                cursor: pointer;
                user-select: none;
            }

            .size-option.active {
                background: black;
                color: white;
                font-weight: bold;
            }

            .add-to-cart {
                display: block;
                width: 100%;
                padding: 15px;
                background: #000;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                margin-top: 10px;
                cursor: pointer;
            }

            .back-link {
                margin-top: 30px;
                display: inline-block;
                color: #0056d2;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="container">

            <!-- Hình ảnh sản phẩm -->
            <div class="image-gallery">
                <img id="mainImage" src="${pageContext.request.contextPath}/imgs/product-images/${product.images}" class="main-image" alt="${product.name}">
            </div>

            <!-- Thông tin sản phẩm -->
            <div class="details">
                <h1>${product.name}</h1>
                <p><strong>
                        <c:choose>
                            <c:when test="${product.forGender == 'male'}">Men's Shoes</c:when>
                            <c:when test="${product.forGender == 'female'}">Women's Shoes</c:when>
                            <c:otherwise>Unisex Shoes</c:otherwise>
                        </c:choose>
                    </strong></p>
                <p class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" />₫</p>

                <!-- Form Add to Bag -->
                <form action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="productId" value="${product.id}" />
                    <input type="hidden" name="color" id="selectedColorInput" />
                    <input type="hidden" name="size" id="selectedSizeInput" />

                    <!-- Chọn màu -->
                    <div class="form-group">
                        <label><strong>Chọn màu:</strong></label>
                        <div class="color-options">
                            <c:forEach var="color" items="${colors}">
                                <div class="color-option" data-color="${color}">${color}</div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Chọn size -->
                    <div class="form-group">
                        <label><strong>Chọn size:</strong></label>
                        <div class="size-options" id="sizeOptions">
                            <!-- sẽ được render bằng JS -->
                        </div>
                    </div>

                    <button type="submit" class="add-to-cart">Thêm vào giỏ</button>
                </form>

                <a href="${pageContext.request.contextPath}/products/products" class="back-link">← Quay lại danh sách</a>
            </div>

        </div>

        <!-- JavaScript chọn màu + size -->
        <script>
    const sizeMap = ${sizeByColorJSON};

    const colorOptions = document.querySelectorAll(".color-option");
    const sizeOptionsDiv = document.getElementById("sizeOptions");

    const selectedColorInput = document.getElementById("selectedColorInput");
    const selectedSizeInput = document.getElementById("selectedSizeInput");

    function renderSizes(color) {
        const sizes = sizeMap[color] || [];
        sizeOptionsDiv.innerHTML = "";
        selectedSizeInput.value = "";

        sizes.forEach(size => {
            const btn = document.createElement("div");
            btn.className = "size-option";
            btn.textContent = size;
            btn.dataset.size = size;
            btn.onclick = () => {
                document.querySelectorAll(".size-option").forEach(s => s.classList.remove("active"));
                btn.classList.add("active");
                selectedSizeInput.value = size;
            };
            sizeOptionsDiv.appendChild(btn);
        });
    }

    colorOptions.forEach(el => {
        el.addEventListener("click", () => {
            colorOptions.forEach(c => c.classList.remove("active"));
            el.classList.add("active");

            const selectedColor = el.dataset.color;
            selectedColorInput.value = selectedColor;
            renderSizes(selectedColor);
        });
    });

    // chọn màu đầu tiên
    if (colorOptions.length > 0) {
        colorOptions[0].click();
    }
        </script>

    </body>
</html>
