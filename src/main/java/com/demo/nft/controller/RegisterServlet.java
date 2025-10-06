package com.demo.nft.controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws jakarta.servlet.ServletException, java.io.IOException {
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }
}
