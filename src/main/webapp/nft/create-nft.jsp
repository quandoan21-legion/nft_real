<%@ page import="java.util.List" %>
<%@ page import="com.demo.nft.entity.Nft" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create NFT - NAFT</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/form.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>


<header>

    <div class="container">

        <a href="#" class="logo">
            <img src="../assets/images/logo.png" alt="NAFT logo">
        </a>

        <div class="header-right">

            <div class="header-nav-wrapper">

                <button class="navbar-toggle-btn" data-navbar-toggle-btn>
                    <ion-icon name="menu-outline"></ion-icon>
                </button>

                <nav class="navbar" data-navbar>

                    <ul class="navbar-list">

                        <li>
                            <a href="/" class="navbar-link">Home</a>
                        </li>

                        <li>
                            <a href="/nfts/create" class="navbar-link">About</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">Explore</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">Creators</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">Collections</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">Blog</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">Contact</a>
                        </li>

                    </ul>

                </nav>

            </div>

            <div class="header-actions">
                <input type="search" placeholder="Search" class="search-field">

                <button class="btn btn-primary">Sign in</button>
            </div>

        </div>

    </div>

</header>


<main>

    <article>

        <!--
          - #HERO
        -->

        <section class="hero">
            <div class="container">
                <div class="form-header">
                    <h1>Create Your NFT</h1>
                    <p>Fill in the details below to mint your digital artwork</p>
                </div>

                <form class="create-form" id="nftForm" action="/nfts/create" method="POST" enctype="application/x-www-form-urlencoded">

                    <!-- NFT Name -->
                    <div class="form-group">
                        <label for="name">NFT Name <span class="required">*</span></label>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               placeholder="Enter NFT name"
                               required>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">Description <span class="required">*</span></label>
                        <textarea id="description"
                                  name="description"
                                  class="form-control"
                                  placeholder="Describe your NFT artwork..."
                                  required></textarea>
                        <small class="helper-text">Provide a detailed description of your NFT</small>
                    </div>

                    <!-- Thumbnail Upload -->
                    <div class="form-group">
                        <label for="name">Thumbnails <span class="required">*</span></label>
                        <input type="text"
                               id="thumbnail"
                               name="thumbnail"
                               class="form-control"
                               placeholder="Enter NFT Image Link"
                               required>
                    </div>

                    <!-- Price and Currency Row -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price <span class="required">*</span></label>
                            <input type="text"
                                   id="price"
                                   name="price"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="currency">Currency <span class="required">*</span></label>
                            <select id="currency" name="currency" class="form-control" required>
                                <option value="">Select currency</option>
                                <option value="ETH">ETH - Ethereum</option>
                                <option value="BTC">BTC - Bitcoin</option>
                                <option value="USDT">USDT - Tether</option>
                                <option value="BNB">BNB - Binance Coin</option>
                            </select>
                        </div>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label for="categoryId">Category <span class="required">*</span></label>
                        <select id="categoryId" name="categoryId" class="form-control" required>
                            <option value="">Select category</option>
                            <option value="1">Art</option>
                            <option value="2">Gaming</option>
                            <option value="3">Photography</option>
                            <option value="4">Music</option>
                            <option value="5">Sports</option>
                            <option value="6">Collectibles</option>
                        </select>
                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <label for="status">Status <span class="required">*</span></label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="ON_SALE">On Sale</option>
                            <option value="NOT_FOR_SALE">Not For Sale</option>
                        </select>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Create NFT</button>
                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
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

                <a href="#" class="logo">
                    <img src="../assets/images/logo.png" alt="NAFT logo">
                </a>

                <p class="footer-brand-text">
                    There are many variations of passages of but the majority have suffered alterations cted humour, or
                    randomsed words
                    which htly believable. If you are going
                </p>

                <h3 class="h4 social-title">Join the community</h3>

                <ul class="social-list">

                    <li>
                        <a href="https://github.com/codewithsadee" class="social-link">
                            <ion-icon name="logo-github"></ion-icon>
                        </a>
                    </li>

                    <li>
                        <a href="https://twitter.com/codewithsadee" class="social-link">
                            <ion-icon name="logo-twitter"></ion-icon>
                        </a>
                    </li>

                    <li>
                        <a href="https://www.instagram.com/codewithsadee/" class="social-link">
                            <ion-icon name="logo-instagram"></ion-icon>
                        </a>
                    </li>

                    <li>
                        <a href="https://www.youtube.com/c/codewithsadee" class="social-link">
                            <ion-icon name="logo-youtube"></ion-icon>
                        </a>
                    </li>

                </ul>

            </div>

            <div class="footer-link-box">

                <ul class="footer-list">

                    <li>
                        <h3 class="h3 footer-item-title">Marketplace</h3>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Gaming</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Product</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">All NFTs</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Social Network</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Domain Names</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Collectibles</a>
                    </li>

                </ul>

                <ul class="footer-list">

                    <li>
                        <h3 class="h3 footer-item-title">Explore</h3>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Featured Drops</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Live Auctions</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">All NFTs</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Collections</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Top Seller</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Items Details</a>
                    </li>

                </ul>

                <ul class="footer-list">

                    <li>
                        <h3 class="h3 footer-item-title">Supports</h3>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Settings & Privacy</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Help & Support</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Live Auctions</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Item Details</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">24/7 Supports</a>
                    </li>

                    <li class="footer-item">
                        <a href="#" class="footer-link">Blog</a>
                    </li>

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


<script>
    // Image preview functionality
    const fileInput = document.getElementById('thumbnailFile');
    const previewContainer = document.getElementById('previewContainer');
    const previewImage = document.getElementById('previewImage');

    fileInput.addEventListener('change', function (e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (event) {
                previewImage.src = event.target.result;
                previewContainer.classList.add('active');
            };
            reader.readAsDataURL(file);
        }
    });

    // Form validation
    document.getElementById('nftForm').addEventListener('submit', function (e) {
        const price = document.getElementById('price').value;
        if (parseFloat(price) < 0) {
            e.preventDefault();
            alert('Price must be greater than or equal to 0');
            return false;
        }
    });
</script>
</body>
</html>