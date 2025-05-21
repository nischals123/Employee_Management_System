package controller.admin.leaverequest;

import dao.LeaveRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LeaveRequest;
import model.User;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@WebServlet("/admin-leave-request")
public class GetAllLeaveRequestsServlet extends HttpServlet {

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

        List<LeaveRequest> leaveRequests = LeaveRequestDAO.getAllLeaveRequests();

        // calculating the total days of leave
        for (LeaveRequest leaveRequest : leaveRequests) {
            // Convert java.sql.Date to java.time.LocalDate
            LocalDate startDate = leaveRequest.getStartDate().toLocalDate();
            LocalDate endDate = leaveRequest.getEndDate().toLocalDate();

            // Calculate total days
            long totalDays = ChronoUnit.DAYS.between(startDate, endDate) + 1; // +1 to include both start and end date

            // Set the total days in the LeaveRequest object
            leaveRequest.setTotalDays(totalDays);
        }

        request.setAttribute("leaveRequests", leaveRequests);

        // Forward to JSP
        request.getRequestDispatcher("view/admin/leave-requests.jsp").forward(request, response);
    }
}
