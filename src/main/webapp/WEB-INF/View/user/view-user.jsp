<%@ page import="java.sql.*, com.project.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    min-height: 100vh;
}

.container {
    max-width: 1200px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.container h2 {
    color: #222;
    margin-bottom: 20px;
}

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

/* Table */
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
.table th, .table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    border-right: 1px solid #ddd;
}
.table th:last-child,
.table td:last-child {
    border-right: none;
}
.table th {
    background-color: #222;
    color: #fff;
}
.table tbody tr:hover {
    background-color: #ffecb3;
}

/* Responsive */
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
    <h2>User List</h2>

    <a href="user?action=addUser" class="btn">Add New User</a>
    <br /><br />

    <table class="table">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Role</th>
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
                    rs = st.executeQuery("SELECT id, username, role FROM users");

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String userName = rs.getString("username");
                        String role = rs.getString("role");
                    %>
                        <tr>
                            <td data-label="User ID"><%= id %></td>
                            <td data-label="Username"><%= userName %></td>
                            <td data-label="Role"><%= role %></td>
                            <td data-label="Actions">
                                <a href="user?action=editUser&id=<%= id %>" class="btn">Edit</a>
                                <a href="user?action=deleteUser&id=<%= id %>" class="btn btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                            </td>
                        </tr>
                    <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
                    if (st != null) try { st.close(); } catch (Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
                }
            %>
        </tbody>
    </table>
</div>
