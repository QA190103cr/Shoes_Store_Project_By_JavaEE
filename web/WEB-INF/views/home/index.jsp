<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--<link rel="StyleSheet" href="<c:url value="/css/home.css" />" />-->

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }

    .content {
        width: 100%;
        padding-bottom: 30px;
    }

    .banner {
        width: 100%;
    }

    .brand-section {
        margin-top: 30px;
        display: flex;
        justify-content: center;
        gap: 10px;
    }
</style>

<div class="content">
    <div class="banner">
        <img src="<c:url value='/imgs/banner.webp' /> " alt="Banner khuyến mãi" width=100% height="500"/>
    </div>

    <div class="brand-section">
        <c:forEach var="brand" items="${brandList}" >
            <img src="<c:url value="/imgs/brand-logo/${brand.logo}" />" alt="${brand.name}" width=235 height=125 />
        </c:forEach>
    </div>
</div>
