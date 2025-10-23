<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.demo.nft.entity.Nft" %>
<%@ page import="com.demo.nft.entity.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NFT Details - NAFT</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/form.css">
</head>
<body>
<%
    Object currentUserAttr = session.getAttribute("currentUser");
    User navUser = currentUserAttr instanceof User ? (User) currentUserAttr : null;
    String navUsername = (navUser != null && navUser.getUsername() != null && !navUser.getUsername().isBlank())
            ? navUser.getUsername()
            : "Profile";

    Nft nft = (Nft) request.getAttribute("nft");
    User creatorUser = (User) request.getAttribute("creatorUser");
    User ownerUser = (User) request.getAttribute("ownerUser");

    if (nft == null) {
%>
<main>
    <article>
        <section class="hero">
            <div class="container">
                <div class="form-header">
                    <h1>Item not available</h1>
                    <p>The NFT you are looking for could not be found.</p>
                </div>
                <div class="form-actions">
                    <a class="btn btn-primary" href="<%= request.getContextPath() %>/nfts">Back to Marketplace</a>
                </div>
            </div>
        </section>
    </article>
</main>
<%
    } else {
        String stockImageUrl = "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80";
        String resolvedThumbnail = (nft.getThumbnailUrl() != null && !nft.getThumbnailUrl().isBlank())
                ? nft.getThumbnailUrl()
                : stockImageUrl;
        String resolvedName = (nft.getName() != null && !nft.getName().isBlank()) ? nft.getName() : "Untitled NFT";
        String resolvedDescription = (nft.getDescription() != null && !nft.getDescription().isBlank())
                ? nft.getDescription()
                : "No description available for this NFT.";
        Float priceValue = nft.getPrice();
        String priceLabel = priceValue != null
                ? priceValue + ((nft.getCurrency() != null && !nft.getCurrency().isBlank()) ? " " + nft.getCurrency() : "")
                : "Price not set";
        String statusLabel = nft.getStatus() == Nft.STATUS_ON_SALE ? "On Sale" : "Not For Sale";

        String creatorDisplayName = "Unknown Creator";
        String creatorHandle = "creator";
        if (creatorUser != null) {
            if (creatorUser.getFullName() != null && !creatorUser.getFullName().isBlank()) {
                creatorDisplayName = creatorUser.getFullName();
            } else if (creatorUser.getUsername() != null && !creatorUser.getUsername().isBlank()) {
                creatorDisplayName = creatorUser.getUsername();
            }
            if (creatorUser.getUsername() != null && !creatorUser.getUsername().isBlank()) {
                creatorHandle = creatorUser.getUsername();
            }
        }

        String ownerDisplayName = "Unknown Collector";
        String ownerHandle = "collector";
        if (ownerUser != null) {
            if (ownerUser.getFullName() != null && !ownerUser.getFullName().isBlank()) {
                ownerDisplayName = ownerUser.getFullName();
            } else if (ownerUser.getUsername() != null && !ownerUser.getUsername().isBlank()) {
                ownerDisplayName = ownerUser.getUsername();
            }
            if (ownerUser.getUsername() != null && !ownerUser.getUsername().isBlank()) {
                ownerHandle = ownerUser.getUsername();
            }
        }

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");
        LocalDateTime createdAt = nft.getCreatedAt();
        LocalDateTime updatedAt = nft.getUpdatedAt();
        String createdDateLabel = createdAt != null ? createdAt.format(dateFormatter) : "Unknown";
        String createdTimeLabel = createdAt != null ? createdAt.format(timeFormatter) : "";
        String updatedDateLabel = updatedAt != null ? updatedAt.format(dateFormatter) : null;
        String updatedTimeLabel = updatedAt != null ? updatedAt.format(timeFormatter) : null;
%>

<header>
    <div class="container">
        <a href="<%= request.getContextPath() %>/home" class="logo">
            <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="NAFT logo">
        </a>
        <div class="header-right">
            <div class="header-nav-wrapper">
                <button class="navbar-toggle-btn" data-navbar-toggle-btn>
                    <ion-icon name="menu-outline"></ion-icon>
                </button>
                <nav class="navbar" data-navbar>
                    <ul class="navbar-list">
                        <li><a href="<%= request.getContextPath() %>/home" class="navbar-link">Home</a></li>
                        <li><a href="<%= request.getContextPath() %>/nfts" class="navbar-link">Marketplace</a></li>
                        <li><a href="<%= request.getContextPath() %>/nfts/create" class="navbar-link">Create NFT</a></li>
                    </ul>
                </nav>
            </div>
            <div class="header-actions">
                <input type="search" placeholder="Search" class="search-field">
                <%
                    if (navUser != null) {
                %>
                <a href="<%= request.getContextPath() %>/profile" class="btn btn-primary">
                    <%= navUsername %>
                </a>
                <form action="<%= request.getContextPath() %>/logout" method="post" style="display:inline-block; margin-left:0.5rem;">
                    <button type="submit" class="btn btn-secondary">Logout</button>
                </form>
                <%
                    } else {
                %>
                <a href="<%= request.getContextPath() %>/login" class="btn btn-primary">Sign in</a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</header>

<main>
    <article>
        <section class="hero">
            <div class="container">
                <div class="form-header">
                    <h1><%= resolvedName %></h1>
                    <p>Discover the story and details behind this unique digital asset.</p>
                </div>
                <div class="product-card detail-card" style="display:flex; flex-wrap:wrap; gap:2rem; padding:2rem;">
                    <figure class="product-banner" style="flex:1 1 320px; max-width:480px;">
                        <img src="<%= resolvedThumbnail %>" alt="<%= resolvedName %>" style="width:100%; border-radius:16px;">
                    </figure>
                    <div class="product-content" style="flex:1 1 320px;">
                        <h2 class="h3 product-title" style="margin-top:0; margin-bottom:1rem;"><%= resolvedName %></h2>
                        <p class="product-text" style="margin-bottom:1.5rem;"><%= resolvedDescription %></p>
                        <div class="product-meta" style="display:flex; flex-direction:column; gap:1.5rem;">
                            <div class="product-author" style="display:flex; gap:1rem;">
                                <figure class="author-img" style="width:64px; height:64px; border-radius:50%; overflow:hidden;">
                                    <img src="<%= request.getContextPath() %>/assets/images/bidding-user.png" alt="<%= creatorDisplayName %> avatar" style="width:100%; height:100%; object-fit:cover;">
                                </figure>
                                <div class="author-content">
                                    <h4 class="h5 author-title">Created by</h4>
                                    <p class="author-username" style="margin:0;"><%= creatorDisplayName %> (@<%= creatorHandle %>)</p>
                                </div>
                            </div>
                            <div class="product-author" style="display:flex; gap:1rem;">
                                <figure class="author-img" style="width:64px; height:64px; border-radius:50%; overflow:hidden;">
                                    <img src="<%= request.getContextPath() %>/assets/images/bidding-user.png" alt="<%= ownerDisplayName %> avatar" style="width:100%; height:100%; object-fit:cover;">
                                </figure>
                                <div class="author-content">
                                    <h4 class="h5 author-title">Owned by</h4>
                                    <p class="author-username" style="margin:0;"><%= ownerDisplayName %> (@<%= ownerHandle %>)</p>
                                </div>
                            </div>
                            <div class="product-price" style="display:flex; flex-direction:column; gap:0.25rem;">
                                <data value="<%= priceValue != null ? priceValue : 0 %>" class="price" style="font-size:1.5rem; font-weight:600;"><%= priceLabel %></data>
                                <p class="label" style="font-weight:500;"><%= statusLabel %></p>
                            </div>
                            <div class="product-meta-item" style="display:flex; flex-direction:column; gap:0.5rem;">
                                <div>
                                    <span class="label" style="font-weight:500;">Minted on</span>
                                    <p style="margin:0;"><%= createdDateLabel %> <%= createdTimeLabel %></p>
                                </div>
                                <%
                                    if (updatedDateLabel != null && updatedTimeLabel != null) {
                                %>
                                <div>
                                    <span class="label" style="font-weight:500;">Last updated</span>
                                    <p style="margin:0;"><%= updatedDateLabel %> <%= updatedTimeLabel %></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="form-actions" style="margin-top:2rem; display:flex; gap:1rem;">
                            <a class="btn btn-primary" href="<%= request.getContextPath() %>/nfts">Back to Marketplace</a>
                            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/profile">View My Collection</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </article>
</main>
<%
    }
%>

<footer>
    <div class="footer-top">
        <div class="container">
            <div class="footer-brand">
                <a href="<%= request.getContextPath() %>/home" class="logo">
                    <img src="<%= request.getContextPath() %>/assets/images/logo.png" alt="NAFT logo">
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
                <a href="#" class="footer-bottom-link">Privacy Policy</a>
                <a href="#" class="footer-bottom-link">Terms & Conditions</a>
            </div>
        </div>
    </div>
</footer>

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>
</html>
