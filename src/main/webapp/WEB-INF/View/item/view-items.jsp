<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Item List</h2>

    <a href="items?action=new" class="btn">Add New Item</a>
    <br /><br />

    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Item Code</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.itemCode}</td>
                    <td>${item.itemName}</td>
                    <td>${item.price}</td>
                    <td>${item.stockQuantity}</td>
                    <td>
                        <a href="items?action=edit&id=${item.id}" class="btn">Edit</a>
                        <a href="items?action=delete&id=${item.id}" class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>
