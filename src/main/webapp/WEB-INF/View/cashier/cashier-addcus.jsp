<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    
    <h2>Add New Customer</h2>

    <c:if test="${not empty param.ok}">
        <p style="color:green;margin-bottom:12px;">Customer added successfully.</p>
    </c:if>
    <c:if test="${not empty param.updated}">
        <p style="color:green;margin-bottom:12px;">Customer updated successfully.</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color:#b00020;margin-bottom:12px;"><strong>${error}</strong></p>
    </c:if>

    <form action="<%=request.getContextPath()%>/cashier" method="post">
        <input type="hidden" name="action" value="saveCustomer" />

        <div class="form-group">
            <label>Account Number:</label>
            <input type="text" name="account_no" required />
        </div>

        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" required />
        </div>

        <div class="form-group">
            <label>Address:</label>
            <textarea name="address" rows="3" required></textarea>
        </div>

        <div class="form-group">
            <label>Telephone Number:</label>
            <input type="text" name="telephone" required />
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required />
        </div>

        <button type="submit" class="btn">Add Customer</button>
        <button type="button" class="btn btn--ghost" onclick="this.form.reset(); history.back();">Cancel</button>
        
    </form>
</div>

<style>
/* ===== Design tokens ===== */
:root{
  --bg:#1b1f2a;
  --card:#ffffff;
  --text:#1b1f2a;
  --muted:#6b7280;
  --border:#e7e9f1;
  --accent:#ff9800;
  --accent-600:#e68900;
  --accent-700:#cc7b00;
  --ring: rgba(255,152,0,.35);
  --shadow: 0 10px 30px rgba(17, 24, 39, .08);
}

/* ===== Base ===== */
*{box-sizing:border-box}
body{
  margin:0;
  background:var(--bg);
  color:var(--text);
  font-family:Inter, ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial;
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
  padding-top:60px;
}

/* ===== Card ===== */
.container{
  max-width:640px;
  margin:32px auto;
  background:var(--card);
  padding:28px 28px 32px;
  border:1px solid var(--border);
  border-radius:14px;
  box-shadow:var(--shadow);
}
.container h2{
  margin:0 0 18px;
  text-align:center;
  font-size: clamp(20px, 2.8vw, 26px);
  letter-spacing:.2px;
}

/* ===== Form layout ===== */
.container form{
  display:grid;
  gap:16px;
}
.form-group{ margin:0; }
.form-group label{
  display:block;
  margin:0 0 8px;
  font-weight:700;
  color:#111827;
  letter-spacing:.2px;
}
.form-group input,
.form-group textarea{
  width:100%;
  padding:12px 12px;
  font-size:14px;
  color:var(--text);
  background:#fbfcff;
  border:1px solid var(--border);
  border-radius:10px;
  outline:none;
  transition:border-color .18s ease, box-shadow .18s ease, background .18s ease;
}
.form-group textarea{ min-height:96px; resize:vertical; }

/* Focus + hover */
.form-group input:hover,
.form-group textarea:hover{
  background:#ffffff;
  border-color:#dde2ee;
}
.form-group input:focus,
.form-group textarea:focus{
  border-color:var(--accent);
  box-shadow:0 0 0 3px var(--ring);
}

/* ===== Button ===== */
.btn{
  appearance:none;
  width:100%;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  gap:8px;
  padding:12px 18px;
  border:none;
  border-radius:12px;
  background: linear-gradient(180deg, var(--accent), var(--accent-600));
  color:#0f1115;
  font-weight:700;
  font-size:15px;
  letter-spacing:.2px;
  cursor:pointer;
  box-shadow:0 12px 24px rgba(255,152,0,.20);
  transition: transform .08s ease, filter .2s ease, box-shadow .2s ease;
}
.btn:hover{
  filter:brightness(1.02);
  transform: translateY(-1px);
  box-shadow:0 16px 28px rgba(255,152,0,.25);
}
.btn:active{ transform:none; }
.btn:focus-visible{
  outline:none;
  box-shadow:0 0 0 4px var(--ring), 0 12px 24px rgba(255,152,0,.20);
}
.btn:disabled{
  opacity:.6;
  cursor:not-allowed;
}

/* ===== Helpers (optional if you add classes) ===== */
.alert-success{
  margin:4px 0 8px;
  padding:10px 12px;
  border-radius:10px;
  background:#e9f9ef;
  color:#065f46;
  border:1px solid #c7f0d5;
  font-weight:600;
}
.alert-error{
  margin:4px 0 8px;
  padding:10px 12px;
  border-radius:10px;
  background:#fdecef;
  color:#7a1121;
  border:1px solid #f5c3cd;
  font-weight:600;
}

/* ===== Responsive: two columns on wider screens ===== */
@media (min-width: 760px){
  .container{ padding:28px 32px 34px; }
  .container form{
    grid-template-columns: 1fr 1fr;
  }
  /* Make the submit button span both columns */
  .container form .btn{
    grid-column: 1 / -1;
  }
}

/* Respect reduced motion */
@media (prefers-reduced-motion: reduce){
  *{animation-duration:.01ms !important; animation-iteration-count:1 !important; transition-duration:.01ms !important;}
}
/* Back toolbar */
.toolbar{
  display:flex;
  justify-content:flex-start;
  margin: -6px 0 14px;
}

/* Ghost/outline variant of your .btn */
.btn--ghost{
  background:#fff;
  color:var(--text);
  border:1px solid var(--border);
  box-shadow:none;
}
.btn--ghost:hover{
  filter:none;
  transform: translateY(-1px);
  background:#f8fafc;
  box-shadow:0 6px 16px rgba(17, 24, 39, .06);
}

</style>

