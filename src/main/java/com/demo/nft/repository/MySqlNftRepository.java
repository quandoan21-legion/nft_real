package com.demo.nft.repository;

import com.demo.nft.entity.Nft;
import com.demo.nft.helper.MySqlHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import static com.demo.nft.helper.MySqlHelper.getConnection;

public class MySqlNftRepository implements NftRepository {
    private static MySqlHelper mySqlHelper = new MySqlHelper();

    @Override
    public Nft save(Nft nft) {
        String sql = "INSERT INTO nfts (code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at, created_by, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                Timestamp now = Timestamp.valueOf(java.time.LocalDateTime.now());
                Timestamp createdAt = nft.getCreatedAt() != null ? Timestamp.valueOf(nft.getCreatedAt()) : now;
                Timestamp updatedAt = nft.getUpdatedAt() != null ? Timestamp.valueOf(nft.getUpdatedAt()) : now;
                Long currentTimestamp = System.currentTimeMillis();
                ps.setString(1, String.valueOf(currentTimestamp));
                ps.setString(2, nft.getName());
                ps.setString(3, nft.getDescription());
                ps.setString(4, nft.getThumbnailUrl());
                if (nft.getPrice() != null) {
                    ps.setFloat(5, nft.getPrice());
                } else {
                    ps.setNull(5, Types.FLOAT);
                }
                ps.setString(6, nft.getCurrency());

                if (nft.getCreatorId() != null) {
                    ps.setLong(7, nft.getCreatorId());
                } else {
                    ps.setNull(7, Types.BIGINT);
                }
                if (nft.getOwnerId() != null) {
                    ps.setLong(8, nft.getOwnerId());
                } else {
                    ps.setNull(8, Types.BIGINT);
                }
                if (nft.getCategoryId() != null) {
                    ps.setLong(9, nft.getCategoryId());
                } else {
                    ps.setNull(9, Types.BIGINT);
                }

                ps.setInt(10, nft.getStatus());
                ps.setTimestamp(11, createdAt);
                ps.setTimestamp(12, updatedAt);

                if (nft.getCreatedBy() != null) {
                    ps.setLong(13, nft.getCreatedBy());
                } else {
                    ps.setNull(13, Types.BIGINT);
                }
                if (nft.getUpdatedBy() != null) {
                    ps.setLong(14, nft.getUpdatedBy());
                } else {
                    ps.setNull(14, Types.BIGINT);
                }

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Lưu NFT thất bại, không có bản ghi nào được tạo.");
                }

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        nft.setId(rs.getLong(1));
                    }
                }

                nft.setCreatedAt(createdAt.toLocalDateTime());
                nft.setUpdatedAt(updatedAt.toLocalDateTime());

                return nft;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể lưu NFT: " + e.getMessage(), e);
        }
    }

    @Override
    public Nft update(int id, Nft nft) {
        String sql = "UPDATE nfts SET name = ?, description = ?, thumbnail_url = ?, price = ?, currency = ?, category_id = ?, status = ?, updated_at = ?, updated_by = ?, owner_id = ? WHERE id = ?";

        try {
            Connection conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                Timestamp now = Timestamp.valueOf(java.time.LocalDateTime.now());
                Timestamp updatedAt = nft.getUpdatedAt() != null ? Timestamp.valueOf(nft.getUpdatedAt()) : now;

                ps.setString(1, nft.getName());
                ps.setString(2, nft.getDescription());
                ps.setString(3, nft.getThumbnailUrl());
                if (nft.getPrice() != null) {
                    ps.setFloat(4, nft.getPrice());
                } else {
                    ps.setNull(4, Types.FLOAT);
                }
                ps.setString(5, nft.getCurrency());
                if (nft.getCategoryId() != null) {
                    ps.setLong(6, nft.getCategoryId());
                } else {
                    ps.setNull(6, Types.BIGINT);
                }
                ps.setInt(7, nft.getStatus());
                ps.setTimestamp(8, updatedAt);
                if (nft.getUpdatedBy() != null) {
                    ps.setLong(9, nft.getUpdatedBy());
                } else {
                    ps.setNull(9, Types.BIGINT);
                }
                if (nft.getOwnerId() != null) {
                    ps.setLong(10, nft.getOwnerId());
                } else {
                    ps.setNull(10, Types.BIGINT);
                }
                ps.setInt(11, id);

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    return null;
                }

                nft.setId((long) id);
                nft.setUpdatedAt(updatedAt.toLocalDateTime());
                return nft;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể cập nhật NFT: " + e.getMessage(), e);
        }
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public Nft findById(int id) {
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at, created_by, updated_by FROM nfts WHERE id = ?";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return mapRowToNft(rs);
                    }
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể tìm NFT: " + e.getMessage(), e);
        }
    }

    @Override
    public Nft findByUsername(String username) {
        return null;
    }

    @Override
    public List<Nft> findAll() {
        List<Nft> list = new ArrayList<>();
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at, created_by, updated_by FROM nfts";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRowToNft(rs));
            }

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public List<Nft> findByStatus(int status) {
        List<Nft> list = new ArrayList<>();
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at, created_by, updated_by FROM nfts WHERE status = ?";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, status);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapRowToNft(rs));
                    }
                }
            }

                return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Nft> findByOwnerId(Long ownerId) {
        List<Nft> list = new ArrayList<>();
        if (ownerId == null) {
            return list;
        }
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at, created_by, updated_by FROM nfts WHERE owner_id = ?";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setLong(1, ownerId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapRowToNft(rs));
                    }
                }
            }

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Nft mapRowToNft(ResultSet rs) throws SQLException {
        Nft nft = new Nft();
        nft.setId(rs.getLong("id"));
        nft.setCode(rs.getString("code"));
        nft.setName(rs.getString("name"));
        nft.setDescription(rs.getString("description"));
        nft.setThumbnailUrl(rs.getString("thumbnail_url"));
        float price = rs.getFloat("price");
        if (rs.wasNull()) {
            nft.setPrice(null);
        } else {
            nft.setPrice(price);
        }
        nft.setCurrency(rs.getString("currency"));
        long creatorId = rs.getLong("creator_id");
        if (!rs.wasNull()) {
            nft.setCreatorId(creatorId);
        }
        long ownerId = rs.getLong("owner_id");
        if (!rs.wasNull()) {
            nft.setOwnerId(ownerId);
        }
        long categoryId = rs.getLong("category_id");
        if (!rs.wasNull()) {
            nft.setCategoryId(categoryId);
        }
        Object statusValue = rs.getObject("status");
        if (statusValue instanceof Number numberStatus) {
            nft.setStatus(numberStatus.intValue());
        } else if (statusValue instanceof String stringStatus) {
            if ("ON_SALE".equalsIgnoreCase(stringStatus)) {
                nft.setStatus(Nft.STATUS_ON_SALE);
            } else if ("NOT_FOR_SALE".equalsIgnoreCase(stringStatus)) {
                nft.setStatus(Nft.STATUS_NOT_FOR_SALE);
            } else {
                try {
                    nft.setStatus(Integer.parseInt(stringStatus));
                } catch (NumberFormatException e) {
                    throw new SQLException("Unsupported status value: " + stringStatus, e);
                }
            }
        } else if (statusValue != null) {
            throw new SQLException("Unsupported status type: " + statusValue.getClass());
        }
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            nft.setCreatedAt(createdAt.toLocalDateTime());
        }
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            nft.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        long createdBy = rs.getLong("created_by");
        if (!rs.wasNull()) {
            nft.setCreatedBy(createdBy);
        }
        long updatedBy = rs.getLong("updated_by");
        if (!rs.wasNull()) {
            nft.setUpdatedBy(updatedBy);
        }
        return nft;
    }
}
