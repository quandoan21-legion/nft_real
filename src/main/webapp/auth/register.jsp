<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.demo.nft.entity.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - NAFT</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
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
<%--                        <li><a href="${pageContext.request.contextPath}/home" class="navbar-link">Home</a></li>--%>
<%--                        <li><a href="${pageContext.request.contextPath}/nfts" class="navbar-link">Explore</a></li>--%>
<%--                        <li><a href="${pageContext.request.contextPath}/nfts/create" class="navbar-link">Create NFT</a></li>--%>
<%--                        <li><a href="${pageContext.request.contextPath}/register" class="navbar-link">Register</a></li>--%>
<%--                        <li><a href="${pageContext.request.contextPath}/login" class="navbar-link">Login</a></li>--%>
                    </ul>
                </nav>
            </div>
            <div class="header-actions">
                <input type="search" placeholder="Search" class="search-field">
                <%
                    Object currentUserAttr = session.getAttribute("currentUser");
                    User navUser = currentUserAttr instanceof User ? (User) currentUserAttr : null;
                    String navUsername = (navUser != null && navUser.getUsername() != null && !navUser.getUsername().isBlank())
                            ? navUser.getUsername()
                            : "Profile";
                    if (navUser != null) {
                %>
                <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">
                    <%= navUsername %>
                </a>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline-block; margin-left:0.5rem;">
                    <button type="submit" class="btn btn-secondary">Logout</button>
                </form>
                <%
                    } else {
                %>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Sign in</a>
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
                    <h1>Create Your Account</h1>
                    <p>Join the NAFT community to discover, collect, and sell extraordinary NFTs.</p>
                </div>
                <form class="create-form" action="${pageContext.request.contextPath}/register" method="POST" novalidate>
                    <div class="form-group">
                        <label for="username">Username <span class="required">*</span></label>
                        <input type="text"
                               id="username"
                               name="username"
                               class="form-control"
                               value="${requestScope.form.username}"
                               required>
                        <span class="error-message" style="${empty requestScope.errors.username ? 'display:none;' : ''}">${requestScope.errors.username}</span>
                    </div>

                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text"
                               id="fullName"
                               name="fullName"
                               class="form-control"
                               value="${requestScope.form.fullName}">
                        <span class="error-message" style="${empty requestScope.errors.fullName ? 'display:none;' : ''}">${requestScope.errors.fullName}</span>
                    </div>

                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-control"
                               value="${requestScope.form.email}"
                               required>
                        <span class="error-message" style="${empty requestScope.errors.email ? 'display:none;' : ''}">${requestScope.errors.email}</span>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password <span class="required">*</span></label>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   class="form-control"
                                   required>
                            <span class="error-message" style="${empty requestScope.errors.password ? 'display:none;' : ''}">${requestScope.errors.password}</span>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   class="form-control"
                                   required>
                            <span class="error-message" style="${empty requestScope.errors.confirmPassword ? 'display:none;' : ''}">${requestScope.errors.confirmPassword}</span>
                        </div>
                    </div>

                    <div class="form-group notice">
                        <span class="error-message" style="${empty requestScope.errors.global ? 'display:none;' : ''}">${requestScope.errors.global}</span>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Register</button>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">Already have an account?</a>
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
