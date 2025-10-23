<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.nft.entity.Nft" %>
<%@ page import="com.demo.nft.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Collection - NAFT</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/form.css">
</head>
<body>
<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NAFT logo">
        </a>
        <div class="header-right">
            <div class="header-nav-wrapper">
                <button class="navbar-toggle-btn" data-navbar-toggle-btn>
                    <ion-icon name="menu-outline"></ion-icon>
                </button>
                <nav class="navbar" data-navbar>
                    <ul class="navbar-list">
                        <li><a href="${pageContext.request.contextPath}/home" class="navbar-link">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/nfts" class="navbar-link">Explore</a></li>
                        <li><a href="${pageContext.request.contextPath}/nfts/create" class="navbar-link">Create NFT</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile" class="navbar-link active">My Collection</a></li>
                    </ul>
                </nav>
            </div>
            <div class="header-actions">
                <input type="search" placeholder="Search" class="search-field">
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">
                            ${sessionScope.currentUser.username}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Sign in</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<main>
    <article>
        <section class="explore-product">
            <div class="container">
                <c:set var="displayName" value="${sessionScope.currentUser.fullName}" />
                <c:if test="${empty displayName}">
                    <c:set var="displayName" value="${sessionScope.currentUser.username}" />
                </c:if>
                <div class="section-header-wrapper">
                    <div>
                        <h2 class="h2 section-title">${displayName}'s NFTs</h2>
                        <p class="section-text">Review the pieces you currently own on NAFT.</p>
                    </div>
                    <div class="filter-actions">
                        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/nfts/create">Mint new NFT</a>
                    </div>
                </div>
                <%
                    List<Nft> ownedNfts = (List<Nft>) request.getAttribute("ownedNfts");
                    User currentUser = (User) session.getAttribute("currentUser");
                    String displayNameVal = (String) pageContext.getAttribute("displayName");
                    if (displayNameVal == null || displayNameVal.isBlank()) {
                        if (currentUser != null && currentUser.getFullName() != null && !currentUser.getFullName().isBlank()) {
                            displayNameVal = currentUser.getFullName();
                        } else if (currentUser != null) {
                            displayNameVal = currentUser.getUsername();
                        } else {
                            displayNameVal = "Collector";
                        }
                    }
                    if (ownedNfts == null || ownedNfts.isEmpty()) {
                %>
                <div class="empty-state">
                    <p>You have not collected any NFTs yet. Start by <a href="${pageContext.request.contextPath}/nfts/create">minting a new NFT</a> or exploring the marketplace.</p>
                </div>
                <%
                    } else {
                %>
                <ul class="product-list">
                    <%
                        for (Nft nft : ownedNfts) {
                            String contextPath = request.getContextPath();
                            String thumbnail = (nft.getThumbnailUrl() != null && !nft.getThumbnailUrl().isBlank())
                                    ? nft.getThumbnailUrl()
                                    : contextPath + "/assets/images/new-item-1.jpg";
                            String name = (nft.getName() != null && !nft.getName().isBlank()) ? nft.getName() : "Untitled NFT";
                            String description = (nft.getDescription() != null && !nft.getDescription().isBlank())
                                    ? nft.getDescription()
                                    : "No description available for this NFT.";
                            String currency = nft.getCurrency() != null ? nft.getCurrency() : "";
                            String priceLabel = nft.getPrice() != null
                                    ? nft.getPrice() + (currency.isBlank() ? "" : " " + currency)
                                    : "Price not set";
                            String statusLabel = nft.getStatus() == Nft.STATUS_ON_SALE ? "On Sale" : "Not For Sale";
                    %>
                    <li class="product-item">
                        <div class="product-card" tabindex="0">
                            <figure class="product-banner">
                                <img src="<%= thumbnail %>" alt="<%= name %>">
                                <div class="product-actions">
                                    <button class="product-card-menu" type="button">
                                        <ion-icon name="ellipsis-horizontal"></ion-icon>
                                    </button>
                                    <button class="add-to-whishlist" data-whishlist-btn type="button">
                                        <ion-icon name="heart"></ion-icon>
                                    </button>
                                </div>
                            </figure>
                            <div class="product-content">
                                <a href="#" class="h4 product-title"><%= name %></a>
                                <p class="product-text"><%= description %></p>
                                <div class="product-meta">
                                    <div class="product-author">
                                        <figure class="author-img">
                                            <img src="<%= contextPath %>/assets/images/bidding-user.png" alt="<%= name %> owner">
                                        </figure>
                                        <div class="author-content">
                                            <h4 class="h5 author-title"><%= displayNameVal %></h4>
                                            <span class="author-username">@<%= currentUser != null ? currentUser.getUsername() : "naft" %></span>
                                        </div>
                                    </div>
                                    <div class="product-price">
                                        <data value="<%= nft.getPrice() != null ? nft.getPrice() : 0 %>"><%= priceLabel %></data>
                                        <p class="label"><%= statusLabel %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <%
                    }
                %>
            </div>
        </section>
    </article>
</main>

<footer>
    <div class="footer-top">
        <div class="container">
            <div class="footer-brand">
                <a href="${pageContext.request.contextPath}/home" class="logo">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NAFT logo">
                </a>
                <p class="footer-brand-text">
                    There are many variations of passages of but the majority have suffered alterations cted humour, or
                    randomsed words which htly believable. If you are going
                </p>
                <h3 class="h4 social-title">Join the community</h3>
                <ul class="social-list">
                    <li><a href="https://github.com/codewithsadee" class="social-link"><ion-icon name="logo-github"></ion-icon></a></li>
                    <li><a href="https://twitter.com/codewithsadee" class="social-link"><ion-icon name="logo-twitter"></ion-icon></a></li>
                    <li><a href="https://www.instagram.com/codewithsadee/" class="social-link"><ion-icon name="logo-instagram"></ion-icon></a></li>
                    <li><a href="https://www.youtube.com/c/codewithsadee" class="social-link"><ion-icon name="logo-youtube"></ion-icon></a></li>
                </ul>
            </div>

            <div class="footer-link-box">
                <ul class="footer-list">
                    <li><h3 class="h3 footer-item-title">Marketplace</h3></li>
                    <li class="footer-item"><a href="#" class="footer-link">Gaming</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Product</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">All NFTs</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Social Network</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Domain Names</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Collectibles</a></li>
                </ul>

                <ul class="footer-list">
                    <li><h3 class="h3 footer-item-title">Explore</h3></li>
                    <li class="footer-item"><a href="#" class="footer-link">Featured Drops</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Live Auctions</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">All NFTs</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Collections</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Top Seller</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Items Details</a></li>
                </ul>

                <ul class="footer-list">
                    <li><h3 class="h3 footer-item-title">Supports</h3></li>
                    <li class="footer-item"><a href="#" class="footer-link">Settings & Privacy</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Help & Support</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Live Auctions</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Item Details</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">24/7 Supports</a></li>
                    <li class="footer-item"><a href="#" class="footer-link">Blog</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="container">
            <p class="copyright">
                &copy; 2022 <a href="https://github.com/codewithsadee">@codewithsadee</a> all rights reserved
            </p>
            <div class="footer-bottom-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms & Conditions</a>
            </div>
        </div>
    </div>
</footer>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>
</html>
