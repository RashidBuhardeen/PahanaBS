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

<style>
/* Body and container */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding-top: 60px; /* avoid hiding under navbar */
    color: #222;
}

.container {
    max-width: 600px;
    margin: 30px auto;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Heading */
.container h2 {
    color: #222;
    margin-bottom: 25px;
    text-align: center;
}

/* Form groups */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: bold;
    color: #222;
}

.form-group input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input:focus {
    border-color: #ff9800;
    box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
    outline: none;
}

/* Button */
.btn {
    background-color: #ff9800;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.btn:hover {
    background-color: #e68900;
}

/* Responsive */
@media (max-width: 600px) {
    .container {
        padding: 20px;
    }
}
</style>
