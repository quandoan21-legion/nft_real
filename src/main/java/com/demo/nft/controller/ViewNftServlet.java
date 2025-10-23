package com.demo.nft.controller;

import com.demo.nft.entity.Nft;
import com.demo.nft.entity.User;
import com.demo.nft.repository.MySqlNftRepository;
import com.demo.nft.repository.MySqlUserRepository;
import com.demo.nft.repository.NftRepository;
import com.demo.nft.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

public class ViewNftServlet extends HttpServlet {

    private final NftRepository nftRepository = new MySqlNftRepository();
    private final UserRepository userRepository = new MySqlUserRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/nfts");
            return;
        }

        int nftId;
        try {
            nftId = Integer.parseInt(idParam);
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Nft nft = nftRepository.findById(nftId);
        if (nft == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        User creator = null;
        if (nft.getCreatorId() != null) {
            Optional<User> creatorOpt = userRepository.findById(nft.getCreatorId());
            creator = creatorOpt.orElse(null);
        }

        User owner = null;
        if (nft.getOwnerId() != null) {
            Optional<User> ownerOpt = userRepository.findById(nft.getOwnerId());
            owner = ownerOpt.orElse(null);
        }

        req.setAttribute("nft", nft);
        req.setAttribute("creatorUser", creator);
        req.setAttribute("ownerUser", owner);
        req.getRequestDispatcher("/nft/get-nft.jsp").forward(req, resp);
    }
}
