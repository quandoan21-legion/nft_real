package com.demo.nft.controller;

import com.demo.nft.entity.Nft;
import com.demo.nft.entity.User;
import com.demo.nft.repository.MySqlNftRepository;
import com.demo.nft.repository.NftRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UpdateNftServlet extends HttpServlet {

    private final NftRepository nftRepository = new MySqlNftRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer nftId = parseId(req, resp);
        if (nftId == null) {
            return;
        }

        Nft nft = nftRepository.findById(nftId);
        if (!isEditableByUser(nft, currentUser)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("formData", buildFormDataFromEntity(nft));
        req.setAttribute("nftId", nft.getId());
        req.setAttribute("nft", nft);
        req.getRequestDispatcher("/nft/edit-nft.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer nftId = parseId(req, resp);
        if (nftId == null) {
            return;
        }

        Nft existing = nftRepository.findById(nftId);
        if (!isEditableByUser(existing, currentUser)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Map<String, String> errors = new HashMap<>();
        Map<String, String> formData = new HashMap<>();

        String name = req.getParameter("name");
        formData.put("name", name != null ? name.trim() : "");
        if (name == null || name.isBlank()) {
            errors.put("name", "Name is required.");
        }

        String description = req.getParameter("description");
        formData.put("description", description != null ? description.trim() : "");
        if (description == null || description.isBlank()) {
            errors.put("description", "Description is required.");
        }

        String thumbnail = req.getParameter("thumbnail");
        formData.put("thumbnail", thumbnail != null ? thumbnail.trim() : "");
        if (thumbnail == null || thumbnail.isBlank()) {
            errors.put("thumbnail", "Thumbnail URL is required.");
        }

        String priceParam = req.getParameter("price");
        formData.put("price", priceParam != null ? priceParam.trim() : "");
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

        String currency = req.getParameter("currency");
        formData.put("currency", currency != null ? currency.trim() : "");
        if (currency == null || currency.isBlank()) {
            errors.put("currency", "Currency is required.");
        }

        String categoryIdParam = req.getParameter("categoryId");
        formData.put("categoryId", categoryIdParam != null ? categoryIdParam.trim() : "");
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

        String statusParam = req.getParameter("status");
        formData.put("status", statusParam != null ? statusParam.trim() : "");
        int status = existing != null ? existing.getStatus() : Nft.STATUS_ON_SALE;
        if (statusParam != null && !statusParam.isBlank()) {
            try {
                status = Integer.parseInt(statusParam);
                if (status != Nft.STATUS_ON_SALE && status != Nft.STATUS_NOT_FOR_SALE) {
                    errors.put("status", "Invalid status selection.");
                }
            } catch (NumberFormatException e) {
                errors.put("status", "Invalid status selection.");
            }
        } else {
            errors.put("status", "Status is required.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("formData", formData);
            req.setAttribute("nftId", existing != null ? existing.getId() : nftId.longValue());
            req.setAttribute("nft", existing);
            req.getRequestDispatcher("/nft/edit-nft.jsp").forward(req, resp);
            return;
        }

        existing.setName(name.trim());
        existing.setDescription(description.trim());
        existing.setThumbnailUrl(thumbnail.trim());
        existing.setPrice(price);
        existing.setCurrency(currency.trim());
        existing.setCategoryId(categoryId);
        existing.setStatus(status);
        existing.setUpdatedBy(currentUser.getId());
        existing.setOwnerId(existing.getOwnerId() != null ? existing.getOwnerId() : currentUser.getId());
        existing.setUpdatedAt(java.time.LocalDateTime.now());

        Nft updated = nftRepository.update(nftId, existing);
        if (updated == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update NFT.");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    private Integer parseId(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "NFT id is required.");
            return null;
        }
        try {
            return Integer.valueOf(idParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid NFT id.");
            return null;
        }
    }

    private boolean isEditableByUser(Nft nft, User user) {
        if (nft == null || user == null) {
            return false;
        }
        return nft.getOwnerId() != null && nft.getOwnerId().equals(user.getId());
    }

    private Map<String, String> buildFormDataFromEntity(Nft nft) {
        Map<String, String> formData = new HashMap<>();
        formData.put("name", nft.getName() != null ? nft.getName() : "");
        formData.put("description", nft.getDescription() != null ? nft.getDescription() : "");
        formData.put("thumbnail", nft.getThumbnailUrl() != null ? nft.getThumbnailUrl() : "");
        formData.put("price", nft.getPrice() != null ? nft.getPrice().toString() : "");
        formData.put("currency", nft.getCurrency() != null ? nft.getCurrency() : "");
        formData.put("categoryId", nft.getCategoryId() != null ? nft.getCategoryId().toString() : "");
        formData.put("status", String.valueOf(nft.getStatus()));
        return formData;
    }
}
