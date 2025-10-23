-- Database and user provisioning for the NFT marketplace application
CREATE DATABASE IF NOT EXISTS nft_market
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'nft_app'@'%' IDENTIFIED BY 'nft_app_password';
GRANT ALL PRIVILEGES ON nft_market.* TO 'nft_app'@'%';
FLUSH PRIVILEGES;

USE nft_market;

-- Drop tables in reverse order of dependencies to allow reruns of this script
DROP TABLE IF EXISTS nfts;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  email VARCHAR(255),
  role ENUM('ADMIN', 'ARTIST', 'VIEWER') NOT NULL DEFAULT 'VIEWER',
  status ENUM('ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  primary_wallet_address VARCHAR(255),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by BIGINT UNSIGNED,
  updated_by BIGINT UNSIGNED,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_username (username),
  UNIQUE KEY uq_users_email (email),
  CONSTRAINT fk_users_created_by FOREIGN KEY (created_by) REFERENCES users (id),
  CONSTRAINT fk_users_updated_by FOREIGN KEY (updated_by) REFERENCES users (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by BIGINT UNSIGNED,
  updated_by BIGINT UNSIGNED,
  PRIMARY KEY (id),
  UNIQUE KEY uq_categories_name (name),
  CONSTRAINT fk_categories_created_by FOREIGN KEY (created_by) REFERENCES users (id),
  CONSTRAINT fk_categories_updated_by FOREIGN KEY (updated_by) REFERENCES users (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE nfts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(64) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_url VARCHAR(512),
  price DECIMAL(18, 2),
  currency VARCHAR(16),
  creator_id BIGINT UNSIGNED,
  owner_id BIGINT UNSIGNED,
  category_id BIGINT UNSIGNED,
  status TINYINT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_by BIGINT UNSIGNED,
  updated_by BIGINT UNSIGNED,
  PRIMARY KEY (id),
  UNIQUE KEY uq_nfts_code (code),
  KEY idx_nfts_creator_id (creator_id),
  KEY idx_nfts_owner_id (owner_id),
  KEY idx_nfts_category_id (category_id),
  CONSTRAINT fk_nfts_creator FOREIGN KEY (creator_id) REFERENCES users (id),
  CONSTRAINT fk_nfts_owner FOREIGN KEY (owner_id) REFERENCES users (id),
  CONSTRAINT fk_nfts_category FOREIGN KEY (category_id) REFERENCES categories (id),
  CONSTRAINT fk_nfts_created_by FOREIGN KEY (created_by) REFERENCES users (id),
  CONSTRAINT fk_nfts_updated_by FOREIGN KEY (updated_by) REFERENCES users (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------------
-- Sample seed data for local development
-- ---------------------------------------------------------------------------

INSERT INTO users (id, username, password_hash, full_name, email, role, status, primary_wallet_address)
VALUES
  (1, 'demo_artist', '$2a$10$7EqJtq98hPqEX7fNZaFWo.OPN2sWZ2pX6Ch0eYRqpMfrGXy8Nx5Km', 'Demo Artist', 'artist@example.com', 'ARTIST', 'ACTIVE', '0x4cB1a123456789ABCDEF00112233445566778899'),
  (2, 'demo_collector', '$2a$10$7EqJtq98hPqEX7fNZaFWo.OPN2sWZ2pX6Ch0eYRqpMfrGXy8Nx5Km', 'Demo Collector', 'collector@example.com', 'VIEWER', 'ACTIVE', '0x9fE2b9876543210FEDCBA09876543210FEDCBA09');

INSERT INTO categories (id, name, description, created_by, updated_by)
VALUES
  (1, 'Art', 'Fine digital art and illustrations.', 1, 1),
  (2, 'Gaming', 'In-game assets and collectibles.', 1, 1),
  (3, 'Photography', 'High-quality photography pieces.', 1, 1),
  (4, 'Music', 'Audio tracks and soundscapes.', 1, 1),
  (5, 'Sports', 'Sports memorabilia and highlights.', 1, 1),
  (6, 'Collectibles', 'Unique collectible NFTs.', 1, 1);

INSERT INTO nfts (id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_by, updated_by)
VALUES
  (1, 'NAFT-0001', 'Stellar Voyage', 'A shimmering exploration of cosmic colors rendered in 4K resolution.', 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=80', 2.50, 'ETH', 1, 2, 1, 1, 1, 1);
