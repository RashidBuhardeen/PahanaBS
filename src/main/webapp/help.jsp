<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Cashier Help — Basic Instructions</title>
  <style>
    /* Minimal, readable defaults */
    body { font-family: Arial, sans-serif; margin: 16px; line-height: 1.6; color:#222; }
    .container { max-width: 860px; margin: 0 auto; }
    h1 { font-size: 22px; margin: 0 0 6px; }
    h2 { font-size: 18px; margin: 18px 0 8px; }
    hr { margin: 14px 0; }
    ul, ol { padding-left: 20px; }
    .muted { color:#666; font-size: 12px; }
    a { color:#0645ad; text-decoration:none; }
    a:hover { text-decoration:underline; }
  </style>
</head>
<body>
  <div class="container">
    <h1>Cashier Help — Instructions</h1>
    <p class="muted">
      Signed in as <b>${sessionScope.username != null ? sessionScope.username : "Cashier"}</b>
      &nbsp;|&nbsp; <a href="index.jsp">Back to Dashboard</a>
    </p>
    <hr />

    <h2>Quick Start</h2>
    <ol>
      <li>Open <b>Create Bill</b> on the dashboard.</li>
      <li>Select a <b>Customer</b> from the dropdown.</li>
      <li>In the books table, <b>tick Select</b> for each book and enter a <b>Qty</b>.</li>
      <li>Check the <b>Total</b> at the bottom.</li>
      <li>Click <b>Create Bill</b> and print from the tab that opens.</li>
    </ol>

    <h2>Creating a Bill</h2>
    <h3>1) Choose Customer</h3>
    <ul>
      <li>Open <b>Select Customer</b> and pick the correct <b>Name (Account No.)</b>.</li>
      <li>If the customer is missing, add them first (see <i>Adding a Customer</i> below).</li>
    </ul>

    <h3>2) Add Books</h3>
    <ol>
      <li>For each book you want to sell:
        <ul>
          <li><b>Tick Select</b> to include it in the bill.</li>
          <li>Enter a <b>Qty</b> greater than <b>0</b> (0 means not included).</li>
          <li>Ensure <b>Qty ≤ In Stock</b> (no overselling).</li>
        </ul>
      </li>
      <li><b>Line Total</b> appears when the row is selected and Qty &gt; 0.</li>
      <li><b>Grand Total</b> at the bottom adds all selected line totals.</li>
    </ol>

    <h3>3) Submit &amp; Print</h3>
    <ol>
      <li>Click <b>Create Bill</b>.</li>
      <li>A new tab opens for printing. If it doesn’t, allow pop-ups and submit again.</li>
    </ol>

    <h2>Adding a Customer</h2>
    <ol>
      <li>Click <b>Add Customer</b> from the dashboard.</li>
      <li>Fill the required fields: <b>Account Number</b>, <b>Name</b>, <b>Address</b>, <b>Telephone</b>, <b>Email</b>.</li>
      <li>Click <b>Add Customer</b> to save.</li>
      <li>On success, you’ll see a green message. If a red error appears, fix inputs and try again.</li>
      <li>Use <b>Cancel</b> to clear and go back without saving.</li>
    </ol>

    <h2>Important Rules</h2>
    <ul>
      <li>An item is billed <b>only if</b> <b>Select</b> is ticked <b>and</b> <b>Qty &gt; 0</b>.</li>
      <li><b>Qty cannot exceed In Stock</b>.</li>
      <li>Prices are in <b>Rs.</b>; totals are calculated automatically.</li>
      <li>On mobile, the table stacks; each cell shows its label (Select, Book Name, Price, In Stock, Qty, Line Total).</li>
    </ul>

    <h2>Troubleshooting</h2>
    <ul>
      <li><b>Total stays Rs. 0.00</b> — Ensure the row is <b>ticked</b> and <b>Qty &gt; 0</b>.</li>
      <li><b>Can’t enter a larger Qty</b> — You reached the <b>In Stock</b> limit; reduce Qty or restock.</li>
      <li><b>Print tab didn’t open</b> — Allow pop-ups for this site; submit the bill again.</li>
      <li><b>“Error loading customers/items”</b> — Possible database issue. Stop billing and inform the administrator.</li>
      <li><b>Form won’t submit</b> — Check that all required fields are filled (especially customer selection).</li>
    </ul>

    <h2>Good Practice</h2>
    <ul>
      <li>Double-check <b>customer</b>, <b>items</b>, <b>quantities</b>, and <b>Grand Total</b> before submitting.</li>
      <li>If anything looks wrong (stock, price, names), pause and inform the administrator.</li>
      <li><b>Logout</b> when your shift ends.</li>
    </ul>

    <hr />
    <p class="muted">
      Need help? Contact your administrator. &nbsp;|&nbsp;
      <a href="index.jsp">Back to Dashboard</a>
     </p>
  </div>
</body>
</html>
