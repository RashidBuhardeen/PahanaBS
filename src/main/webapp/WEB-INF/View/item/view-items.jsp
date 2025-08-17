<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navigation.jsp" %>

<style>
/* Body and container */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding-top: 60px; /* avoid content hiding under navbar */
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

.btn:hover {
    background-color: #e68900;
}

.btn-danger {
    background-color: #d32f2f;
}

.btn-danger:hover {
    background-color: #b71c1c;
}

/* Table styling */
.table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin-top: 10px;
    border: 1px solid #ddd;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.table th, .table td {    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd;
}

.table th {
    background-color: #222;
    color: #fff;
}

.table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
}

.table tbody tr:hover {
    background-color: #ffecb3;
}

/* Rounded table corners */
.table th:first-child {
    border-top-left-radius: 12px;
}

.table th:last-child {
    border-top-right-radius: 12px;
}

.table tbody tr:last-child td:first-child {
    border-bottom-left-radius: 12px;
}

.table tbody tr:last-child td:last-child {
    border-bottom-right-radius: 12px;
}

/* Responsive table */
@media (max-width: 768px) {
    .table thead {
        display: none;
    }
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
    <h2>Book List</h2>

    <a href="items?action=new" class="btn">Add New Book</a>
    <br /><br />

    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Item Code</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Stock Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            // --- Database Connection ---
            String url = "jdbc:mysql://127.0.0.1:3306/pahanadb";
            String user = "root";
            String pass = "RashAqee21";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);

                String sql = "SELECT id, item_code, item_name, price, stock_quantity FROM items";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("item_code") %></td>
                        <td><%= rs.getString("item_name") %></td>
                        <td><%= rs.getDouble("price") %></td>
                        <td><%= rs.getInt("stock_quantity") %></td>
                        <td>
                            <a href="items?action=edit&id=<%= rs.getInt("id") %>" class="btn">Edit</a>
                            <a href="items?action=delete&id=<%= rs.getInt("id") %>" 
                               onclick="return confirm('Are you sure you want to delete this item?');" 
                               class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>
