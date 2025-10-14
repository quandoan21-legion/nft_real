<%@ page import="com.demo.nft.entity.Nft" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NAFT - NFT Markeplace</title>

    <!--
      - favicon
    -->
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon">

    <!--
      - custom css link
    -->
    <link rel="stylesheet" href="../assets/css/style.css">

    <!--
      - google font link
    -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>

<body id="top">

<!--
  - #HEADER
-->

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
                            <a href="#" class="navbar-link">Home</a>
                        </li>

                        <li>
                            <a href="#" class="navbar-link">About</a>
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

<!-- MAIN CONTENT -->
<main>
    <section class="create-nft-section">
        <div class="container">
            <div class="form-container">
                <h1 class="h2 form-title">Create New NFT</h1>
                <p class="form-subtitle">Upload your unique digital artwork and list it on the marketplace</p>

                <form action="create-nft" method="POST" enctype="multipart/form-data" id="createNftForm">

                    <!-- Image Upload -->
                    <div class="form-group">
                        <label class="form-label">
                            NFT Image <span class="required">*</span>
                        </label>
                        <div class="image-upload-area" id="imageUploadArea">
                            <ion-icon name="cloud-upload-outline" class="upload-icon"></ion-icon>
                            <p class="upload-text">Click to upload or drag and drop</p>
                            <p class="upload-subtext">PNG, JPG, GIF up to 10MB</p>
                            <input type="file" name="thumbnail" id="thumbnailInput" accept="image/*"
                                   style="display: none;" required>
                        </div>
                        <div class="image-preview" id="imagePreview">
                            <img src="" alt="Preview" id="previewImg">
                        </div>
                        <span class="error-message" id="thumbnailError">Please upload an image</span>
                    </div>

                    <!-- NFT Name -->
                    <div class="form-group">
                        <label for="nftName" class="form-label">
                            NFT Name <span class="required">*</span>
                        </label>
                        <input
                                type="text"
                                id="nftName"
                                name="name"
                                class="form-input"
                                placeholder="e.g. 'Rare Digital Artwork #001'"
                                maxlength="100"
                                required>
                        <span class="form-help-text">Max 100 characters</span>
                        <span class="error-message" id="nameError">NFT name is required</span>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description" class="form-label">
                            Description <span class="required">*</span>
                        </label>
                        <textarea
                                id="description"
                                name="description"
                                class="form-textarea"
                                placeholder="Describe your NFT in detail..."
                                maxlength="1000"
                                required></textarea>
                        <span class="form-help-text">Max 1000 characters</span>
                        <span class="error-message" id="descriptionError">Description is required</span>
                    </div>

                    <!-- Price and Currency -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="price" class="form-label">
                                Price <span class="required">*</span>
                            </label>
                            <input
                                    type="number"
                                    id="price"
                                    name="price"
                                    class="form-input"
                                    placeholder="0.00"
                                    step="0.001"
                                    min="0"
                                    required>
                            <span class="error-message" id="priceError">Price must be greater than 0</span>
                        </div>

                        <div class="form-group">
                            <label for="currency" class="form-label">
                                Currency <span class="required">*</span>
                            </label>
                            <select id="currency" name="currency" class="form-select" required>
                                <option value="ETH">ETH - Ethereum</option>
                                <option value="BTC">BTC - Bitcoin</option>
                                <option value="BNB">BNB - Binance Coin</option>
                                <option value="SOL">SOL - Solana</option>
                                <option value="MATIC">MATIC - Polygon</option>
                                <option value="USD">USD - US Dollar</option>
                            </select>
                        </div>
                    </div>

                    <!-- Category -->
                    <div class="form-group">
                        <label for="category" class="form-label">
                            Category <span class="required">*</span>
                        </label>
                        <select id="category" name="categoryId" class="form-select" required>
                            <option value="">Select a category</option>
                            <option value="1">Art</option>
                            <option value="2">Photography</option>
                            <option value="3">Gaming</option>
                            <option value="4">Music</option>
                            <option value="5">Video</option>
                            <option value="6">Collectibles</option>
                            <option value="7">Sports</option>
                            <option value="8">Utility</option>
                        </select>
                        <span class="error-message" id="categoryError">Please select a category</span>
                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <label for="status" class="form-label">
                            Status <span class="required">*</span>
                        </label>
                        <select id="status" name="status" class="form-select" required>
                            <option value="ON_SALE">On Sale</option>
                            <option value="NOT_FOR_SALE">Not For Sale</option>
                        </select>
                    </div>

                    <!-- NFT Code (Auto-generated, optional display) -->
                    <input type="hidden" name="code" value="">

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="button" class="btn btn-cancel" onclick="window.location.href='index1.jsp'">
                            Cancel
                        </button>
                        <button type="submit" class="btn btn-primary btn-submit">
                            Create NFT
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </section>
</main>
<!--
  - #FOOTER
-->

<footer>

    <div class="footer-top">
        <div class="container">

            <div class="footer-brand">

                <a href="#" class="logo">
                    <img src="./assets/images/logo.png" alt="NAFT logo">
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


<!--
  - #GO TO TOP
-->

<a href="#top" class="go-top" data-go-top>
    <ion-icon name="arrow-up-outline"></ion-icon>
</a>


<!--
  - custom js link
-->
<script src="./assets/js/script.js"></script>

<!--
  - ionicon link
-->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>

</html>