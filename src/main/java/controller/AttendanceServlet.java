package controller;

import dao.AttendanceDAO;
import model.Attendance;
import model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private AttendanceDAO attendanceDAO;

    @Override
    public void init() throws ServletException {
        attendanceDAO = new AttendanceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        List<Attendance> attendanceHistory = AttendanceDAO.getAttendence();
        System.out.println(attendanceHistory);

        request.setAttribute("attendanceHistory", attendanceHistory);
        request.getRequestDispatcher("view/admin/attendance.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        System.out.println(user);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }

        // before processing the action any further, check if the user has done attendence already
        Attendance attendance = AttendanceDAO.getTodayAttendance(user.getId());

        if(attendance != null && Objects.equals(attendance.getStatus(), "Present")){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Already attended");
            return;
        }

        String action = request.getParameter("action");
        System.out.println(action);
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        String attendanceDate = request.getParameter("attendanceDate");
        if (attendanceDate == null || attendanceDate.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Attendance date is required");
            return;
        }

        try {
            boolean success = false;
            switch (action) {
                case "markCheckedIn":
                    success = attendanceDAO.markTimeIn(user.getId());
                    break;
                case "markTimeOut":
                    success = attendanceDAO.markTimeOut(user.getId());
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    return;
            }

            if (success) {
                response.getWriter().write("Attendance completed successfully");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Action failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }
}
