package controller;

import model.User;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/profile")
public class ProfileDataServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        User user = UserDAO.getUserById(sessionUser.getId());
        if (user == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Set user data as request attribute
        request.setAttribute("employee", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String errorMessage = null;
        String successMessage = null;

        // Validate current password
        User dbUser = UserDAO.validateUser(user.getEmail(), currentPassword);
        if (dbUser == null) {
            errorMessage = "Current password is incorrect.";
        } else if (!newPassword.equals(confirmPassword)) {
            errorMessage = "New passwords do not match.";
        } else {
            // Update password
            boolean updated = UserDAO.updatePassword(user.getId(), newPassword);
            if (updated) {
                successMessage = "Password updated successfully.";
            } else {
                errorMessage = "Failed to update password.";
            }
        }

        // Refresh user data
        User updatedUser = UserDAO.getUserById(user.getId());
        request.setAttribute("employee", updatedUser);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("successMessage", successMessage);

        // Forward back to profile page
        request.getRequestDispatcher("/view/user/pages/profile.jsp").forward(request, response);
    }
}