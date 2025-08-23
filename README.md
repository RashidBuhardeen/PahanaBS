```markdown
# 📚 Pahana Book Shop Management System

PahanaBS is a **Java-based web application** for managing bookshop operations, developed with **JSP, Servlets, and MySQL**. It provides role-based dashboards for administrators and cashiers, with features for handling customers, items (books), users, and billing.  

---

## ✨ Features

- 🔐 **User Authentication**  
  Secure login/logout with session management.  

- 🛠 **Role-Based Dashboards**  
  - **Admin:** Manage users, customers, items, and bills.  
  - **Cashier:** Add customers, create bills, print bills.  

- 📑 **Customer Management**  
  Add, update, delete, and search customer records.  

- 📦 **Item (Book) Management**  
  Add, edit, delete, and view books with stock tracking.  

- 🧾 **Billing System**  
  Create and print invoices with stock validation.  

- 📊 **Responsive UI**  
  Simple, lightweight design without external frameworks.  

---

## 🗂 Project Structure

```

PahanaBS/
│── src/main/java/com/project/       # Java source (controllers, DAO, models, services)
│── src/main/webapp/WEB-INF/View/    # JSP views (dashboard, login, bill, user, customer, item)
│── src/main/webapp/css/             # Custom CSS styles
│── src/main/webapp/WEB-INF/web.xml  # Web app configuration
│── pom.xml                          # Maven project config

````

---

## ⚙️ Prerequisites

- ☕ **Java 17**  
- 🐱 **Apache Tomcat 9**  
- 🗄 **MySQL Database**  
- 📦 **Maven**  

---

## 🚀 Setup & Deployment

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd PahanaBS
````

2. **Configure Database**

   * Create a database (e.g., `pahanadb`) in MySQL.
   * Run the SQL schema provided in `/db/schema.sql` (customers, items, bills, users).
   * Update connection settings in `DBConnectionFactory.java`.

3. **Build the project**

   ```bash
   mvn clean install
   ```

4. **Deploy to Tomcat**

   * Copy the `.war` file from `target/` into `tomcat/webapps/`.
   * Start Tomcat and access:

     ```
     http://localhost:8080/PahanaBS
     ```

---

## 🔑 Default Credentials

* **Admin Login**

  ```
  username: admin
  password: admin1
  ```

* **Cashier Login** (example from DB)

  ```
  username: cashier
  password: cashier1
  ```

---

## 📌 Future Improvements

* Add **PDF invoice export**.
* Implement **password hashing** for stronger security.
* Enhance **stock tracking** with low-stock alerts.
* Add **reporting module** for sales insights.

---

## 👨‍💻 Author

Developed by **Rashid Buhardeen** ✨
(Project: *Pahana Book Shop Management System*)
