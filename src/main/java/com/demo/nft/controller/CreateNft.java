package com.demo.nft.controller;

import com.demo.nft.entity.Nft;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class CreateNft extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/nft/create-nft.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String description = req.getParameter("description");
        String thumbnail = req.getParameter("thumbnail");
        String priceParam = req.getParameter("price");
        String currency = req.getParameter("currency");
        String categoryIdParam = req.getParameter("categoryId");
        String statusParam = req.getParameter("status");

        Nft nft = new Nft();
        nft.setDescription(description);
        nft.setThumbnailUrl(thumbnail);
        nft.setPrice(Float.valueOf(priceParam));
        nft.setCurrency(currency);
        nft.setCategoryId(Long.valueOf(categoryIdParam));
        nft.setStatus(Nft.Status.valueOf(statusParam));

    }
}
