<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.nft.entity.Nft" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore NFTs - NAFT</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body id="top">

<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NAFT logo">
        </a>

        <div class="header-right">
            <div class="header-nav-wrapper">
                <nav class="navbar" data-navbar>
                    <ul class="navbar-list">
                        <li><a href="${pageContext.request.contextPath}/" class="navbar-link">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/nfts" class="navbar-link active">Marketplace</a></li>
                        <li><a href="${pageContext.request.contextPath}/nfts/create" class="navbar-link">Create NFT</a></li>
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
    <section class="explore-product">
        <div class="container">
            <div class="section-header-wrapper">
                <h2 class="h2 section-title">Explore Product</h2>
                <form class="filter-form" method="get" action="${pageContext.request.contextPath}/nfts">
                    <div class="filter-fields">
                        <input type="search"
                               name="q"
                               placeholder="Search by name or description"
                               class="search-field"
                               value="<%= request.getAttribute("filterName") != null ? request.getAttribute("filterName") : "" %>">
                        <input type="text"
                               name="currency"
                               placeholder="Currency (e.g. ETH)"
                               class="search-field"
                               value="<%= request.getAttribute("filterCurrency") != null ? request.getAttribute("filterCurrency") : "" %>">
                        <div class="filter-actions">
                            <button type="submit" class="btn btn-primary">Filter</button>
                            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/nfts">Reset</a>
                        </div>
                    </div>
                </form>
            </div>

            <ul class="product-list">
                <%
                    List<Nft> nfts = (List<Nft>) request.getAttribute("nfts");
                    if (nfts == null || nfts.isEmpty()) {
                %>
                <li class="product-item">
                    <div class="product-card">
                        <div class="product-content">
                            <p class="product-title">No NFTs on sale right now.</p>
                            <p class="product-text">Try adjusting your filters or check back later.</p>
                        </div>
                    </div>
                </li>
                <%
                    } else {
                        for (Nft nft : nfts) {
                            String thumbnail = (nft.getThumbnailUrl() != null && !nft.getThumbnailUrl().isBlank())
                                    ? nft.getThumbnailUrl()
                                    : request.getContextPath() + "/assets/images/new-item-1.jpg";
                            String displayName = nft.getName() != null && !nft.getName().isBlank() ? nft.getName() : "Untitled NFT";
                            String displayDescription = nft.getDescription() != null && !nft.getDescription().isBlank()
                                    ? nft.getDescription()
                                    : "No description available for this NFT.";
                            String displayCurrency = nft.getCurrency() != null ? nft.getCurrency() : "";
                            String displayPrice = nft.getPrice() != null
                                    ? nft.getPrice() + (displayCurrency.isBlank() ? "" : " " + displayCurrency)
                                    : "Price not set";
                %>
                <li class="product-item">
                    <div class="product-card" tabindex="0">
                        <figure class="product-banner">
                            <img src="<%= thumbnail %>" alt="<%= displayName %>">
                        </figure>
                        <div class="product-content">
                            <span class="product-category">On Sale</span>
                            <a href="#" class="h4 product-title"><%= displayName %></a>
                            <p class="product-text"><%= displayDescription %></p>
                            <div class="product-meta">
                                <div class="product-author">
                                    <div class="author-content">
                                        <h4 class="h5 author-title">
                                            <%= nft.getCreatorId() != null ? "Creator #" + nft.getCreatorId() : "Unknown Creator" %>
                                        </h4>
                                        <span class="author-username">@naft</span>
                                    </div>
                                </div>
                                <div class="product-price">
                                    <data value="<%= nft.getPrice() != null ? nft.getPrice() : 0 %>"><%= displayPrice %></data>
                                    <p class="label">Price</p>
                                </div>
                            </div>
                            <div class="product-footer">
                                <p class="total-bid">
                                    Listed <%= nft.getUpdatedAt() != null ? nft.getUpdatedAt().toLocalDate() : "recently" %>
                                </p>
                                <button class="tag">View details</button>
                            </div>
                        </div>
                    </div>
                </li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </section>
</main>

<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>
</html>
