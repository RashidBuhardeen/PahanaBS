<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Add New Customer</h2>

    <form action="CustomerController" method="post">
        <input type="hidden" name="action" value="addCustomer" />

        <div class="form-group">
            <label>Account Number:</label>
            <input type="text" name="account_no" required />
        </div>

        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" required />
        </div>

        <div class="form-group">
            <label>Address:</label>
            <textarea name="address" rows="3" required></textarea>
        </div>

        <div class="form-group">
            <label>Telephone Number:</label>
            <input type="text" name="telephone" required />
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required />
        </div>

        <button type="submit" class="btn">Add Customer</button>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
