package com.demo.nft.controller;

import com.demo.nft.entity.User;
import com.demo.nft.repository.MySqlUserRepository;
import com.demo.nft.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.PasswordUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;

public class RegisterServlet extends HttpServlet {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w.+-]+@[\\w.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{3,32}$");

    private final UserRepository userRepository = new MySqlUserRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("form", new HashMap<String, String>());
        request.setAttribute("errors", new HashMap<String, String>());
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String fullName = trim(req.getParameter("fullName"));
        String email = trim(req.getParameter("email"));
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();
        Map<String, String> form = new HashMap<>();

        form.put("username", username);
        form.put("fullName", fullName);
        form.put("email", email);

        if (username == null || username.isBlank()) {
            errors.put("username", "Username is required.");
        } else if (!USERNAME_PATTERN.matcher(username).matches()) {
            errors.put("username", "Username must be 3-32 characters (letters, numbers, underscores).");
        }

        if (fullName != null && fullName.length() > 255) {
            errors.put("fullName", "Full name cannot exceed 255 characters.");
        }

        if (email == null || email.isBlank()) {
            errors.put("email", "Email is required.");
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.put("email", "Please provide a valid email address.");
        }

        if (password == null || password.isBlank()) {
            errors.put("password", "Password is required.");
        } else if (password.length() < 6) {
            errors.put("password", "Password must contain at least 6 characters.");
        }

        if (confirmPassword == null || confirmPassword.isBlank()) {
            errors.put("confirmPassword", "Please re-enter your password.");
        } else if (password != null && !password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Passwords do not match.");
        }

        if (errors.isEmpty()) {
            Optional<User> existingByUsername = userRepository.findByUsername(username);
            if (existingByUsername.isPresent()) {
                errors.put("username", "Username is already taken.");
            }
        }

        if (errors.isEmpty() && email != null) {
            Optional<User> existingByEmail = userRepository.findByEmail(email);
            if (existingByEmail.isPresent()) {
                errors.put("email", "Email is already registered.");
            }
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("form", form);
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hash(password));
        user.setRole(User.Role.VIEWER);
        user.setStatus(User.Status.ACTIVE);

        userRepository.save(user);

        req.getSession().setAttribute("registerSuccess", "Account created successfully. Please sign in.");
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private String trim(String value) {
        return value != null ? value.trim() : null;
    }
}
