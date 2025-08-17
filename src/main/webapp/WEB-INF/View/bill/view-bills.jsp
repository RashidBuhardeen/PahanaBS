<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.project.dao.DBConnection" %>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<style>
/* Body and container */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding-top: 60px;
    color: #222;
}

.container {
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Heading */
.container h2 {
    color: #222;
    margin-bottom: 20px;
}

/* Buttons */
.btn {
 background-color: #ff9800;
    color: #fff;
    text-decoration: none;
    padding: 8px 16px;
    margin-right: 5px;
    border-radius: 6px;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn:hover { background-color: #e68900; }




.btn-success { background-color: #4caf50; }
.btn-success:hover { background-color: #388e3c; }

/* Table styling */
.table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 20px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    border: 1px solid #ddd; /* Outer border */
}

.table th, .table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd;
}

.table th:last-child, .table td:last-child {
    border-right: none;
}

.table th {
    background-color: #222;
    color: #fff;
}

/* Hover effect */
.table tbody tr:hover {
    background-color: #ffecb3;
}

/* Rounded corners */
.table th:first-child { border-top-left-radius: 12px; }
.table th:last-child { border-top-right-radius: 12px; }
.table tbody tr:last-child td:first-child { border-bottom-left-radius: 12px; }
.table tbody tr:last-child td:last-child { border-bottom-right-radius: 12px; }

/* No data / error */
.table td[colspan] {
    text-align: center;
    font-weight: bold;
    color: #555;
}

/* Responsive table */
@media (max-width: 768px) {
    .table thead { display: none; }
    .table, .table tbody, .table tr, .table td {
        display: block;
        width: 100%;
    }
    .table tr {
        margin-bottom: 15px;
        border-bottom: 2px solid #ff9800;
    }
    .table td {
        text-align: right;
        padding-left: 50%;
        position: relative;
        border-bottom: 1px solid #ddd;
        border-right: none;
    }
    .table td::before {
        content: attr(data-label);
        position: absolute;
        left: 15px;
        width: calc(50% - 15px);
        text-align: left;
        font-weight: bold;
        color: #222;
    }
}
</style>

<div class="container">
    <h2>All Bills</h2>

    <a href="bill?action=create" class="btn btn-primary mb-3">Create New Bill</a>

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
            <%
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getInstance().getConnection();
                    st = conn.createStatement();

                    String sql = "SELECT id, customer_id, bill_date, total_amount FROM bills ORDER BY bill_date DESC";
                    rs = st.executeQuery(sql);

                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                        int billNo = rs.getInt("id");
                        String customerId = rs.getString("customer_id");
                        Date billDate = rs.getDate("bill_date");
                        double totalAmount = rs.getDouble("total_amount");
            %>
                        <tr>
                            <td><%= billNo %></td>
                            <td><%= customerId %></td>
                            <td><%= billDate %></td>
                            <td><%= totalAmount %></td>
                            <td>
                                <a href="bill?action=print&id=<%= billNo %>" class="btn btn-success btn-sm" target="_blank">Print</a>

                            </td>
                        </tr>
            <%
                    }
                    if (!hasData) {
            %>
                        <tr><td colspan="5" style="text-align:center;">No bills found.</td></tr>
            <%
                    }

                } catch (Exception e) {
                    out.println("<tr><td colspan='5' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                    if (st != null) try { st.close(); } catch (Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
                }
            %>
        </tbody>
    </table>
</div>
