<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Add New Item</h2>

    <form action="items" method="post">
        <div class="form-group">
            <label>Item Code:</label>
            <input type="text" name="itemCode" required />
        </div>

        <div class="form-group">
            <label>Item Name:</label>
            <input type="text" name="itemName" required />
        </div>

        <div class="form-group">
            <label>Price:</label>
            <input type="number" step="0.01" name="price" required />
        </div>

        <div class="form-group">
            <label>Stock Quantity:</label>
            <input type="number" name="stockQuantity" required />
        </div>

        <button type="submit" class="btn">Add Item</button>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
