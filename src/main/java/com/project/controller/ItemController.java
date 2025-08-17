package com.project.controller;

import com.project.model.Item;
import com.project.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/items")
public class ItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemService itemService;

    private static final String VIEW_PATH = "WEB-INF/View/item/";

    @Override
    public void init() throws ServletException {
        itemService = ItemService.getInstance(); // Singleton
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher(VIEW_PATH + "add-item.jsp").forward(req, resp);
                    return;
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("item", itemService.getItemById(editId));
                    req.getRequestDispatcher(VIEW_PATH + "edit-item.jsp").forward(req, resp);
                    return;
                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    itemService.deleteItem(deleteId);
                    resp.sendRedirect("items");
                    return;
                default:
                    req.setAttribute("items", itemService.getAllItems());
                    req.getRequestDispatcher(VIEW_PATH + "view-items.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error handling item action: " + action, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");

        try {
            Item item = new Item();
            item.setItemCode(req.getParameter("itemCode"));
            item.setItemName(req.getParameter("itemName"));
            item.setPrice(Double.parseDouble(req.getParameter("price")));
            item.setStockQuantity(Integer.parseInt(req.getParameter("stockQuantity")));

            if (idStr == null || idStr.isEmpty()) {
                itemService.addItem(item);
            } else {
                item.setId(Integer.parseInt(idStr));
                itemService.updateItem(item);
            }

            resp.sendRedirect("navigate?action=items");
        } catch (Exception e) {
            throw new ServletException("Error saving item", e);
        }
    }
}
