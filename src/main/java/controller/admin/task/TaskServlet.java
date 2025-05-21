package controller.admin.task;

import dao.TaskDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Task;
import model.User;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet({"/admin/tasks", "/add-task", "/update-task", "/delete-task"})
public class TaskServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if (servletPath.equals("/admin/tasks")) {
            // Get all tasks with user information
            List<Task> tasks = TaskDAO.getAllTasksWithUserInfo();

            // Get all users for dropdowns
            List<User> users = UserDAO.getAllUsers();

            // Set today's date for the due date field minimum
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String today = sdf.format(new Date());

            // Set attributes
            request.setAttribute("tasks", tasks);
            request.setAttribute("users", users);
            request.setAttribute("today", today);

            // Forward to JSP page
            request.getRequestDispatcher("/view/admin/tasks.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        if (servletPath.equals("/add-task")) {
            handleAddTask(request, response);
        } else if (servletPath.equals("/update-task")) {
            handleUpdateTask(request, response);
        } else if (servletPath.equals("/delete-task")) {
            handleDeleteTask(request, response);
        }
    }

    private void handleAddTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Get current user ID from session
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            int assignedBy = currentUser.getId();

            // Get form parameters
            int assignedTo = Integer.parseInt(request.getParameter("assignedTo"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dueDateStr = request.getParameter("dueDate");

            // Parse due date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dueDate = sdf.parse(dueDateStr);

            // Create new Task object
            Task task = new Task();
            task.setAssignedBy(assignedBy);
            task.setAssignedTo(assignedTo);
            task.setTitle(title);
            task.setDescription(description);
            task.setDueDate(dueDate);
            task.setStatus("Assigned");

            // Save to database
            boolean success = TaskDAO.addTask(task);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/tasks?success=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tasks?error=add_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tasks?error=" + e.getMessage());
        }
    }

    private void handleUpdateTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Get form parameters
            int id = Integer.parseInt(request.getParameter("id"));
            int assignedTo = Integer.parseInt(request.getParameter("assigned_to"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String dueDateStr = request.getParameter("due_date");
            String status = request.getParameter("status");

            // Parse due date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dueDate = sdf.parse(dueDateStr);

            // Get existing task to preserve assigned_by and created_at
            Task existingTask = TaskDAO.getTaskById(id);

            if (existingTask != null) {
                Task task = new Task();
                task.setId(id);
                task.setAssignedBy(existingTask.getAssignedBy());
                task.setAssignedTo(assignedTo);
                task.setTitle(title);
                task.setDescription(description);
                task.setDueDate(dueDate);
                task.setStatus(status);
                task.setCreatedAt(existingTask.getCreatedAt());

                // Update in database
                boolean success = TaskDAO.updateTask(task);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/tasks?success=updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/tasks?error=update_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/tasks?error=task_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/tasks?error=" + e.getMessage());
        }
    }

    private void handleDeleteTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            System.out.println("Deleting task");
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("Task ID: " + id);

            boolean success = TaskDAO.deleteTask(id);
            System.out.println("Delete success: " + success);

            if (success) {
                response.sendRedirect("admin/tasks");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}