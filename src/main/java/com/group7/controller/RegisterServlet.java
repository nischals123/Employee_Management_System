package com.group7.controller;

import com.group7.model.Role;
import com.group7.model.User;
import com.group7.model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RegisterServlet hit!");

        try {
            String name = request.getParameter("name").trim();
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();
            String phone = request.getParameter("phone").trim();

            // Check if user already exists
            if (UserDAO.getUserByEmail(email) != null) {
                request.setAttribute("error", "Email already exists. Please use another email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Handle uploaded photo
            Part photoPart = request.getPart("photo");
            String fileName = System.currentTimeMillis() + "_" + photoPart.getSubmittedFileName();

            if (fileName == null || fileName.isEmpty()) {
                request.setAttribute("error", "Image file is required.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            String uploadPath = request.getServletContext().getRealPath("/user_photos");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            System.out.println("Upload Path: " + uploadPath);
            System.out.println("File Name: " + fileName);

            photoPart.write(uploadPath + File.separator + fileName);
            String picturePath = "user_photos/" + fileName;

            // Create User
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setPicturePath(picturePath);

            // Set default role (adjust ID as needed)
            user.setRole(new Role(0)); 

            // ✅ FIX: Set valid department ID (adjust based on your DB)
            user.setDepartmentId(1); // Change 1 to any valid ID from `departments` table

            boolean registered = UserDAO.registerUser(user);

            if (registered) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful. Please login.");
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
