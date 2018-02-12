package com.daraz.controller.admin;

import com.daraz.bean.BuyerOrderBean;
import com.daraz.bean.CategoryBean;
import com.daraz.bean.ManufacturerBean;
import com.daraz.bean.OrderBean;
import com.daraz.dao.BuyerOrderDAO;
import com.daraz.dao.CategoryDAO;
import com.daraz.dao.ManufacturerDAO;
import com.daraz.dao.OrderDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin/orders"})
public class OrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            byte role = (byte) session.getAttribute("role");
            if (role == (byte) 1) {
                ArrayList<ManufacturerBean> manufacturers = (new ManufacturerDAO()).readAll();
                ArrayList<CategoryBean> categories = (new CategoryDAO()).readAll();
                ArrayList<BuyerOrderBean> buyerOrders = (new BuyerOrderDAO()).readByBuyerId((long) session.getAttribute("roleId"));
                request.setAttribute("manufacturers", manufacturers);
                request.setAttribute("categories", categories);
                request.setAttribute("buyerOrders", buyerOrders);
                getServletContext().getRequestDispatcher("/WEB-INF/admin/orders.jsp").forward(request, response);
            } else {
                getServletContext().getRequestDispatcher("/public/logout").forward(request, response);
            }
        } else {
            getServletContext().getRequestDispatcher("/public/logout").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            byte role = (byte) session.getAttribute("role");
            if (role == (byte) 1) {
                long buyerOrderId = Long.parseLong(request.getParameter("buyerOrderId").trim());
                long manufacturerId = Long.parseLong(request.getParameter("manufacturerId").trim());
                long categoryId = Long.parseLong(request.getParameter("categoryId").trim());
                byte status = Byte.parseByte(request.getParameter("status").trim());
                ArrayList<OrderBean> orders = (new OrderDAO()).readWithParameters(buyerOrderId, manufacturerId, categoryId, status);
                request.setAttribute("orders", orders);
                doGet(request, response);
            } else {
                getServletContext().getRequestDispatcher("/public/logout").forward(request, response);
            }
        } else {
            getServletContext().getRequestDispatcher("/public/logout").forward(request, response);
        }
    }

}
