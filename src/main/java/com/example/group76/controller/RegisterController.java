package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "All fields are required for registration.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User newUser = new User(email, password);

        System.out.println("Registering user: " + newUser.getEmail());

        request.setAttribute("message", "Registration successful! Please login.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
