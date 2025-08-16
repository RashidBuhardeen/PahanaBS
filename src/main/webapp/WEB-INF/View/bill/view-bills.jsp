<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>All Bills</h2>

    <a href="create-bill.jsp" class="btn btn-primary mb-3">Create New Bill</a>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Bill No</th>
                <th>Customer Account</th>
                <th>Bill Date</th>
                <th>Total Amount</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bill" items="${bills}">
                <tr>
                    <td>${bill.bill_number}</td>
                    <td>${bill.customer_account_no}</td>
                    <td>${bill.bill_date}</td>
                    <td>${bill.total_amount}</td>
                    <td>
                        <a href="print-bill.jsp?bill=${bill.bill_number}" class="btn btn-success btn-sm" target="_blank">Print</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty bills}">
        <p>No bills found.</p>
    </c:if>
</div>

<%@ include file="../common/footer.jsp" %>
