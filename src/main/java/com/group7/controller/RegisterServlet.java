package com.group7.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

import com.group7.model.Role;
import com.group7.model.User;
import com.group7.model.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== REGISTRATION DEBUGGING ==========");
        System.out.println("RegisterServlet hit!");

        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String departmentIdStr = request.getParameter("department");
            String roleIdStr = request.getParameter("role");

            System.out.println("Form parameters received:");
            System.out.println("- Name: " + name);
            System.out.println("- Email: " + email);
            System.out.println("- Password: " + (password != null ? "[PROVIDED]" : "[NULL]"));
            System.out.println("- Phone: " + phone);
            System.out.println("- Department ID: " + departmentIdStr);
            System.out.println("- Role ID: " + roleIdStr);

            // Skip file upload for now to simplify debugging
            System.out.println("Skipping file upload for debugging");

            // Create User object
            User user = new User();
            user.setName(name != null ? name.trim() : "");
            user.setEmail(email != null ? email.trim() : "");
            user.setPassword(password != null ? password.trim() : "");
            user.setPhone(phone != null ? phone.trim() : "");

            // Set default picture path
            user.setPicturePath("user_photos/default.png");

            // Parse department ID
            int departmentId = 1; // Default
            try {
                if (departmentIdStr != null && !departmentIdStr.isEmpty()) {
                    departmentId = Integer.parseInt(departmentIdStr);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error parsing department ID: " + e.getMessage());
            }
            user.setDepartmentId(departmentId);
            System.out.println("Department ID set to: " + departmentId);

            // Parse role ID
            int roleId = 3; // Default to Employee
            try {
                if (roleIdStr != null && !roleIdStr.isEmpty()) {
                    roleId = Integer.parseInt(roleIdStr);
                }
            } catch (NumberFormatException e) {
                System.out.println("Error parsing role ID: " + e.getMessage());
            }
            user.setRole(new Role(roleId));
            System.out.println("Role ID set to: " + roleId);

            // Set other required fields
            user.setActive(true);
            user.setDeleted(false);
            user.setHireDate(new Date(System.currentTimeMillis()));
//            user.setSalary(new BigDecimal("0.00"));

            System.out.println("User object created successfully");
            System.out.println("Attempting to register user...");

            // Register user
            boolean registered = UserDAO.registerUser(user);
            System.out.println("Registration result: " + (registered ? "SUCCESS" : "FAILED"));

            if (registered) {
                System.out.println("Registration successful, automatically logging in user");
                // Get the newly registered user
                User loggedInUser = UserDAO.getUserByEmail(user.getEmail());

                if (loggedInUser != null) {
                    // Create a session and log in the user automatically
                    HttpSession session = request.getSession();
                    session.setAttribute("user", loggedInUser);
                    session.setMaxInactiveInterval(30 * 60);

                    // Redirect to dashboard
                    response.sendRedirect("dashboard.jsp");
                } else {
                    // Fallback to login page if user retrieval fails
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Registration successful. Please login.");
                    response.sendRedirect("login.jsp");
                }
            } else {
                System.out.println("Forwarding back to registration page with error");
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION OCCURRED: " + e.getClass().getName());
            System.out.println("Error message: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        System.out.println("========== END DEBUGGING ==========");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}