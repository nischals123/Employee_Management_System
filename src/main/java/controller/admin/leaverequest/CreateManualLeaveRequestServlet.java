    package controller.admin.leaverequest;

    import dao.LeaveRequestDAO;
    import dao.UserDAO;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import jakarta.servlet.http.HttpSession;
    import model.LeaveRequest;
    import model.User;

    import java.io.IOException;
    import java.sql.Date;

    @WebServlet(name = "CreateManualLeaveRequestServlet", urlPatterns = {"/create-manual-leave"})
    public class CreateManualLeaveRequestServlet extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
                return;
            }

            String employeeName = request.getParameter("employee");
            User userFromName = UserDAO.getUserByEmail(employeeName.trim());

            if(userFromName == null) {
                request.setAttribute("error", "User not found");
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // userId
            int id = userFromName.getId();

                try {
                    // Retrieve form parameters
                    int userId = id;
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
        }
    }
