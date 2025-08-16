<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Customer List</h2>

    <a href="CustomerController?action=addCustomer" class="btn">Add New Customer</a>
    <br /><br />

    <table class="table">
        <thead>
            <tr>
                <th>Account No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Telephone</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="customer" items="${account_list}">
                <tr>
                    <td>${customer.account_number}</td>
                    <td>${customer.name}</td>
                    <td>${customer.address}</td>
                    <td>${customer.telephone_number}</td>
                    <td>${customer.email}</td>
                    <td>
                        <a href="CustomerController?action=editCustomer&id=${customer.account_number}" class="btn">Edit</a>
                        <a href="CustomerController?action=deleteCustomer&id=${customer.account_number}" class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>
