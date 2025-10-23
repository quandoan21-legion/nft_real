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
