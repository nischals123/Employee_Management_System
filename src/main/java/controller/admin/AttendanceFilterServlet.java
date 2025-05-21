package controller.admin;

import dao.AttendanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Attendance;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/filter-attendance")
public class AttendanceFilterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the "month" parameter in YYYY-MM format
        String monthParam = request.getParameter("month-filter");

        // Validate the input
        if (monthParam != null && monthParam.matches("\\d{4}-\\d{2}")) {

            // Add "-01" to make it a valid date (first day of the month)
            String startOfMonth = monthParam + "-01";
            String endOfMonth = monthParam + "-30";

            // Convert to java.sql.Date
            Date startDate = Date.valueOf(startOfMonth);
            Date endDate = Date.valueOf(endOfMonth);

            // Debugging: Print the date
            List<Attendance> filteredAttendances = AttendanceDAO.getFilteredAttendance(startDate,endDate);

            request.setAttribute("attendanceHistory", filteredAttendances);
            request.getRequestDispatcher("view/admin/attendance.jsp").forward(request, response);

        } else {
            System.out.println("Invalid month format");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid month format");
        }
    }
}