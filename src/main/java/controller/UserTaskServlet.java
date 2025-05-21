package controller;

import controller.admin.task.TaskServlet;
import dao.TaskDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Task;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/get-all-tasks-for-user")
public class UserTaskServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User)session.getAttribute("user");

        List<Task> tasks = TaskDAO.getTasksByAssignedTo(user.getId());

        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("view/user/pages/tasks.jsp").forward(request,response);

    }

}
