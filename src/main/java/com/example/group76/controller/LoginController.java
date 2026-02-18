package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User userAttempt = new User(email, password);

        if ("test@example.com".equals(userAttempt.getEmail()) && "1234".equals(userAttempt.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", userAttempt);
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("error", "Invalid login credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

