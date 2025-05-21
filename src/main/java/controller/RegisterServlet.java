package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

@WebServlet("/register")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 50,
        fileSizeThreshold = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 100
)
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            Part picture = request.getPart("photo");

            byte[] pictureData = null;
            try (InputStream is = picture.getInputStream()) {
                pictureData = is.readAllBytes();
            }

            User user = new User();
            user.setName(name != null ? name.trim() : "");
            user.setEmail(email != null ? email.trim() : "");
            user.setPassword(password != null ? password.trim() : "");
            user.setPhone(phone != null ? phone.trim() : "");
            user.setPicturePath(pictureData);
            user.setDepartmentId(departmentId);
            user.setRole(roleId);
            user.setActive(true);
            user.setDeleted(false);
            user.setHireDate(new Date(System.currentTimeMillis()));

            boolean registered = UserDAO.registerUser(user);

            if (registered) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful. Please login.");
                response.sendRedirect("login");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("view/register.jsp");
    }
}
