package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if(email.equals("test@example.com") && password.equals("1234")) {
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("error", "Invalid login");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}