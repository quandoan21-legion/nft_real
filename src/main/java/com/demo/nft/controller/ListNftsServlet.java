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
import java.util.stream.Collectors;

public class ListNftsServlet extends HttpServlet {

    private static final NftRepository nftRepository = new MySqlNftRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchTerm = req.getParameter("q");
        String currency = req.getParameter("currency");

        List<Nft> nfts = nftRepository.findByStatus(Nft.STATUS_ON_SALE);

        if (searchTerm != null && !searchTerm.isBlank()) {
            String normalizedSearch = searchTerm.trim().toLowerCase();
            nfts = nfts.stream()
                    .filter(nft -> {
                        boolean matchesName = nft.getName() != null && nft.getName().toLowerCase().contains(normalizedSearch);
                        boolean matchesDescription = nft.getDescription() != null && nft.getDescription().toLowerCase().contains(normalizedSearch);
                        return matchesName || matchesDescription;
                    })
                    .collect(Collectors.toList());
            req.setAttribute("filterName", searchTerm);
        } else {
            req.setAttribute("filterName", "");
        }

        if (currency != null && !currency.isBlank()) {
            String normalizedCurrency = currency.trim().toLowerCase();
            nfts = nfts.stream()
                    .filter(nft -> nft.getCurrency() != null && nft.getCurrency().toLowerCase().equals(normalizedCurrency))
                    .collect(Collectors.toList());
            req.setAttribute("filterCurrency", currency);
        } else {
            req.setAttribute("filterCurrency", "");
        }

        req.setAttribute("nfts", nfts);
        req.getRequestDispatcher("/nft/list.jsp").forward(req, resp);
    }
}
