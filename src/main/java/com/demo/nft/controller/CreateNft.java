package com.demo.nft.controller;

import com.demo.nft.entity.Nft;
import com.demo.nft.entity.User;
import com.demo.nft.repository.MySqlNftRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CreateNft extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/nft/create-nft.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String thumbnail = req.getParameter("thumbnail");
        String priceParam = req.getParameter("price");
        String currency = req.getParameter("currency");
        String categoryIdParam = req.getParameter("categoryId");
        String statusParam = req.getParameter("status");

        Map<String, String> errors = new HashMap<>();

        if (name == null || name.isBlank()) {
            errors.put("name", "Name is required.");
        }
        if (description == null || description.isBlank()) {
            errors.put("description", "Description is required.");
        }
        if (thumbnail == null || thumbnail.isBlank()) {
            errors.put("thumbnail", "Thumbnail URL is required.");
        }

        Float price = null;
        if (priceParam != null && !priceParam.isBlank()) {
            try {
                price = Float.valueOf(priceParam);
                if (price < 0) {
                    errors.put("price", "Price must be greater than or equal to 0.");
                }
            } catch (NumberFormatException e) {
                errors.put("price", "Price must be a valid number.");
            }
        } else {
            errors.put("price", "Price is required.");
        }

        if (currency == null || currency.isBlank()) {
            errors.put("currency", "Currency is required.");
        }

        Long categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.isBlank()) {
            try {
                categoryId = Long.valueOf(categoryIdParam);
            } catch (NumberFormatException e) {
                errors.put("categoryId", "Invalid category selection.");
            }
        } else {
            errors.put("categoryId", "Category is required.");
        }

        int status = (statusParam != null && !statusParam.isBlank())
                ? Integer.parseInt(statusParam)
                : Nft.STATUS_ON_SALE;

        if (!errors.isEmpty()) {
            Map<String, String> formData = new HashMap<>();
            formData.put("name", name);
            formData.put("description", description);
            formData.put("thumbnail", thumbnail);
            formData.put("price", priceParam);
            formData.put("currency", currency);
            formData.put("categoryId", categoryIdParam);
            formData.put("status", statusParam);

            req.setAttribute("errors", errors);
            req.setAttribute("formData", formData);
            req.getRequestDispatcher("/nft/create-nft.jsp").forward(req, resp);
            return;
        }

        Nft nft = new Nft();
        nft.setName(name);
        nft.setDescription(description);
        nft.setThumbnailUrl(thumbnail);
        nft.setPrice(price);
        nft.setCurrency(currency);
        nft.setCategoryId(categoryId);
        nft.setStatus(status);
        nft.setCreatorId(currentUser.getId());
        nft.setOwnerId(currentUser.getId());
        nft.setCreatedBy(currentUser.getId());
        nft.setUpdatedBy(currentUser.getId());

        MySqlNftRepository nftRepository = new MySqlNftRepository();
        nftRepository.save(nft);
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}
