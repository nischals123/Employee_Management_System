package controller;

import dao.LeaveRequestDAO;
import model.LeaveRequest;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/LeaveRequestServlet")
public class LeaveRequestServlet extends HttpServlet {

//    leave_request_id from_date till_date leave_type reason status admin_remarks  user_id

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve leave requests for the logged-in user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        // Get user's leave requests
        List<LeaveRequest> leaveRequests = LeaveRequestDAO.getUserLeaveHistory(user.getId());
//        System.out.println(leaveRequests + "from do get");
        request.setAttribute("leaveRequests", leaveRequests);

        // Forward to JSP
        request.getRequestDispatcher("view/user/pages/leave-request.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        String action = request.getParameter("action");

        if ("submit".equals(action)) {
            try {
                // Retrieve form parameters
                int userId = Integer.parseInt(request.getParameter("userId"));
                Date startDate = Date.valueOf(request.getParameter("fromDate"));
                Date endDate = Date.valueOf(request.getParameter("tillDate"));
                String leaveType = request.getParameter("leaveType");
                String reason = request.getParameter("reason");

                System.out.println(userId);
                System.out.println(startDate);
                System.out.println(endDate);
                System.out.println(leaveType);
                System.out.println(reason);

                // Validate inputs
                if (startDate.after(endDate)) {
                    request.setAttribute("errorMessage", "Till Date must be after From Date.");
                    loadLeaveRequestsAndForward(request, response, user.getId());
                    return;
                }

                // Create LeaveRequest object
                LeaveRequest leaveRequest = new LeaveRequest(userId, startDate, endDate, leaveType, reason);

                // Submit leave request
                boolean success = LeaveRequestDAO.submitLeaveRequest(leaveRequest);

                if (success) {
                    request.setAttribute("successMessage", "Leave request submitted successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to submit leave request. Please try again.");
                }

            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD.");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "An error occurred while processing your request.");
                e.printStackTrace();
            }

            // Reload leave requests and forward to JSP
            loadLeaveRequestsAndForward(request, response, user.getId());
        }
    }

    private void loadLeaveRequestsAndForward(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        // Load user's leave requests
        List<LeaveRequest> leaveRequests = LeaveRequestDAO.getUserLeaveHistory(userId);
        System.out.println(leaveRequests + " loading leave requests");
        request.setAttribute("leaveRequests", leaveRequests);
        request.getRequestDispatcher("/view/user/pages/leave-request.jsp").forward(request, response);
    }
}