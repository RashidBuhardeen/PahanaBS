<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Edit Item</h2>

    <form action="items" method="post">
        <input type="hidden" name="id" value="${item.id}" />

        <div class="form-group">
            <label>Item Code:</label>
            <input type="text" name="itemCode" value="${item.itemCode}" required />
        </div>

        <div class="form-group">
            <label>Item Name:</label>
            <input type="text" name="itemName" value="${item.itemName}" required />
        </div>

        <div class="form-group">
            <label>Price:</label>
            <input type="number" step="0.01" name="price" value="${item.price}" required />
        </div>

        <div class="form-group">
            <label>Stock Quantity:</label>
            <input type="number" name="stockQuantity" value="${item.stockQuantity}" required />
        </div>

        <button type="submit" class="btn">Update Item</button>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
