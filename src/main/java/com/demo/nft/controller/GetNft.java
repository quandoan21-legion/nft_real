package com.demo.nft.controller;


import com.demo.nft.entity.Nft;
import com.demo.nft.repository.MySqlNftRepository;
import com.demo.nft.repository.NftRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class GetNft extends HttpServlet {
    private static NftRepository nftRepository = new MySqlNftRepository();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Nft> nfts = nftRepository.findAll();
        req.setAttribute("nfts", nfts);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
