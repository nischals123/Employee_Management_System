package controller.admin.department;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Department;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/get-all-departments")
public class GetAllDepartmentsServlet extends HttpServlet {
    @Override
    protected  void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            List<Department> departmentList = DepartmentDAO.getAllDepartments();
            System.out.println(departmentList);
            request.setAttribute("departments", departmentList);
            request.getRequestDispatcher("view/admin/departments.jsp").forward(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
