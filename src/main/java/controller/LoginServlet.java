package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import dao.UserDAO;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Move session message to request scope and remove it
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("successMessage") != null) {
            request.setAttribute("successMessage", session.getAttribute("successMessage"));
            session.removeAttribute("successMessage");
        }

        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
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
            session.setMaxInactiveInterval(60 * 60);

            if (user.getRole() == 1) {
                response.sendRedirect("view/admin/dashboard.jsp");
            } else {
                response.sendRedirect("view/user/pages/dashboard.jsp");
            }

        } else {
            request.setAttribute("error", "Invalid credentials or user is inactive.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }
}
