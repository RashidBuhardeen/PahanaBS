<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Edit Customer</h2>

    <form action="CustomerController" method="post">
        <input type="hidden" name="action" value="updateCustomer" />

        <div class="form-group">
            <label>Account Number:</label>
            <input type="text" name="account_no" value="${customer.account_number}" readonly />
        </div>

        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" value="${customer.name}" required />
        </div>

        <div class="form-group">
            <label>Address:</label>
            <textarea name="address" rows="3" required>${customer.address}</textarea>
        </div>

        <div class="form-group">
            <label>Telephone Number:</label>
            <input type="text" name="telephone" value="${customer.telephone_number}" required />
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" value="${customer.email}" required />
        </div>

        <button type="submit" class="btn">Update Customer</button>
        <button type="button" class="btnc	"onclick="this.form.reset(); history.back();">Cancel</button>
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

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

.form-group input:focus,
.form-group textarea:focus {
    border-color: #ff9800;
    box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
    outline: none;
}

.form-group input[readonly] {
    background-color: #f0f0f0;
    cursor: not-allowed;
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

/* Button c */
.btnc {
    background-color: #201c16;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

.btnc:hover {
    background-color: #483f32;
}

/* Responsive */
@media (max-width: 600px) {
    .container {
        padding: 20px;
    }
}
</style>
