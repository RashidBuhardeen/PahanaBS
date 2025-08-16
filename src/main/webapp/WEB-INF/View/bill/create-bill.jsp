<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<div class="container">
    <h2>Create New Bill</h2>

    <c:if test="${not empty message}">
        <div class="alert">${message}</div>
    </c:if>

    <form action="bill" method="post">
        <div class="form-group">
            <label>Customer Account No:</label>
            <input type="text" name="customer_id" required />
        </div>

        <div class="form-group">
            <label>Bill Date:</label>
            <input type="date" name="bill_date" required />
        </div>

        <div class="form-group">
            <label>Total Amount:</label>
            <input type="number" step="0.01" name="total_amount" required />
        </div>

        <!-- Optional: Add dynamic JS table to add multiple items -->
        <button type="submit" class="btn">Create Bill</button>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
