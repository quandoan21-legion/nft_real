package com.demo.nft.controller;

import com.demo.nft.entity.Nft;
import com.demo.nft.repository.MySqlNftRepository;
import com.demo.nft.repository.MySqlUserRepository;
import com.demo.nft.repository.NftRepository;
import com.demo.nft.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class GetNft extends HttpServlet {
	private static final NftRepository nftRepository = new MySqlNftRepository();
	private static final UserRepository userRepository = new MySqlUserRepository();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Nft> nfts = nftRepository.findByStatus(Nft.STATUS_ON_SALE);
		Map<Long, String> authorNames = new HashMap<>();
		Map<Long, String> authorHandles = new HashMap<>();
		Map<Long, String> displayNameByUserId = new HashMap<>();
		Map<Long, String> usernameByUserId = new HashMap<>();

		for (Nft nft : nfts) {
			Long nftId = nft.getId();
			Long userId = nft.getCreatorId() != null ? nft.getCreatorId() : nft.getOwnerId();
			if (nftId == null) {
				continue;
			}

			String displayName = "Unknown Creator";
			String username = "creator";

			if (userId != null) {
				if (!displayNameByUserId.containsKey(userId)) {
					Optional<com.demo.nft.entity.User> userOptional = userRepository.findById(userId);
					if (userOptional.isPresent()) {
						com.demo.nft.entity.User user = userOptional.get();
						String resolvedDisplayName = (user.getFullName() != null && !user.getFullName().isBlank())
								? user.getFullName()
								: user.getUsername();
						displayNameByUserId.put(userId, resolvedDisplayName);
						usernameByUserId.put(userId, user.getUsername() != null ? user.getUsername() : "creator");
					} else {
						displayNameByUserId.put(userId, "Unknown Creator");
						usernameByUserId.put(userId, "creator");
					}
				}
				displayName = displayNameByUserId.getOrDefault(userId, displayName);
				username = usernameByUserId.getOrDefault(userId, username);
			}

			authorNames.put(nftId, displayName);
			authorHandles.put(nftId, username != null ? username : "creator");
		}

		req.setAttribute("nfts", nfts);
		req.setAttribute("authorNames", authorNames);
		req.setAttribute("authorHandles", authorHandles);
		req.getRequestDispatcher("index1.jsp").forward(req, resp);
	}
}
