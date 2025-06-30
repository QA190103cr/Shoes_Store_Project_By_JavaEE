<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .main-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 30px;
        text-align: center;
    }

    h1 {
        color: #2c3e50;
        margin-bottom: 20px;
    }

    .create-wrapper {
        width: 100%;
        max-width: 1200px;
        display: flex;
        justify-content: flex-start;
        margin-bottom: 15px;
    }

    a.create-link {
        display: inline-block;
        margin-bottom: 20px;
        padding: 10px 20px;
        background-color: #3498db;
        color: #fff;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.2s;
    }

    a.create-link:hover {
        background-color: #2980b9;
    }

    table {
        width: 100%;
        max-width: 1200px;
        border-collapse: collapse;
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 10px 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #3498db;
        color: white;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 6px;
    }

    a {
        color: #2980b9;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>

<main class="main-container">
    <h1>Category List</h1>

    <div class="create-wrapper">
        <a href="<c:url value="/admin/category/create" />" class="create-link">Create</a>
    </div>

    <table border="1" cellspacing="0" cellpadding="4">
        <tr>
            <th>No.</th>
            <th>Id</th>
            <th>Name</th>
            <th>Description</th>
            <th>Operations</th>
            <th>Variants</th>
        </tr>
        <c:forEach var="category" items="${categoryList}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>${category.description}</td>
                <td>
                    <a href="<c:url value="/admin/category/edit?id=${category.id}" />">Edit</a> | 
                    <a href="<c:url value="/admin/category/delete?id=${category.id}" />">Delete</a> 
                </td>
            </tr>
        </c:forEach>
    </table>
</main>