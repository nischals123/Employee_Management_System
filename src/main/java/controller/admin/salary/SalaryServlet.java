package controller.admin.salary;

import dao.SalaryDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Salary;
import model.User;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet({"/admin/salaries", "/add-salary", "/update-salary", "/delete-salary"})
public class SalaryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if (servletPath.equals("/admin/salaries")) {
            // Fetch all salaries with user information
            List<Salary> salaries = SalaryDAO.getAllSalariesWithUserInfo();
            List<User> users = UserDAO.getAllUsers();

            request.setAttribute("salaries", salaries);
            request.setAttribute("users", users);
            request.getRequestDispatcher("/view/admin/salary.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if (servletPath.equals("/add-salary")) {
            handleAddSalary(request, response);
        } else if (servletPath.equals("/update-salary")) {
            handleUpdateSalary(request, response);
        } else if (servletPath.equals("/delete-salary")) {
            handleDeleteSalary(request, response);
        }
    }

    private void handleAddSalary(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Get form parameters
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String monthStr = request.getParameter("month"); // Format: YYYY-MM
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("status");

            // Parse month string to YearMonth
            YearMonth yearMonth = YearMonth.parse(monthStr);

            // Create new Salary object
            Salary salary = new Salary();
            salary.setUserId(userId);
            salary.setMonth(yearMonth.toString());
            salary.setAmount(amount);
            salary.setStatus(status);

            // Save to database
            boolean success = SalaryDAO.addSalary(salary);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/salaries?success=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/salaries?error=add_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/salaries?error=" + e.getMessage());
        }
    }

    private void handleUpdateSalary(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Get form parameters
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String monthStr = request.getParameter("month");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("status");

            // Create Salary object
            Salary salary = new Salary();
            salary.setId(id);
            salary.setUserId(userId);
            salary.setMonth(monthStr);
            salary.setAmount(amount);
            salary.setStatus(status);

            // Update in database
            boolean success = SalaryDAO.updateSalary(salary);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/salaries?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/salaries?error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/salaries?error=" + e.getMessage());
        }
    }

    private void handleDeleteSalary(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            System.out.println("hello");
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println(id);


            boolean success = SalaryDAO.deleteSalary(id);
            System.out.println(success);


            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/salaries");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}