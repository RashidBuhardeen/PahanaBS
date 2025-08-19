<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Bill</title>
    <link rel="stylesheet" href="../css/style.css">
</head>

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
    max-width: 900px;
    margin: 30px auto;
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Headings */
.container h2, .container h3 {
    color: #222;
    margin-bottom: 20px;
    text-align: center;
}

/* Form elements */
form label {
    font-weight: bold;
    display: block;
    margin-bottom: 6px;
}

form select, 
form input[type="text"], 
form input[type="number"], 
form input[type="email"] {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s, box-shadow 0.3s;
}

form select:focus, 
form input:focus {
    border-color: #ff9800;
    box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
    outline: none;
}

/* Buttons */
input[type="submit"] {
    background-color: #ff9800;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

input[type="submit"]:hover {
    background-color: #e68900;
}

/* Table styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

table th, table td {
    padding: 12px 15px;
    border: 1px solid #ddd;
    text-align: left;
}

table th {
    background-color: #222;
    color: #fff;
}

table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
}

table tbody tr:hover {
    background-color: #ffecb3;
}

/* Bill summary */
#bill-summary {
    margin-top: 25px;
    padding: 15px;
    border: 1px solid #ccc;
    border-radius: 12px;
    background-color: #f9f9f9;
}

#bill-summary p {
    margin: 6px 0;
}

/* Responsive */
@media (max-width: 768px) {
    table, table tbody, table tr, table td, table th {
        display: block;
        width: 100%;
    }

    table tr {
        margin-bottom: 15px;
    }

    table td::before {
        content: attr(data-label);
        font-weight: bold;
        display: inline-block;
        width: 120px;
    }
}
</style>

<body>
<div class="container">
    <h2>Create Bill</h2>
    <form method="post" action="bill?action=create">
        <!-- Select Customer -->
        <label>Select Customer:</label>
        <select name="account_no" required>
            <option value="">--Select Customer--</option>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/pahanadb","root","RashAqee21");
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("SELECT account_no, name FROM customer");
                    while(rs.next()){
            %>
                        <option value="<%=rs.getString("account_no")%>">
                            <%=rs.getString("name")%>
                        </option>
            <%
                    }
                    conn.close();
                } catch(Exception e){
                    out.println("<option>Error loading customers</option>");
                }
            %>
        </select>
        <br><br>

        <!-- Select Books/Items -->
        <h3>Select Books:</h3>
<%
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/pahanadb","root","RashAqee21");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT id, item_name, price, stock_quantity FROM items");
%>
<table>
  <tr>
    <th>Select</th>
    <th>Book Name</th>
    <th>Price</th>
    <th>In Stock</th>
    <th>Quantity</th>
  </tr>
<%
        while (rs.next()) {
            int id = rs.getInt("id");
            String itemName = rs.getString("item_name");
            double price = rs.getDouble("price");
            int stock = rs.getInt("stock_quantity");
%>
  <tr>
    <td>
      <input type="checkbox" name="item_ids" value="<%=id%>">
      <input type="hidden" name="price_<%=id%>" value="<%=price%>">
    </td>
    <td><%=itemName%></td>
    <td>Rs. <%=price%></td>
    <td><%=stock%></td>
    <td><input type="number" name="qty_<%=id%>" min="0" max="<%=stock%>" value="0"></td>
  </tr>
<%
        }
        conn.close();
    } catch(Exception e){
        out.println("<tr><td colspan='5'>Error loading items</td></tr>");
    }
%>
</table>

        <br>
        <input type="submit" name="calculate" value="Calculate Bill">
    </form>

    <hr>

    <%
        if(request.getParameter("calculate") != null){
            String accountNo = request.getParameter("account_no");
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanadb","root","password");

                PreparedStatement psCustomer = conn.prepareStatement("SELECT * FROM customer WHERE account_no=?");
                psCustomer.setString(1, accountNo);
                ResultSet rsCustomer = psCustomer.executeQuery();

                if(rsCustomer.next()){
                    String name = rsCustomer.getString("name");
                    String address = rsCustomer.getString("address");
                    String telephone = rsCustomer.getString("telephone_number");

                    double total = 0.0;
                    StringBuilder billItems = new StringBuilder();

                    Statement stItems = conn.createStatement();
                    ResultSet rsItems = stItems.executeQuery("SELECT item_name, price FROM items");
                    while(rsItems.next()){
                        String itemName = rsItems.getString("item_name");
                        double price = rsItems.getDouble("price");

                        String itemParam = request.getParameter("item_" + itemName.replaceAll(" ","_"));
                        String qtyParam = request.getParameter("qty_" + itemName.replaceAll(" ","_"));
                        int qty = 0;
                        if(qtyParam != null && !qtyParam.isEmpty()){
                            qty = Integer.parseInt(qtyParam);
                        }

                        if(itemParam != null && qty > 0){
                            double itemTotal = price * qty;
                            total += itemTotal;
                            billItems.append(itemName + " x " + qty + " = Rs." + itemTotal + "<br>");
                        }
                    }

                    // Display bill
    %>
                    <h3>Bill Summary</h3>
                    <p>Customer: <%=name%></p>
                    <p>Address: <%=address%></p>
                    <p>Telephone: <%=telephone%></p>
                    <hr>
                    <%=billItems.toString() %>
                    <p><strong>Total Amount: Rs. <%=total%></strong></p>

                    <!-- Hidden form to print bill -->
                    <form method="get" action="print-bill.jsp">
                        <input type="hidden" name="account_no" value="<%=accountNo%>">
                        <input type="hidden" name="bill_items" value="<%=billItems.toString().replace("\"","'")%>">
                        <input type="hidden" name="total_amount" value="<%=total%>">
                        <input type="submit" value="Print Bill">
                    </form>
    <%
                } else {
                    out.println("<p>Customer not found!</p>");
                }
                conn.close();
            } catch(Exception e){
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

</div>

</body>
</html>
