package com.project.controller;

import com.project.model.Item;
import com.project.service.ItemService;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;



public class ItemController extends HttpServlet {
	 private static final long serialVersionUID = 1L;

    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        // Use Singleton pattern for consistency across the project
        itemService = ItemService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    request.getRequestDispatcher("WEB-INF/views/item/add-item.jsp").forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    Item existingItem = itemService.getItemById(editId);
                    request.setAttribute("item", existingItem);
                    request.getRequestDispatcher("WEB-INF/views/item/edit-item.jsp").forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    itemService.deleteItem(deleteId);
                    response.sendRedirect("items");
                    break;

                default:
                    request.setAttribute("items", itemService.getAllItems());
                    request.getRequestDispatcher("WEB-INF/views/item/view-items.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in ItemController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("itemName");
        double price = Double.parseDouble(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

        Item item = new Item();
        item.setItemCode(itemCode);
        item.setItemName(itemName);
        item.setPrice(price);
        item.setStockQuantity(stockQuantity);

        try {
            if (idStr == null || idStr.isEmpty()) {
                itemService.addItem(item);
            } else {
                item.setId(Integer.parseInt(idStr));
                itemService.updateItem(item);
            }
        } catch (Exception e) {
            throw new ServletException("Error in ItemController", e);
        }

        response.sendRedirect("items");
    }
}
