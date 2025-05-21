package controller.admin.leaverequest;

import dao.LeaveRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/leave-request-action")
public class LeaveRequestActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get leave request ID and action parameters
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");

        // Validate parameters
        if (idParam == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            int leaveRequestId = Integer.parseInt(idParam);

            // Determine status based on action
            String status;
            switch (action.toLowerCase()) {
                case "approve":
                    status = "Approved";
                    break;
                case "reject":
                    status = "Rejected";
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
                    return;
            }

            // Update leave request status
            boolean updated = LeaveRequestDAO.setActionOnLeaveRequest(leaveRequestId, status);

            if (!updated) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update leave request status");
                return;
            }

            // Redirect back to the leave requests page
            response.sendRedirect(request.getContextPath() + "/admin-leave-request");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID parameter");
        }
    }
}
