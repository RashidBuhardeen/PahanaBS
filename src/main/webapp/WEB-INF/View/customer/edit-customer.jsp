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
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
