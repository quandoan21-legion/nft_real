package com.demo.nft.controller;

import com.demo.nft.entity.User;
import com.demo.nft.repository.MySqlUserRepository;
import com.demo.nft.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.PasswordUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class LoginServlet extends HttpServlet {

    private final UserRepository userRepository = new MySqlUserRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object successMessage = req.getSession().getAttribute("registerSuccess");
        if (successMessage != null) {
            req.setAttribute("successMessage", successMessage.toString());
            req.getSession().removeAttribute("registerSuccess");
        }
        req.setAttribute("form", new HashMap<String, String>());
        req.setAttribute("errors", new HashMap<String, String>());
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String password = req.getParameter("password");

        Map<String, String> errors = new HashMap<>();
        Map<String, String> form = new HashMap<>();
        form.put("username", username);

        if (username == null || username.isBlank()) {
            errors.put("username", "Username is required.");
        }

        if (password == null || password.isBlank()) {
            errors.put("password", "Password is required.");
        }

        if (errors.isEmpty()) {
            Optional<User> userOptional = userRepository.findByUsername(username);
            if (userOptional.isEmpty() || !PasswordUtil.matches(password, userOptional.get().getPasswordHash())) {
                errors.put("global", "Invalid username or password.");
            } else if (userOptional.get().getStatus() == User.Status.INACTIVE) {
                errors.put("global", "Your account is inactive. Please contact support.");
            } else {
                User user = userOptional.get();
                HttpSession session = req.getSession();
                user.setPasswordHash(null);
                session.setAttribute("currentUser", user);
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }
        }

        req.setAttribute("errors", errors);
        req.setAttribute("form", form);
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    private String trim(String value) {
        return value != null ? value.trim() : null;
    }
}
