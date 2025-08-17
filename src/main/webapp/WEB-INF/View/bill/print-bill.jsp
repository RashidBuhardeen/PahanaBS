<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.model.Bill" %>
<%@ page import="com.project.model.BillItem" %>
<%@ page import="java.util.List" %>
<%
    // Assuming bill object is passed as request attribute
    Bill bill = (Bill) request.getAttribute("bill");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Print Bill</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }
        .bill-container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2, h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .bill-info {
            margin-bottom: 20px;
        }
        .bill-info p {
            margin: 5px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #222;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background: #222;
            color: #fff;
        }
        tfoot td {
            font-weight: bold;
        }
        .print-btn {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px;
            background: #007bff;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
        }
        .print-btn:hover {
            background: #0056b3;
        }
        @media print {
            .print-btn {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="bill-container">
    <h2>Pahana Book Shop</h2>
    <h3>Bill Receipt</h3>

    <div class="bill-info">
        <p><strong>Bill Number:</strong> <%= bill.getBill_number() %></p>
        <p><strong>Customer Account:</strong> <%= bill.getCustomer_account_no() %></p>
        <p><strong>Bill Date:</strong> <%= sdf.format(bill.getBill_date()) %></p>
    </div>

    <table>
        <thead>
        <tr>
            <th>Item</th>
            <th>Price (Rs.)</th>
            <th>Quantity</th>
            <th>Total (Rs.)</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<BillItem> items = bill.getBill_items();
            double totalAmount = 0;
            for(BillItem item : items){
                double itemTotal = item.getPrice() * item.getQuantity();
                totalAmount += itemTotal;
        %>
        <tr>
            <td><%= item.getItem_code() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= itemTotal %></td>
        </tr>
        <% } %>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3" style="text-align:right;">Total Amount:</td>
            <td>Rs. <%= totalAmount %></td>
        </tr>
        </tfoot>
    </table>

    <button class="print-btn" onclick="window.print()">Print Bill</button>
</div>
</body>
</html>
