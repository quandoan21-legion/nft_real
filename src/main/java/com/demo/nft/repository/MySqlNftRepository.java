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

                ps.setString(1, "123");
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
                    ps.setLong(8, 1);
                } else {
                    ps.setNull(8, Types.BIGINT);
                }
                if (nft.getCategoryId() != null) {
                    ps.setLong(9, nft.getCategoryId());
                } else {
                    ps.setNull(9, Types.BIGINT);
                }

                ps.setString(10, nft.getStatus() != null ? nft.getStatus().name() : null);
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
        return null;
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public Nft findById(int id) {
        return null;
    }

    @Override
    public Nft findByUsername(String username) {
        return null;
    }

    @Override
    public List<Nft> findAll() {
        List<Nft> list = new ArrayList<>();
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at FROM nfts";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Nft nft = new Nft();
                nft.setCode(rs.getString("code"));
                nft.setName(rs.getString("name"));
                nft.setDescription(rs.getString("description"));
                nft.setThumbnailUrl(rs.getString("thumbnail_url"));
                nft.setPrice(rs.getFloat("price"));
                nft.setCurrency(rs.getString("currency"));
                nft.setCreatorId(rs.getLong("creator_id"));
                nft.setOwnerId(rs.getLong("owner_id"));
                nft.setCategoryId(rs.getLong("category_id"));
//                nft.setStatus(rs.get("status"));
                list.add(nft);
            }


            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
