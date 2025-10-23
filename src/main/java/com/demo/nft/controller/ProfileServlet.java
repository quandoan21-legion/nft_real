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
import java.util.List;

public class ProfileServlet extends HttpServlet {

    private final NftRepository nftRepository = new MySqlNftRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Nft> ownedNfts = nftRepository.findByOwnerId(currentUser.getId());

        req.setAttribute("ownedNfts", ownedNfts);
        req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
    }
}
