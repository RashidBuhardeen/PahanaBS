<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../common/header.jsp" %>

<div class="container">
    <h2>Bill Details</h2>

    <c:if test="${not empty bill}">
        <p><strong>Bill No:</strong> ${bill.bill_number}</p>
        <p><strong>Customer Account:</strong> ${bill.customer_account_no}</p>
        <p><strong>Date:</strong> ${bill.bill_date}</p>
        <p><strong>Total Amount:</strong> ${bill.total_amount}</p>

        <h3>Items</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${bill.bill_items}">
                    <tr>
                        <td>${item.item_code}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price}</td>
                        <td>${item.quantity * item.price}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <button class="btn" onclick="window.print()">Print Bill</button>
    </c:if>

    <c:if test="${empty bill}">
        <p>No bill found.</p>
    </c:if>
</div>

<%@ include file="../common/footer.jsp" %>
