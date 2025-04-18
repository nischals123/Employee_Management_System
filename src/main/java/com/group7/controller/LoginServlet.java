package com.group7.controller;

import com.group7.model.User;
import com.group7.model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        User user = UserDAO.validateUser(email, password);

        if (user != null && user.isActive()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);

            
            if (user.getRole() == 1) {
                response.sendRedirect("view/admin/admin-dashboard.jsp");
            } else {
                response.sendRedirect("view/user/user-dashboard.jsp");
            }

        } else {
            request.setAttribute("error", "Invalid credentials or user is inactive.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
