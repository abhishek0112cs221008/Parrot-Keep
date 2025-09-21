package controller;

import dao.UserDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        
        // 1. Basic input validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("All fields are required.", "UTF-8"));
            return;
        }
        
        // 2. Password match validation
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("Passwords do not match.", "UTF-8"));
            return;
        }

        // 3. Check for existing user or email
        if (userDAO.isUserExists(username, email)) {
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("Username or email already exists.", "UTF-8"));
            return;
        }
        
        // 4. Attempt to register the user
        if (userDAO.registerUser(username, password, email)) {
            // Registration successful
            response.sendRedirect("login.jsp");
        } else {
            // Registration failed due to a database or unexpected error
            response.sendRedirect("register.jsp?error=" + URLEncoder.encode("Registration failed. Please try again.", "UTF-8"));
        }
    }
}