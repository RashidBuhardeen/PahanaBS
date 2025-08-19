<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.project.dao.DBConnectionFactory" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cashier Dashboard</title>
<style>
/* ========= Design tokens ========= */
:root{
  --bg:#0f1115;
  --bg-grad: radial-gradient(1200px 600px at 10% 0%, #1c2230 0%, transparent 55%),
             radial-gradient(1200px 600px at 90% 0%, #181f2a 0%, transparent 55%),
             linear-gradient(#0f1115, #0f1115);
  --surface:#141823;
  --surface-2:#1a2030;
  --border:#242a3a;
  --text:#e7ecf3;
  --muted:#aab3c5;
  --accent:#ff9800;
  --accent-600:#e68900;
  --accent-700:#cc7b00;
  --ring: rgba(255,152,0,.45);
  --shadow: 0 10px 30px rgba(0,0,0,.35);
}

/* ========= Global reset & base ========= */
* { box-sizing: border-box; }
html, body { height: 100%; }
body{
  margin:0;
  color:var(--text);
  background:var(--bg-grad);
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Apple Color Emoji","Segoe UI Emoji";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* ========= Top section ========= */
.wrap{
  max-width:1200px;
  margin:28px auto 10px;
  padding:0 20px 8px;
}
h1{
  margin:0;
  font-weight:700;
  letter-spacing:.3px;
  text-align:center;
  font-size: clamp(22px, 3.5vw, 32px);
  background: linear-gradient(180deg, #fff, #cfd6e6);
  -webkit-background-clip:text;
  background-clip:text;
  color:transparent;
}
.subtitle{
  text-align:center;
  color:var(--muted);
  margin:8px 0 18px;
  font-size:14px;
}

/* ========= Actions (Add / Logout) ========= */
.actions{
  display:flex; gap:12px; flex-wrap:wrap; justify-content:center; margin:14px 0 28px;
}
.actions a, .btn{
  --btn-bg: var(--accent);
  --btn-fg: #0e0e0e;
  display:inline-flex; align-items:center; justify-content:center;
  text-decoration:none;
  padding:10px 16px;
  font-weight:600; letter-spacing:.2px;
  color:var(--btn-fg);
  background:linear-gradient(180deg, var(--btn-bg), var(--accent-600));
  border:1px solid rgba(0,0,0,.15);
  border-radius:10px;
  box-shadow: 0 6px 16px rgba(255,152,0,.18);
  transition: transform .08s ease, box-shadow .2s ease, filter .2s ease;
  cursor:pointer;
}
.actions a:hover, .btn:hover{
  filter: brightness(1.02);
  box-shadow: 0 10px 24px rgba(255,152,0,.22);
  transform: translateY(-1px);
}
.actions a:active, .btn:active { transform: translateY(0); }

/* Optional ghost style (add class="btn btn--ghost" if you want outline buttons) */
.btn--ghost{
  --btn-bg: transparent;
  color:var(--text);
  background:transparent;
  border:1px solid var(--border);
  box-shadow:none;
}
.btn--ghost:hover{
  border-color: #323b52;
  background: rgba(255,255,255,.03);
}

/* ========= Main card ========= */
.container{
  max-width: 1000px;
  margin: 16px auto 40px;
  padding: 28px 28px 32px;
  background: linear-gradient(180deg, rgba(255,255,255,.02), rgba(255,255,255,.01)) , var(--surface);
  border:1px solid var(--border);
  border-radius:16px;
  box-shadow: var(--shadow);
  animation: fadeIn .24s ease-out;
}
@keyframes fadeIn { from{opacity:.0; transform: translateY(4px);} to{opacity:1; transform:none;} }

.container h2, .container h3{
  color: #f2f6ff;
  margin: 0 0 18px;
  text-align:center;
  font-size: clamp(18px, 2.8vw, 22px);
}

/* ========= Forms ========= */
label{
  font-weight:700;
  display:block;
  margin: 12px 0 8px;
  color:#d8deea;
}
select, input[type="text"], input[type="number"], input[type="email"]{
  width:100%;
  padding:12px 12px;
  font-size:14px;
  color: var(--text);
  background: var(--surface-2);
  border:1px solid var(--border);
  border-radius:10px;
  outline:none;
  transition: border-color .18s ease, box-shadow .18s ease, background .18s ease;
}
select:focus, input:focus{
  border-color: var(--accent);
  box-shadow: 0 0 0 3px var(--ring);
}
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button{ -webkit-appearance:none; margin:0; }
input[type="number"]{ -moz-appearance: textfield; }

/* Submit */
input[type="submit"]{
  appearance:none;
  margin-top:10px;
  width:100%;
  padding:12px 18px;
  font-size:15px;
  font-weight:700;
  border-radius:12px;
  border:1px solid rgba(0,0,0,.15);
  color:#0e0e0e;
  background:linear-gradient(180deg, var(--accent), var(--accent-700));
  box-shadow: 0 8px 22px rgba(255,152,0,.22);
  cursor:pointer;
  transition: transform .08s ease, box-shadow .2s ease, filter .2s ease;
}
input[type="submit"]:hover{ filter:brightness(1.02); transform: translateY(-1px); }
input[type="submit"]:active{ transform:none; }

/* ========= Table ========= */
table{
  width:100%;
  border-collapse: collapse;
  margin-top:14px;
  border:1px solid var(--border);
  border-radius:14px;
  overflow: hidden;
  background: var(--surface-2);
  box-shadow: 0 6px 18px rgba(0,0,0,.25);
}
thead th{
  position: sticky; top:0; z-index:1;
  background: linear-gradient(180deg, #1e2536, #1a2030);
  color:#eaf1ff;
  border-bottom:1px solid #2b3347;
  text-transform:uppercase;
  letter-spacing:.35px;
  font-size:12px;
  padding:13px 14px;
}
td{
  padding:12px 14px;
  border-bottom:1px solid #212739;
  color:#d9e2f2;
}
tbody tr:nth-child(even){ background: rgba(255,255,255,.02); }
tbody tr:hover{ background: rgba(255,152,0,.09); }

/* Compact cells for controls */
td:first-child, th:first-child { width:86px; }
.qty{ max-width:110px; }

/* Pretty checkboxes */
.row-check{
  width:18px; height:18px;
  accent-color: var(--accent);
  transform: translateY(2px);
}

/* ========= Summary ========= */
#bill-summary{
  margin-top:22px;
  padding:16px 18px;
  border:1px solid var(--border);
  border-radius:12px;
  background: linear-gradient(180deg, rgba(255,255,255,.02), rgba(255,255,255,.015)) , var(--surface-2);
  display:flex; align-items:center; justify-content:space-between; gap:10px;
}
#bill-summary p{ margin:0; }
#grand{
  font-weight:800;
  font-variant-numeric: tabular-nums;
  letter-spacing:.3px;
}

/* ========= Alerts ========= */
.notice, .error{
  padding:10px 12px;
  border-radius:10px;
  margin: 8px 0 12px;
  font-weight:600;
}
.error{
  color:#ffd9de;
  background: #3a1a22;
  border:1px solid #6b2231;
}
.notice{
  color:#e7fff8;
  background:#173a31;
  border:1px solid #1e5a4d;
}

/* ========= Responsive ========= */
@media (max-width: 960px){
  .container{ margin: 14px 12px 28px; padding:22px; }
}
@media (max-width: 768px){
  /* stacked table for small screens (your original behavior) */
  table, tbody, tr, td, th{ display:block; width:100%; }
  thead{ display:none; }
  tr{ margin-bottom:12px; border:1px solid var(--border); border-radius:10px; overflow:hidden; }
  td{
    border:none; border-bottom:1px dashed #2b3347;
    position:relative; padding-left:44%;
    min-height:44px; display:flex; align-items:center;
  }
  td::before{
    content: attr(data-label);
    position:absolute; left:12px; top:0; bottom:0;
    display:flex; align-items:center;
    font-weight:700; color:#cbd6ea;
  }
  td:last-child{ border-bottom:none; }
  .qty{ max-width:100%; }
}

/* ========= Utility: data-label for mobile without editing JSP ========= */
tbody td:nth-child(1){ counter-reset: label "Select"; }
tbody td:nth-child(2){ counter-reset: label "Book Name"; }
tbody td:nth-child(3){ counter-reset: label "Price"; }
tbody td:nth-child(4){ counter-reset: label "In Stock"; }
tbody td:nth-child(5){ counter-reset: label "Qty"; }
tbody td:nth-child(6){ counter-reset: label "Line Total"; }
@media (max-width:768px){
  tbody td::before{ content: counter(label); } /* uses the counter set above as pseudo content */
}
</style>

</head>
<body>


<div class="wrap">
  <h1>Cashier Dashboard</h1>
  <p class="subtitle">
    Welcome, <b><c:out value="${sessionScope.username}" default="Cashier"/></b>
    
  </p>

 <div class="actions">
  <a class="btn" href="<c:url value='/cashier?action=addCustomer'/>">Add Customer</a>
  <a href="logout?action=logout">Logout</a>
</div>

</div>
 
 <div class="container">
    <h2>Create Bill</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color:#b00020;margin-bottom:12px;"><strong><%=request.getAttribute("error")%></strong></p>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/cashier" id="billForm">
        <input type="hidden" name="action" value="submitBill"/>

        <!-- Customer -->
        <label>Select Customer:</label>
        <select name="account_no" required>
            <option value="">--Select Customer--</option>
            <%
                try (Connection conn = DBConnectionFactory.getConnection();
                     Statement st = conn.createStatement();
                     ResultSet rs = st.executeQuery("SELECT account_no, name FROM customer ORDER BY name ASC")) {
                    while (rs.next()) {
            %>
                <option value="<%=rs.getString("account_no")%>">
                    <%=rs.getString("name")%> (<%=rs.getString("account_no")%>)
                </option>
            <%
                    }
                } catch (Exception e) {
            %>
                <option value="">Error loading customers</option>
            <%
                }
            %>
        </select>

        <!-- Items -->
        <h3>Select Books</h3>
        <table>
            <thead>
            <tr>
                <th>Select</th>
                <th>Book Name</th>
                <th>Price</th>
                <th>In Stock</th>
                <th>Qty</th>
                <th>Line Total</th>
            </tr>
            </thead>
            <tbody>
            <%
                try (Connection conn = DBConnectionFactory.getConnection();
                     Statement st = conn.createStatement();
                     ResultSet rs = st.executeQuery("SELECT id, item_name, price, stock_quantity FROM items ORDER BY item_name ASC")) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("item_name");
                        double price = rs.getDouble("price");
                        int stock = rs.getInt("stock_quantity");
            %>
                <tr>
                    <td>
                        <input type="checkbox" name="item_ids" value="<%=id%>" class="row-check">
                        <input type="hidden" name="price_<%=id%>" value="<%=price%>">
                    </td>
                    <td><%=name%></td>
                    <td>Rs. <span class="p" data-id="<%=id%>"><%=price%></span></td>
                    <td><%=stock%></td>
                    <td>
                        <input type="number" name="qty_<%=id%>" min="0" max="<%=stock%>" value="0" class="qty" data-id="<%=id%>">
                    </td>
                    <td>Rs. <span class="line" data-id="<%=id%>">0.00</span></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
            %>
                <tr><td colspan="6">Error loading items</td></tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div id="bill-summary">
            <p><strong>Total:</strong> Rs. <span id="grand">0.00</span></p>
        </div>

        <br>
        <input type="submit" value="Create Bill">
    </form>
</div>

<script>
(function(){
  function toNum(x){ return Number(x || 0); }
  function fmt(n){ return toNum(n).toFixed(2); }

  function recalc(){
    let grand = 0;
    document.querySelectorAll('.qty').forEach(inp=>{
      const id = inp.getAttribute('data-id');
      const qty = toNum(inp.value);
      const price = toNum(document.querySelector('.p[data-id="'+id+'"]').textContent);
      const checked = document.querySelector('.row-check[value="'+id+'"]').checked;
      const line = checked && qty>0 ? qty*price : 0;
      document.querySelector('.line[data-id="'+id+'"]').textContent = fmt(line);
      grand += line;
    });
    document.getElementById('grand').textContent = fmt(grand);
  }

  document.addEventListener('input', e=>{
    if(e.target.classList.contains('qty')) recalc();
  });
  document.addEventListener('change', e=>{
    if(e.target.classList.contains('row-check')) recalc();
  });
})();
</script>

<script>
(function(){
  const form = document.getElementById('billForm');
  form.addEventListener('submit', function () {
    // Open (or reuse) a named tab *synchronously* in direct response to the user's action.
    // This won't get blocked by popup blockers.
    window.open('about:blank', 'billPrintTab'); 
  });
})();
</script>

</body>
</html>
