<%@ page import="com.demo.nft.entity.Nft" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit NFT - NAFT</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/form.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
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
                        <li><a href="${pageContext.request.contextPath}/profile" class="navbar-link">My Collection</a></li>
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
        <section class="hero">
            <div class="container">
                <div class="form-header">
                    <h1>Edit Your NFT</h1>
                    <p>Update the details of your digital artwork</p>
                </div>

                <form class="create-form"
                      id="nftEditForm"
                      action="${pageContext.request.contextPath}/nfts/edit"
                      method="POST">
                    <input type="hidden" name="id" value="${requestScope.nftId}">

                    <div class="form-group">
                        <label for="name">NFT Name <span class="required">*</span></label>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               value="${requestScope.formData.name}"
                               placeholder="Enter NFT name"
                               required>
                        <span class="error-message" style="${empty requestScope.errors.name ? 'display:none;' : ''}">
                            ${requestScope.errors.name}
                        </span>
                    </div>

                    <div class="form-group">
                        <label for="description">Description <span class="required">*</span></label>
                        <textarea id="description"
                                  name="description"
                                  class="form-control"
                                  placeholder="Describe your NFT artwork..."
                                  required>${requestScope.formData.description}</textarea>
                        <span class="error-message" style="${empty requestScope.errors.description ? 'display:none;' : ''}">
                            ${requestScope.errors.description}
                        </span>
                    </div>

                    <div class="form-group">
                        <label for="thumbnail">Thumbnail URL <span class="required">*</span></label>
                        <input type="text"
                               id="thumbnail"
                               name="thumbnail"
                               class="form-control"
                               placeholder="Enter NFT Image Link"
                               value="${requestScope.formData.thumbnail}"
                               required>
                        <span class="error-message" style="${empty requestScope.errors.thumbnail ? 'display:none;' : ''}">
                            ${requestScope.errors.thumbnail}
                        </span>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price <span class="required">*</span></label>
                            <input type="text"
                                   id="price"
                                   name="price"
                                   class="form-control"
                                   value="${requestScope.formData.price}"
                                   required>
                            <span class="error-message" style="${empty requestScope.errors.price ? 'display:none;' : ''}">
                                ${requestScope.errors.price}
                            </span>
                        </div>

                        <div class="form-group">
                            <label for="currency">Currency <span class="required">*</span></label>
                            <select id="currency" name="currency" class="form-control" required>
                                <option value="">Select currency</option>
                                <option value="ETH" <c:if test="${requestScope.formData.currency == 'ETH'}">selected</c:if>>ETH - Ethereum</option>
                                <option value="BTC" <c:if test="${requestScope.formData.currency == 'BTC'}">selected</c:if>>BTC - Bitcoin</option>
                                <option value="USDT" <c:if test="${requestScope.formData.currency == 'USDT'}">selected</c:if>>USDT - Tether</option>
                                <option value="BNB" <c:if test="${requestScope.formData.currency == 'BNB'}">selected</c:if>>BNB - Binance Coin</option>
                            </select>
                            <span class="error-message" style="${empty requestScope.errors.currency ? 'display:none;' : ''}">
                                ${requestScope.errors.currency}
                            </span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="categoryId">Category <span class="required">*</span></label>
                        <select id="categoryId" name="categoryId" class="form-control" required>
                            <option value="">Select category</option>
                            <option value="1" <c:if test="${requestScope.formData.categoryId == '1'}">selected</c:if>>Art</option>
                            <option value="2" <c:if test="${requestScope.formData.categoryId == '2'}">selected</c:if>>Gaming</option>
                            <option value="3" <c:if test="${requestScope.formData.categoryId == '3'}">selected</c:if>>Photography</option>
                            <option value="4" <c:if test="${requestScope.formData.categoryId == '4'}">selected</c:if>>Music</option>
                            <option value="5" <c:if test="${requestScope.formData.categoryId == '5'}">selected</c:if>>Sports</option>
                            <option value="6" <c:if test="${requestScope.formData.categoryId == '6'}">selected</c:if>>Collectibles</option>
                        </select>
                        <span class="error-message" style="${empty requestScope.errors.categoryId ? 'display:none;' : ''}">
                            ${requestScope.errors.categoryId}
                        </span>
                    </div>

                    <div class="form-group">
                        <label for="status">Status <span class="required">*</span></label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="1" <c:if test="${requestScope.formData.status == '1'}">selected</c:if>>On Sale</option>
                            <option value="0" <c:if test="${requestScope.formData.status == '0'}">selected</c:if>>Not For Sale</option>
                        </select>
                        <span class="error-message" style="${empty requestScope.errors.status ? 'display:none;' : ''}">
                            ${requestScope.errors.status}
                        </span>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/profile">Cancel</a>
                    </div>
                </form>
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

</body>
</html>
