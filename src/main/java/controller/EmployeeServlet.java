package controller;

import dao.DepartmentDAO;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Department;
import model.Employee;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private EmployeeDAO employeeDAO;
    private DepartmentDAO departmentDAO;

    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
        departmentDAO = new DepartmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewEmployee(request, response);
                break;
            case "delete":
                deleteEmployee(request, response);
                break;
            default:
                listEmployees(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addEmployee(request, response);
        } else if ("edit".equals(action)) {
            updateEmployee(request, response);
        }
    }

    private void listEmployees(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String department = request.getParameter("department");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");

        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;

        List<Employee> employeeList = employeeDAO.getEmployees(search, department, role, status, page, pageSize);
        int totalEmployees = employeeDAO.getTotalEmployees(search, department, role, status);
        int totalPages = (int) Math.ceil((double) totalEmployees / pageSize);

        List<Department> departments = departmentDAO.getAllDepartments();

        request.setAttribute("employeeList", employeeList);
        request.setAttribute("departments", departments);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/view/admin/employees.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/view/admin/add-employee.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeById(id);
        List<Department> departments = departmentDAO.getAllDepartments();

        if (employee != null) {
            request.setAttribute("employee", employee);
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("/view/admin/edit-employee.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/employees?error=notfound");
        }
    }

    private void viewEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeById(id);

        if (employee != null) {
            request.setAttribute("employee", employee);
            request.getRequestDispatcher("/view/admin/view-employee.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/employees?error=notfound");
        }
    }

    private void addEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Employee employee = new Employee();
            employee.setName(request.getParameter("name"));
            employee.setEmail(request.getParameter("email"));
            employee.setPassword(request.getParameter("password"));
            employee.setPhone(request.getParameter("phone"));
//            employee.setPicturePath(request.getParameter("picturePath"));
            employee.setRole(Integer.parseInt(request.getParameter("role")));
            employee.setActive(Boolean.parseBoolean(request.getParameter("isActive")));
            employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
            employee.setHireDate(Date.valueOf(request.getParameter("hireDate")));

            boolean success = employeeDAO.addEmployee(employee);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/employees");
            } else {
                response.sendRedirect(request.getContextPath() + "/employees?action=add&error=failed");
            }
        } catch (Exception e) {
            throw new ServletException("Error adding employee", e);
        }
    }

    private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Employee employee = new Employee();
            employee.setId(Integer.parseInt(request.getParameter("id")));
            employee.setName(request.getParameter("name"));
            employee.setEmail(request.getParameter("email"));
            employee.setPhone(request.getParameter("phone"));
            employee.setPicturePath(request.getParameter("picturePath"));
            employee.setRole(Integer.parseInt(request.getParameter("role")));
            employee.setActive(Boolean.parseBoolean(request.getParameter("isActive")));
            employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
            employee.setHireDate(Date.valueOf(request.getParameter("hireDate")));

            boolean success = employeeDAO.updateEmployee(employee);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/employees");
            } else {
                response.sendRedirect(
                        request.getContextPath() + "/employees?action=edit&id=" + employee.getId() + "&error=failed");
            }
        } catch (Exception e) {
            throw new ServletException("Error updating employee", e);
        }
    }

    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            employeeDAO.deleteEmployee(id);
            response.sendRedirect(request.getContextPath() + "/employees");
        } catch (Exception e) {
            throw new ServletException("Error deleting employee", e);
        }
    }
}
